from flask import Blueprint, request, jsonify, render_template
from datetime import datetime
from uuid import uuid4
import json
from extensions.extensions import get_db_connection
from functions.storefront import verify_storefront_access_func
from functions.email_helper import send_email

storefront_orders_bp = Blueprint("storefront_orders", __name__, url_prefix="/storefront/orders")

@storefront_orders_bp.route("", methods=["POST"])
def create_order():
    """
    POST - Create a new order (purchase) and send email notifications
    Body: listing_id, amount, order_type, buyer_id, shipping_info, escrow_id, transaction_hash, payment_chain, quantity
    """
    try:
        user_or_error = verify_storefront_access_func()
        if isinstance(user_or_error, tuple):
            return user_or_error
        user = user_or_error

        data = request.get_json(force=True) or {}
        listing_id = data.get("listing_id")
        amount = data.get("amount")
        order_type = data.get("order_type")
        buyer_id = data.get("buyer_id")
        shipping_info = data.get("shipping_info")
        escrow_id = data.get("escrow_id")
        transaction_hash = data.get("transaction_hash")
        payment_chain = data.get("payment_chain")
        quantity = int(data.get("quantity", 1))

        if not all([listing_id, amount, order_type, buyer_id]):
            return jsonify({"error": "Missing required fields"}), 400

        conn = get_db_connection()
        cursor = conn.cursor()

        # Get listing info with seller
        cursor.execute("""
            SELECT l.*, u.email AS seller_email, u.username AS seller_username
            FROM listings l
            JOIN users u ON l.user_id = u.id
            WHERE l.id = %s
        """, (listing_id,))
        listing = cursor.fetchone()
        if not listing:
            cursor.close(); conn.close()
            return jsonify({"error": "Listing not found"}), 404

        if listing["stock_quantity"] < quantity:
            cursor.close(); conn.close()
            return jsonify({"error": f"Insufficient stock. Only {listing['stock_quantity']} available."}), 400

        if listing["status"] == "out_of_stock":
            cursor.close(); conn.close()
            return jsonify({"error": "This item is out of stock"}), 400

        order_id = str(uuid4())

        try:
            # Start transaction
            cursor.execute("START TRANSACTION")

            # Insert order
            cursor.execute("""
                INSERT INTO orders 
                (id, listing_id, buyer_id, seller_id, amount, quantity, transaction_hash, status, shipping_address, escrow_id, payment_chain, order_type, created_at)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """, (
                order_id, listing_id, buyer_id, listing["user_id"], float(amount), quantity,
                transaction_hash, "escrow_funded" if escrow_id else "pending",
                json.dumps(shipping_info) if shipping_info else None,
                escrow_id, payment_chain, order_type, datetime.utcnow()
            ))

            # Update stock
            new_stock = listing["stock_quantity"] - quantity
            new_status = "out_of_stock" if new_stock == 0 else listing["status"]
            cursor.execute("""
                UPDATE listings SET stock_quantity=%s, status=%s WHERE id=%s
            """, (new_stock, new_status, listing_id))

            if escrow_id:
                cursor.execute("UPDATE escrows SET status=%s WHERE id=%s", ("funded", escrow_id))

            conn.commit()

        except Exception as e:
            cursor.execute("ROLLBACK")
            raise e
        finally:
            cursor.close()
            conn.close()

        # Send email notifications
        try:
            # New Order
            send_email(
                to=listing["seller_email"],
                subject=f"New Order #{order_id}",
                template="new_order.html",
                context={
                    "seller_name": listing["seller_username"],
                    "product_name": listing["title"],
                    "quantity": quantity,
                    "amount": amount,
                    "buyer_name": "Customer",
                    "order_date": datetime.utcnow().strftime("%Y-%m-%d"),
                    "shipping_required": listing["is_physical"]
                }
            )

            # Payment Received
            if escrow_id:
                send_email(
                    to=listing["seller_email"],
                    subject=f"Payment Received for Order #{order_id}",
                    template="payment_received.html",
                    context={
                        "seller_name": listing["seller_username"],
                        "product_name": listing["title"],
                        "amount": amount,
                        "payment_date": datetime.utcnow().strftime("%Y-%m-%d")
                    }
                )

            # Low Stock
            if 0 < new_stock <= (listing.get("low_stock_threshold") or 2):
                send_email(
                    to=listing["seller_email"],
                    subject=f"Low Stock Alert: {listing['title']}",
                    template="low_stock.html",
                    context={
                        "seller_name": listing["seller_username"],
                        "product_name": listing["title"],
                        "current_stock": new_stock,
                        "threshold": listing.get("low_stock_threshold") or 2,
                        "listing_id": listing_id
                    }
                )
        except Exception as e:
            print("Email notification error:", e)

        return jsonify({
            "success": True,
            "order_id": order_id,
            "stock_remaining": new_stock,
            "message": "Order created successfully"
        }), 201

    except Exception as e:
        print("Error creating order:", e)
        return jsonify({"error": "Internal server error"}), 500


@storefront_orders_bp.route("", methods=["GET"])
def get_orders():
    """
    GET - Fetch orders for a user with pagination
    Query Params: status, page, limit
    """
    try:
        user_or_error = verify_storefront_access_func()
        if isinstance(user_or_error, tuple):
            return user_or_error
        user = user_or_error

        status = request.args.get("status")
        page = int(request.args.get("page", 1))
        limit = int(request.args.get("limit", 10))
        offset = (page - 1) * limit

        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
            SELECT o.*, l.title AS listing_title, l.images AS listing_images, l.price AS listing_price,
                   seller.username AS seller_username
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            JOIN users seller ON o.seller_id = seller.id
            WHERE o.buyer_id = %s
        """
        params = [user["id"]]
        if status:
            query += " AND o.status = %s"
            params.append(status)
        query += " ORDER BY o.created_at DESC LIMIT %s OFFSET %s"
        params.extend([limit, offset])
        cursor.execute(query, params)
        orders = cursor.fetchall()

        # Total count for pagination
        count_query = "SELECT COUNT(*) AS total FROM orders WHERE buyer_id=%s"
        count_params = [user["id"]]
        if status:
            count_query += " AND status=%s"
            count_params.append(status)
        cursor.execute(count_query, count_params)
        total = cursor.fetchone()["total"]
        total_pages = (total + limit - 1) // limit

        # Parse JSON fields
        for order in orders:
            if isinstance(order.get("listing_images"), str):
                order["listing_images"] = json.loads(order["listing_images"])
            if isinstance(order.get("shipping_address"), str):
                order["shipping_address"] = json.loads(order["shipping_address"])

        cursor.close()
        conn.close()

        return jsonify({
            "orders": orders,
            "pagination": {"page": page, "limit": limit, "total": total, "total_pages": total_pages}
        }), 200

    except Exception as e:
        print("Error fetching orders:", e)
        return jsonify({"error": "Internal server error"}), 500
