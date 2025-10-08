from flask import Blueprint, request, jsonify, render_template
from extensions.extensions import get_db_connection, mail
from flask_mail import Message
from uuid import uuid4
from datetime import datetime, timedelta
from middleware.admin_auth import verify_admin_token
import random
import math
import json
import string

admin_bp = Blueprint("admin_bp", __name__, template_folder="../templates")


def generate_random_password(length=16):
    """
    Generate a random password with letters, digits, and punctuation
    """
    chars = string.ascii_letters + string.digits + "!@#$%^&*()-_=+"
    return "".join(random.choice(chars) for _ in range(length))


def send_membership_email(to_email, membership_data):
    """
    Sends membership granted email using Flask-Mail
    """
    username = membership_data["username"]
    tier_name = membership_data["tier_name"]
    months = membership_data["months"]
    expires_at = membership_data["expires_at"]
    storefront_credentials = membership_data.get("storefront_credentials")
    is_first_time_member = membership_data.get("is_first_time_member", False)

    msg = Message(
        subject=f"🎉 {tier_name.upper()} Membership Granted - RippleBids",
        sender=("RippleBids", "noreply.dropapp@gmail.com"),
        recipients=[to_email]
    )
    msg.html = render_template(
        "membership_granted.html",
        username=username,
        tier_name=tier_name,
        months=months,
        expires_at=expires_at,
        storefront_credentials=storefront_credentials,
        is_first_time_member=is_first_time_member,
        datetime=datetime
    )
    mail.send(msg)


@admin_bp.route("/memberships", methods=["POST"])
def grant_membership():
    """
    Grant membership to a user by email and send email
    """
    auth_header = request.headers.get("Authorization", "")
    token = auth_header.replace("Bearer ", "")
    auth_result = verify_admin_token(auth_header)
    if not auth_result["success"]:
        return jsonify({"error": auth_result["error"]}), auth_result["status"]

    data = request.json
    user_email = data.get("email")  # <-- Use email now
    tier_name = data.get("tierName")
    months = data.get("months")

    if not user_email or not tier_name or not months:
        return jsonify({"error": "Email, tier name, and months are required"}), 400

    if tier_name.lower() not in ["pro", "premium"]:
        return jsonify({"error": "Invalid tier name. Must be pro or premium"}), 400

    if not (1 <= months <= 120):
        return jsonify({"error": "Months must be between 1 and 120"}), 400

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        # Fetch user by email
        cursor.execute("SELECT id, email, username FROM users WHERE email = %s", (user_email,))
        user = cursor.fetchone()
        if not user:
            return jsonify({"error": "User not found"}), 404

        # Fetch membership tier
        cursor.execute("SELECT id, name, price FROM membership_tiers WHERE name = %s", (tier_name.lower(),))
        tier = cursor.fetchone()
        if not tier:
            return jsonify({"error": "Membership tier not found"}), 404

        # Check for existing active membership
        cursor.execute(
            "SELECT * FROM user_memberships WHERE user_id = %s AND is_active = TRUE",
            (user["id"],)
        )
        active_membership = cursor.fetchone()

        if active_membership:
            # Always calculate from current date, not from old expiry date
            new_expires_at = datetime.utcnow() + timedelta(days=30*int(months))
            cursor.execute(
                "UPDATE user_memberships SET expires_at = %s WHERE id = %s",
                (new_expires_at, active_membership["id"])
            )
        else:
            # Create new membership
            new_expires_at = datetime.utcnow() + timedelta(days=30*int(months))
            membership_id = str(uuid4())
            cursor.execute(
                """
                INSERT INTO user_memberships
                (id, user_id, membership_tier_id, price, transaction_hash, expires_at, is_active)
                VALUES (%s, %s, %s, %s, %s, %s, TRUE)
                """,
                (membership_id, user["id"], tier["id"], 0, "ADMIN_GRANTED", new_expires_at)
            )

        # Handle storefront login
        cursor.execute("SELECT * FROM storefront_logins WHERE user_id = %s", (user["id"],))
        storefront = cursor.fetchone()
        is_first_time_member = False

        if storefront:
            # Update expiry
            cursor.execute(
                "UPDATE storefront_logins SET expires_at = %s, expired = FALSE WHERE user_id = %s",
                (new_expires_at, user["id"])
            )
            storefront_credentials = {
                "email": storefront["email"],
                "password": storefront["generated_password"],
                "expires_at": new_expires_at
            }
        else:
            # Create new credentials
            is_first_time_member = True
            generated_password = generate_random_password(16)
            storefront_id = str(uuid4())
            cursor.execute(
                """
                INSERT INTO storefront_logins (id, user_id, email, generated_password, expires_at, expired)
                VALUES (%s, %s, %s, %s, %s, FALSE)
                """,
                (storefront_id, user["id"], user["email"], generated_password, new_expires_at)
            )
            storefront_credentials = {
                "email": user["email"],
                "password": generated_password,
                "expires_at": new_expires_at
            }

        conn.commit()

        membership_data = {
            "username": user["username"],
            "tier_name": tier["name"],
            "months": months,
            "expires_at": new_expires_at,
            "storefront_credentials": storefront_credentials,
            "is_first_time_member": is_first_time_member
        }

        # Send email
        try:
            send_membership_email(user["email"], membership_data)
            email_sent = True
        except Exception as e:
            print("Email sending failed:", e)
            email_sent = False

        return jsonify({
            "message": "Membership granted successfully",
            "membership": {
                "tier": tier["name"],
                "expires_at": new_expires_at,
                "is_first_time_member": is_first_time_member,
                "email_sent": email_sent
            }
        })

    except Exception as e:
        conn.rollback()
        return jsonify({"error": "Failed to grant membership", "details": str(e)}), 500

    finally:
        cursor.close()
        conn.close()


