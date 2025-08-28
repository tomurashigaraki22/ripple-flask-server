from flask import Blueprint, jsonify, request
import pymysql
import jwt
import os

from extensions.extensions import get_db_connection

orders_bp = Blueprint("orders", __name__)


# Function to verify user access (not a decorator)
def verify_user_access(req):
    print("TRYYY")
    auth_header = req.headers.get("Authorization")

    if not auth_header or not auth_header.startswith("Bearer "):
        return {"error": "Missing or invalid authorization header", "status": 401}

    token = auth_header.split(" ")[1]
    print(f"Tokn: {token}")

    try:
        decoded = jwt.decode(token, os.getenv("JWT_SECRET"), algorithms=["HS256"])
    except jwt.ExpiredSignatureError:
        return {"error": "Token has expired", "status": 401}
    except jwt.InvalidTokenError:
        return {"error": "Invalid token", "status": 401}

    user_id = decoded.get("userId")
    print(f"Decoded: {decoded}")
    if not user_id:
        return {"error": "Invalid token payload", "status": 401}

    # Fetch user from database using DictCursor
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute(
            "SELECT id, email, username FROM users WHERE id = %s",
            (user_id,)
        )
        user = cursor.fetchone()
        conn.close()

        if not user:
            return {"error": "User not found", "status": 404}

        return {"user": user}  # already a dict

    except Exception as e:
        print("DB error in verify_user_access:", e)
        return {"error": "Internal server error", "status": 500}


@orders_bp.route("/get", methods=["GET"])
def get_user_orders():
    try:
        # Verify user access using request object
        auth_result = verify_user_access(request)
        if "user" not in auth_result:
            return jsonify({"error": auth_result.get("error", "Unauthorized")}), auth_result.get("status", 401)

        user_id = auth_result["user"]["id"]

        # Pagination & status filter
        status = request.args.get("status")
        page = int(request.args.get("page", 1))
        limit = int(request.args.get("limit", 10))
        offset = (page - 1) * limit

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        # Main query
        query = """
            SELECT 
                o.*,
                l.title AS listing_title,
                l.images AS listing_images,
                l.price AS listing_price,
                seller.username AS seller_username
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            JOIN users seller ON o.seller_id = seller.id
            WHERE o.buyer_id = %s
        """
        params = [user_id]

        if status:
            query += " AND o.status = %s"
            params.append(status)

        query += " ORDER BY o.created_at DESC LIMIT %s OFFSET %s"
        params.extend([limit, offset])

        cursor.execute(query, params)
        orders = cursor.fetchall()

        # Total count for pagination
        count_query = "SELECT COUNT(*) AS total FROM orders o WHERE o.buyer_id = %s"
        count_params = [user_id]
        if status:
            count_query += " AND o.status = %s"
            count_params.append(status)

        cursor.execute(count_query, count_params)
        total = cursor.fetchone()["total"]
        total_pages = (total + limit - 1) // limit  # ceiling division

        # Format JSON fields
        import json
        for order in orders:
            if isinstance(order.get("listing_images"), str):
                order["listing_images"] = json.loads(order["listing_images"])
            if isinstance(order.get("shipping_address"), str):
                order["shipping_address"] = json.loads(order["shipping_address"])

        cursor.close()
        conn.close()

        return jsonify({
            "orders": orders,
            "pagination": {
                "page": page,
                "limit": limit,
                "total": total,
                "totalPages": total_pages
            }
        }), 200

    except Exception as e:
        print("Error fetching orders:", e)
        return jsonify({"error": "Internal server error"}), 500

@orders_bp.route("/<order_id>", methods=["GET"])
def get_order_details(order_id):
    try:
        # Verify user access
        auth_result = verify_user_access(request)
        if "user" not in auth_result:
            return jsonify({"error": auth_result.get("error", "Unauthorized")}), auth_result.get("status", 401)

        user_id = auth_result["user"]["id"]

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        # Query to fetch order details by UUID
        query = """
            SELECT 
                o.*,
                l.title AS listing_title,
                l.images AS listing_images,
                l.price AS listing_price,
                seller.username AS seller_username
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            JOIN users seller ON o.seller_id = seller.id
            WHERE o.id = %s AND o.buyer_id = %s
        """
        cursor.execute(query, (order_id, user_id))
        order = cursor.fetchone()

        if not order:
            cursor.close()
            conn.close()
            return jsonify({"error": "Order not found"}), 404

        # Parse JSON fields
        import json
        if isinstance(order.get("listing_images"), str):
            order["listing_images"] = json.loads(order["listing_images"])
        if isinstance(order.get("shipping_address"), str):
            order["shipping_address"] = json.loads(order["shipping_address"])

        cursor.close()
        conn.close()

        return jsonify(order), 200

    except Exception as e:
        print("Error fetching order details:", e)
        return jsonify({"error": "Internal server error"}), 500