@admin_bp.route("/memberships", methods=["GET"])
def get_memberships():
    """
    Fetch memberships for admin view
    """
    auth_header = request.headers.get("Authorization", "")
    token = auth_header.replace("Bearer ", "")
    auth_result = verify_admin_token(auth_header)
    if not auth_result["success"]:
        return jsonify({"error": auth_result["error"]}), auth_result["status"]

    limit = int(request.args.get("limit", 50))
    offset = int(request.args.get("offset", 0))
    tier = request.args.get("tier")
    status = request.args.get("status")
    search = request.args.get("search")

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        where_clause = "WHERE 1=1"
        params = []

        if tier and tier.lower() != "all":
            where_clause += " AND mt.name = %s"
            params.append(tier.lower())

        if status and status.lower() != "all":
            if status.lower() == "active":
                where_clause += " AND um.is_active = TRUE AND (um.expires_at IS NULL OR um.expires_at > NOW())"
            elif status.lower() == "expired":
                where_clause += " AND (um.is_active = FALSE OR um.expires_at < NOW())"

        if search:
            where_clause += " AND (u.username LIKE %s OR u.email LIKE %s)"
            params.extend([f"%{search}%", f"%{search}%"])

        query = f"""
            SELECT 
                um.id,
                um.user_id,
                um.price,
                um.transaction_hash,
                um.expires_at,
                um.is_active,
                um.created_at,
                u.username,
                u.email AS user_email,
                mt.name AS tier_name,
                mt.features
            FROM user_memberships um
            JOIN users u ON um.user_id = u.id
            JOIN membership_tiers mt ON um.membership_tier_id = mt.id
            {where_clause}
            ORDER BY um.created_at DESC
            LIMIT %s OFFSET %s
        """
        params.extend([limit, offset])
        cursor.execute(query, tuple(params))
        memberships = cursor.fetchall()

        # Count total
        count_query = f"""
            SELECT COUNT(*) AS total
            FROM user_memberships um
            JOIN users u ON um.user_id = u.id
            JOIN membership_tiers mt ON um.membership_tier_id = mt.id
            {where_clause}
        """
        cursor.execute(count_query, tuple(params[:-2]))  # exclude limit/offset
        total = cursor.fetchone()["total"]

        return jsonify({
            "memberships": memberships,
            "pagination": {
                "total": total,
                "limit": limit,
                "offset": offset,
                "hasMore": offset + limit < total
            }
        })

    except Exception as e:
        return jsonify({"error": "Failed to fetch memberships", "details": str(e)}), 500

    finally:
        cursor.close()
        conn.close()


@admin_bp.route("/admin/orders", methods=["GET"])
def get_orders():
    # Verify admin authentication
    auth_header = request.headers.get("Authorization")
    auth_result = verify_admin_token(auth_header)
    if not auth_result["success"]:
        print(f"Auth result: {auth_result}")
        return jsonify({"error": auth_result["error"]}), auth_result["status"]

    # Pagination & filters
    try:
        page = int(request.args.get("page", 1))
        limit = int(request.args.get("limit", 50))
        status = request.args.get("status")
        chain = request.args.get("chain")
        offset = (page - 1) * limit
    except ValueError:
        return jsonify({"error": "Invalid pagination parameters"}), 400

    where_clause = "WHERE 1=1"
    params = []

    if status and status.lower() != "all":
        where_clause += " AND o.status = %s"
        params.append(status)

    if chain and chain.lower() != "all":
        where_clause += " AND l.chain = %s"
        params.append(chain)

    orders_query = f"""
        SELECT 
            o.id,
            o.buyer_id,
            o.seller_id,
            o.listing_id,
            o.amount,
            o.transaction_hash,
            o.status,
            o.shipping_address,
            o.escrow_id,
            o.payment_chain,
            o.order_type,
            o.created_at,
            o.updated_at,
            buyer.username AS buyer_username,
            buyer.email AS buyer_email,
            seller.username AS seller_username,
            seller.email AS seller_email,
            l.title AS listing_title,
            l.description AS listing_description,
            l.chain,
            l.category
        FROM orders o
        JOIN users buyer ON o.buyer_id = buyer.id
        JOIN users seller ON o.seller_id = seller.id
        JOIN listings l ON o.listing_id = l.id
        {where_clause}
        ORDER BY o.created_at DESC
        LIMIT %s OFFSET %s
    """
    params.extend([limit, offset])

    count_query = f"""
        SELECT COUNT(*) AS total
        FROM orders o
        JOIN listings l ON o.listing_id = l.id
        {where_clause}
    """
    count_params = params[:-2]  # remove limit & offset

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute(orders_query, tuple(params))
        orders = cursor.fetchall()

        cursor.execute(count_query, tuple(count_params))
        total = cursor.fetchone()["total"]

        # Parse shipping_address JSON
        for order in orders:
            if order.get("shipping_address"):
                try:
                    order["shipping_address"] = json.loads(order["shipping_address"])
                except json.JSONDecodeError:
                    order["shipping_address"] = None

        return jsonify({
            "success": True,
            "orders": orders,
            "pagination": {
                "page": page,
                "limit": limit,
                "total": total,
                "pages": math.ceil(total / limit)
            }
        })

    except Exception as e:
        conn.rollback()
        print("Error fetching orders:", e)
        return jsonify({"error": "Failed to fetch orders"}), 500

    finally:
        cursor.close()
        conn.close()


VALID_STATUSES = ['pending', 'paid', 'shipped', 'delivered', 'cancelled']

@admin_bp.route("/admin/orders/<order_id>", methods=["GET"])
def get_order(order_id):
    auth_header = request.headers.get("Authorization")
    auth_result = verify_admin_token(auth_header)
    if not auth_result["success"]:
        return jsonify({"error": auth_result["error"]}), auth_result["status"]

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute("""
            SELECT 
                o.id,
                o.buyer_id,
                o.seller_id,
                o.listing_id,
                o.amount,
                o.transaction_hash,
                o.status,
                o.shipping_address,
                o.created_at,
                o.updated_at,
                buyer.username AS buyer_username,
                buyer.email AS buyer_email,
                seller.username AS seller_username,
                seller.email AS seller_email,
                l.title AS listing_title,
                l.description AS listing_description,
                l.chain,
                l.category,
                l.images
            FROM orders o
            JOIN users buyer ON o.buyer_id = buyer.id
            JOIN users seller ON o.seller_id = seller.id
            JOIN listings l ON o.listing_id = l.id
            WHERE o.id = %s
        """, (order_id,))

        order = cursor.fetchone()
        if not order:
            return jsonify({"error": "Order not found"}), 404

        # Parse JSON fields
        order["shipping_address"] = json.loads(order["shipping_address"]) if order.get("shipping_address") else None
        order["images"] = json.loads(order["images"]) if order.get("images") else []

        return jsonify({"success": True, "order": order})

    except Exception as e:
        print("Error fetching order:", e)
        return jsonify({"error": "Failed to fetch order"}), 500
    finally:
        cursor.close()
        conn.close()


@admin_bp.route("/admin/orders/<order_id>", methods=["PATCH"])
def update_order(order_id):
    auth_header = request.headers.get("Authorization")
    auth_result = verify_admin_token(auth_header)
    if not auth_result["success"]:
        return jsonify({"error": auth_result["error"]}), auth_result["status"]

    data = request.json
    status = data.get("status")
    transaction_hash = data.get("transaction_hash")
    shipping_address = data.get("shipping_address")

    if status and status.lower() not in VALID_STATUSES:
        return jsonify({"error": "Invalid status"}), 400

    update_fields = []
    params = []

    if status:
        update_fields.append("status = %s")
        params.append(status.lower())
    if transaction_hash:
        update_fields.append("transaction_hash = %s")
        params.append(transaction_hash)
    if shipping_address:
        update_fields.append("shipping_address = %s")
        params.append(json.dumps(shipping_address))

    if not update_fields:
        return jsonify({"error": "No fields to update"}), 400

    update_fields.append("updated_at = CURRENT_TIMESTAMP")

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        update_query = f"UPDATE orders SET {', '.join(update_fields)} WHERE id = %s"
        params.append(order_id)
        cursor.execute(update_query, tuple(params))
        conn.commit()

        if cursor.rowcount == 0:
            return jsonify({"error": "Order not found"}), 404

        # Fetch updated order
        cursor.execute("""
            SELECT 
                o.*,
                buyer.username AS buyer_username,
                seller.username AS seller_username,
                l.title AS listing_title
            FROM orders o
            JOIN users buyer ON o.buyer_id = buyer.id
            JOIN users seller ON o.seller_id = seller.id
            JOIN listings l ON o.listing_id = l.id
            WHERE o.id = %s
        """, (order_id,))
        updated_order = cursor.fetchone()
        updated_order["shipping_address"] = json.loads(updated_order["shipping_address"]) if updated_order.get("shipping_address") else None

        return jsonify({"success": True, "message": "Order updated successfully", "order": updated_order})

    except Exception as e:
        conn.rollback()
        print("Error updating order:", e)
        return jsonify({"error": "Failed to update order"}), 500
    finally:
        cursor.close()
        conn.close()


@admin_bp.route("/admin/orders/<order_id>", methods=["DELETE"])
def delete_order(order_id):
    auth_header = request.headers.get("Authorization")
    auth_result = verify_admin_token(auth_header)
    if not auth_result["success"]:
        return jsonify({"error": auth_result["error"]}), auth_result["status"]

    conn = get_db_connection()
    cursor = conn.cursor()

    try:
        cursor.execute("SELECT id FROM orders WHERE id = %s", (order_id,))
        order = cursor.fetchone()
        if not order:
            return jsonify({"error": "Order not found"}), 404

        cursor.execute("DELETE FROM orders WHERE id = %s", (order_id,))
        conn.commit()

        return jsonify({"success": True, "message": "Order deleted successfully"})

    except Exception as e:
        conn.rollback()
        print("Error deleting order:", e)
        return jsonify({"error": "Failed to delete order"}), 500
    finally:
        cursor.close()
        conn.close()