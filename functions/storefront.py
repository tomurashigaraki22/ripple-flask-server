from flask import Blueprint, request, jsonify
import pymysql
import jwt
import os
from datetime import datetime, timedelta, timezone
import uuid
from uuid import uuid4
import hmac
import hashlib
import time
import json
from functools import wraps
from extensions.extensions import get_db_connection

# Blueprint for storefront login
storefront_bp = Blueprint('storefront', __name__)


JWT_SECRET = os.getenv("JWT_SECRET", "your-secret-key")

@storefront_bp.route("/login", methods=["POST"])
def storefront_login():
    try:
        data = request.get_json()
        email = data.get("email")
        password = data.get("password")

        if not email or not password:
            return jsonify({"error": "Email and password are required"}), 400

        conn = get_db_connection()
        cursor = conn.cursor()

        query = """
            SELECT sl.*, u.id as user_id, u.username, u.status as user_status, 
                   mt.name as membership_tier, mt.features
            FROM storefront_logins sl
            JOIN users u ON sl.user_id = u.id
            JOIN membership_tiers mt ON u.membership_tier_id = mt.id
            WHERE sl.email = %s AND sl.generated_password = %s
        """
        cursor.execute(query, (email, password))
        storefront_login = cursor.fetchone()

        if not storefront_login:
            return jsonify({"error": "Invalid credentials"}), 401

        # Check if account expired
        if storefront_login.get("expired"):
            return jsonify({"error": "Storefront account has expired"}), 401

        # Check expiry date
        expires_at = storefront_login.get("expires_at")
        if expires_at and datetime.utcnow() > expires_at:
            cursor.execute(
                "UPDATE storefront_logins SET expired = TRUE WHERE id = %s",
                (storefront_login["id"],)
            )
            conn.commit()
            return jsonify({"error": "Storefront account has expired"}), 401

        # Check user account status
        if storefront_login.get("user_status") != "active":
            return jsonify({"error": "User account is not active"}), 401

        # Generate JWT token
        token = jwt.encode(
            {
                "userId": storefront_login["user_id"],
                "email": storefront_login["email"],
                "username": storefront_login["username"],
                "membershipTier": storefront_login["membership_tier"],
                "type": "storefront",
                "exp": datetime.utcnow() + timedelta(hours=24)
            },
            JWT_SECRET,
            algorithm="HS256"
        )

        return jsonify({
            "message": "Login successful",
            "token": token,
            "user": {
                "id": storefront_login["user_id"],
                "username": storefront_login["username"],
                "email": storefront_login["email"],
                "membershipTier": storefront_login["membership_tier"],
                "features": storefront_login["features"]
            }
        }), 200

    except Exception as e:
        print("Storefront login error:", str(e))
        return jsonify({"error": "Internal server error"}), 500


def verify_storefront_access_func():
    """
    Verify the Authorization header and return the user dictionary.
    Returns:
        dict: User dictionary if verification succeeds.
        tuple: (JSON response, status_code) if verification fails.
    """
    print("Trying to verify storefront access...")

    auth_header = request.headers.get("Authorization")
    if not auth_header or not auth_header.startswith("Bearer "):
        print(f"No token provided")
        return jsonify({"error": "No token provided"}), 401

    token = auth_header.split(" ")[1]

    try:
        decoded = jwt.decode(token, JWT_SECRET, algorithms=["HS256"])

        user_id = decoded.get("userId")
        print(f"Decoded token: {decoded}")
        if not user_id:
            return jsonify({"error": "Invalid token payload"}), 401

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        cursor.execute("""
            SELECT u.id, u.username, u.email, u.status, u.membership_tier_id,
                   mt.name as membership_tier, mt.features
            FROM users u
            JOIN membership_tiers mt ON u.membership_tier_id = mt.id
            WHERE u.id = %s AND u.status = 'active'
        """, (user_id,))
        user = cursor.fetchone()

        cursor.close()
        conn.close()

        if not user:
            return jsonify({"error": "User not found or inactive"}), 404


        return user  # ✅ return the dictionary

    except jwt.ExpiredSignatureError:
        return jsonify({"error": "Token expired"}), 401
    except jwt.InvalidTokenError:
        return jsonify({"error": "Invalid token"}), 401
    except Exception as e:
        print(f"Error in verify_storefront_access_func: {e}")
        return jsonify({"error": "Internal server error"}), 500

# 🔹 GET storefront dashboard stats
@storefront_bp.route("/stats", methods=["GET"])
def get_storefront_stats():
    try:
        print("Fetching storefront stats...")
        user_or_error = verify_storefront_access_func()
    
        # Check if it returned an error
        if isinstance(user_or_error, tuple):
            return user_or_error

        user = user_or_error
        user_id = user["id"]

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        # Helper to safely fetch a single numeric value
        def safe_fetch(query, params):
            cursor.execute(query, params)
            result = cursor.fetchone()
            # Return 0 if result is None or value is None
            if result is None:
                print("Result is nonee")
                return 0
            value = list(result.values())[0]
            return value if value is not None else 0

        # Total listings
        total_listings = safe_fetch(
            "SELECT COUNT(*) AS total FROM listings WHERE user_id = %s", (user_id,)
        )

        # Active listings
        active_listings = safe_fetch(
            "SELECT COUNT(*) AS total FROM listings WHERE user_id = %s AND status = 'approved'",
            (user_id,)
        )

        # Total views
        total_views = safe_fetch(
            "SELECT COALESCE(SUM(views), 0) AS total FROM listings WHERE user_id = %s",
            (user_id,)
        )

        # Total earnings
        total_earnings = float(safe_fetch(
            """
            SELECT COALESCE(SUM(o.amount), 0) AS total
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            WHERE l.user_id = %s AND o.status IN ('delivered', 'completed')
            """,
            (user_id,)
        ))

        # Pending orders
        pending_orders = safe_fetch(
            """
            SELECT COUNT(*) AS total
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            WHERE l.user_id = %s AND o.status IN ('pending', 'paid', 'shipped')
            """,
            (user_id,)
        )

        # Completed orders
        completed_orders = safe_fetch(
            """
            SELECT COUNT(*) AS total
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            WHERE l.user_id = %s AND o.status IN ('delivered', 'completed')
            """,
            (user_id,)
        )

        cursor.close()
        conn.close()

        stats = {
            "totalListings": total_listings,
            "activeListings": active_listings,
            "totalViews": total_views,
            "totalEarnings": total_earnings,
            "pendingOrders": pending_orders,
            "completedOrders": completed_orders
        }

        return jsonify({"success": True, "stats": stats}), 200

    except Exception as e:
        print("Error fetching storefront stats:", e)
        return jsonify({"error": f"Internal server error: {str(e)}"}), 500

@storefront_bp.route("/orders", methods=["GET"])
def get_storefront_orders():
    try:
        user_or_error = verify_storefront_access_func()
    
        # Check if it returned an error
        if isinstance(user_or_error, tuple):
            return user_or_error

        user = user_or_error
        user_id = user["id"]  # injected by verify_storefront_access

        # Pagination
        limit = int(request.args.get("limit", 20))
        offset = int(request.args.get("offset", 0))
        status = request.args.get("status")

        conn = get_db_connection()
        cursor = conn.cursor()

        # Build query
        where_clause = "WHERE l.user_id = %s"
        query_params = [user_id]

        if status and status != "all":
            where_clause += " AND o.status = %s"
            query_params.append(status)

        # Fetch orders
        cursor.execute(f"""
            SELECT 
                o.id,
                o.amount,
                o.status,
                o.transaction_hash,
                o.shipping_address,
                o.created_at,
                o.updated_at,
                l.id as listing_id,
                l.title as listing_title,
                l.price as listing_price,
                l.images as listing_images,
                buyer.username as buyer_username,
                buyer.email as buyer_email
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            JOIN users buyer ON o.buyer_id = buyer.id
            {where_clause}
            ORDER BY o.created_at DESC
            LIMIT %s OFFSET %s
        """, query_params + [limit, offset])

        orders = cursor.fetchall()

        # Get total count for pagination
        cursor.execute(f"""
            SELECT COUNT(*) as total
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            {where_clause}
        """, query_params)
        total = cursor.fetchone()["total"]

        cursor.close()
        conn.close()

        # Format results
        formatted_orders = []
        for order in orders:
            formatted_orders.append({
                **order,
                "amount": float(order["amount"]),
                "listing_price": float(order["listing_price"]),
                "listing_images": (
                    order["listing_images"] and
                    (order["listing_images"] if isinstance(order["listing_images"], list)
                     else eval(order["listing_images"]))
                ) or [],
                "shipping_address": (
                    order["shipping_address"] and
                    (order["shipping_address"] if isinstance(order["shipping_address"], dict)
                     else eval(order["shipping_address"]))
                )
            })

        return jsonify({
            "success": True,
            "orders": formatted_orders,
            "pagination": {
                "total": total,
                "limit": limit,
                "offset": offset,
                "hasMore": offset + limit < total
            }
        }), 200

    except Exception as e:
        print("Error fetching storefront orders:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefront_bp.route("/listings", methods=["GET"])
def get_storefront_listings():
    """
    GET - Fetch user's listings
    Query params: 
        user_id (required): ID of the user whose listings to fetch
        limit (default 20): Number of listings per page
        offset (default 0): Pagination offset
        status: Filter by listing status
        category: Filter by category
    """
    try:
        user_id = request.args.get("user_id")
        if not user_id:
            return jsonify({"error": "user_id is required"}), 400

        limit = int(request.args.get("limit", 20))
        offset = int(request.args.get("offset", 0))
        status = request.args.get("status")
        category = request.args.get("category")

        where_clause = "WHERE user_id = %s"
        params = [user_id]

        if status and status != "all":
            where_clause += " AND status = %s"
            params.append(status)

        if category and category != "all":
            where_clause += " AND category = %s"
            params.append(category)

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)  # Use DictCursor for better response format

        # Get total count for pagination
        cursor.execute(f"""
            SELECT COUNT(*) as total
            FROM listings
            {where_clause}
        """, params)
        total = cursor.fetchone()["total"]
        total_pages = (total + limit - 1) // limit

        # Fetch listings with pagination
        cursor.execute(f"""
            SELECT id, title, description, price, category, chain, is_physical,
                   images, tags, status, views, created_at, updated_at, shipping_from,
                   stock_quantity, original_stock, low_stock_threshold,
                   is_auction, starting_bid, current_bid, bid_increment, auction_end_date, buy_now_price
            FROM listings
            {where_clause}
            ORDER BY created_at DESC
            LIMIT %s OFFSET %s
        """, params + [limit, offset])

        listings = cursor.fetchall()

        cursor.close()
        conn.close()

        # Parse JSON fields
        for listing in listings:
            # Parse images
            if isinstance(listing.get("images"), str):
                try:
                    listing["images"] = json.loads(listing["images"])
                except Exception:
                    listing["images"] = []
            
            # Parse tags
            if isinstance(listing.get("tags"), str):
                try:
                    listing["tags"] = json.loads(listing["tags"])
                except Exception:
                    listing["tags"] = []

            # Parse shipping_from
            if isinstance(listing.get("shipping_from"), str):
                try:
                    listing["shipping_from"] = json.loads(listing["shipping_from"])
                except Exception:
                    listing["shipping_from"] = None

            # Convert price to float
            if "price" in listing:
                listing["price"] = float(listing["price"])

            # Convert numeric fields
            numeric_fields = ["starting_bid", "current_bid", "bid_increment", "buy_now_price"]
            for field in numeric_fields:
                if field in listing and listing[field] is not None:
                    listing[field] = float(listing[field])

        return jsonify({
            "listings": listings,
            "pagination": {
                "total": total,
                "totalPages": total_pages,
                "currentPage": (offset // limit) + 1,
                "limit": limit,
                "hasMore": offset + limit < total,
                "hasPrevious": offset > 0
            }
        }), 200

    except Exception as e:
        print("Error fetching listings:", e)
        return jsonify({"error": "Internal server error"}), 500



@storefront_bp.route("/listings/<listing_id>", methods=["DELETE"])
def delete_storefront_listing(listing_id):
    """
    DELETE - Delete a listing by ID
    URL params: listing_id - The ID of the listing to delete
    """
    try:
        user_or_error = verify_storefront_access_func()
    
        # Check if it returned an error
        if isinstance(user_or_error, tuple):
            return user_or_error

        user = user_or_error
        user_id = user["id"]

        # Validate listing_id
        if not listing_id:
            return jsonify({"error": "Listing ID is required"}), 400

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        # Check if listing exists and belongs to the user
        cursor.execute("""
            SELECT id, status FROM listings 
            WHERE id = %s AND user_id = %s
        """, (listing_id, user_id))
        listing = cursor.fetchone()

        if not listing:
            cursor.close()
            conn.close()
            return jsonify({"error": "Listing not found or you don't have permission to delete it"}), 404

        # Check if listing has associated orders
        cursor.execute("""
            SELECT COUNT(*) as count FROM orders 
            WHERE listing_id = %s AND status NOT IN ('cancelled', 'refunded')
        """, (listing_id,))
        result = cursor.fetchone()
        order_count = result["count"] if result else 0

        if order_count > 0:
            cursor.close()
            conn.close()
            return jsonify({"error": "Cannot delete listing with active orders"}), 400

        # Delete the listing
        cursor.execute("DELETE FROM listings WHERE id = %s", (listing_id,))
        conn.commit()

        cursor.close()
        conn.close()

        return jsonify({"success": True, "message": "Listing deleted successfully"}), 200

    except Exception as e:
        print(f"Error deleting listing: {e}")
        return jsonify({"error": f"Internal server error: {str(e)}"}), 500

@storefront_bp.route("/listings/<listing_id>", methods=["PUT"])
def update_storefront_listing(listing_id):
    """
    PUT - Update listing information
    URL params: listing_id - The ID of the listing to update
    Body: title, description, price, category, chain, isPhysical, images, tags,
          stock_quantity, low_stock_threshold, shipping_from
    """
    try:
        user_or_error = verify_storefront_access_func()
    
        # Check if it returned an error
        if isinstance(user_or_error, tuple):
            return user_or_error

        user = user_or_error
        user_id = user["id"]
        data = request.get_json(force=True) or {}

        # Validate listing_id
        if not listing_id:
            return jsonify({"error": "Listing ID is required"}), 400

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        # Check if listing exists and belongs to the user
        cursor.execute("""
            SELECT * FROM listings 
            WHERE id = %s AND user_id = %s
        """, (listing_id, user_id))
        listing = cursor.fetchone()

        if not listing:
            cursor.close()
            conn.close()
            return jsonify({"error": "Listing not found or you don't have permission to update it"}), 404

        # Check if listing has active orders and is being modified significantly
        cursor.execute("""
            SELECT COUNT(*) as count FROM orders 
            WHERE listing_id = %s AND status IN ('pending', 'paid', 'shipped')
        """, (listing_id,))
        result = cursor.fetchone()
        active_order_count = result["count"] if result else 0

        # Extract and validate fields
        title = data.get("title", listing.get("title", ""))
        description = data.get("description", listing.get("description", ""))
        price = data.get("price", listing.get("price", 0))
        category = data.get("category", listing.get("category", ""))
        chain = data.get("chain", listing.get("chain", ""))
        is_physical = bool(data.get("isPhysical", listing.get("is_physical", False)))
        
        # Safely parse JSON fields
        images_data = listing.get("images")
        if isinstance(images_data, str):
            try:
                images_data = json.loads(images_data)
            except Exception:
                images_data = []
        images = data.get("images", images_data or [])
        
        tags_data = listing.get("tags")
        if isinstance(tags_data, str):
            try:
                tags_data = json.loads(tags_data)
            except Exception:
                tags_data = []
        tags = data.get("tags", tags_data or [])
        
        stock_quantity = data.get("stock_quantity", listing.get("stock_quantity", 1))
        low_stock_threshold = data.get("low_stock_threshold", listing.get("low_stock_threshold", 5))
        shipping_from = data.get("address")

        # Basic validation
        if not all([title, description, price, category, chain]):
            return jsonify({"error": "Title, description, price, category, and chain are required"}), 400

        try:
            price_val = float(price)
        except Exception:
            return jsonify({"error": "Price must be a number"}), 400
        if price_val <= 0:
            return jsonify({"error": "Price must be greater than 0"}), 400

        # Stock & images validation
        stock_qty = int(stock_quantity or 1)
        if stock_qty < 1:
            return jsonify({"error": "Stock quantity must be at least 1"}), 400
        if not images or not isinstance(images, list) or len(images) == 0:
            return jsonify({"error": "At least one image is required"}), 400

        # Validate shipping_from if provided
        shipping_from_json = None
        if shipping_from is not None:
            if not isinstance(shipping_from, dict):
                return jsonify({"error": "shipping_from must be an object"}), 400
            
            # Required fields
            required_fields = ["street", "city", "state", "country", "zipCode", "phone"]
            missing_fields = [field for field in required_fields if field not in shipping_from]
            
            if missing_fields:
                return jsonify({
                    "error": f"Missing required shipping fields: {', '.join(missing_fields)}"
                }), 400
            
            # Validate data types
            if not all(isinstance(shipping_from.get(field), str) for field in required_fields):
                return jsonify({
                    "error": "All shipping fields must be strings"
                }), 400
                
            shipping_from_json = json.dumps(shipping_from)
        elif listing.get("shipping_from") is not None:
            shipping_from_json = listing.get("shipping_from")

        # Prepare update query
        update_fields = [
            "title = %s",
            "description = %s",
            "price = %s",
            "category = %s",
            "chain = %s",
            "is_physical = %s",
            "images = %s",
            "tags = %s",
            "stock_quantity = %s",
            "low_stock_threshold = %s",
            "shipping_from = %s",
            "updated_at = NOW()"
        ]

        # Convert images and tags to JSON strings
        images_json = json.dumps(images)
        tags_json = json.dumps(tags)

        # Execute update
        cursor.execute(f"""
            UPDATE listings SET {', '.join(update_fields)}
            WHERE id = %s AND user_id = %s
        """, (
            title, description, price, category, chain, is_physical,
            images_json, tags_json, stock_qty, low_stock_threshold,
            shipping_from_json, listing_id, user_id
        ))
        conn.commit()

        cursor.close()
        conn.close()

        return jsonify({
            "success": True, 
            "message": "Listing updated successfully",
            "listing_id": listing_id
        }), 200

    except Exception as e:
        print(f"Error updating listing: {e}")
        return jsonify({"error": f"Internal server error: {str(e)}"}), 500

@storefront_bp.route("/listings", methods=["POST"])
def create_storefront_listing():
    """
    POST - Create new listing (supports auctions)
    Body: title, description, price, category, chain, isPhysical, images, tags,
          stock_quantity, low_stock_threshold,
          is_auction, starting_bid, bid_increment, auction_end_date, buy_it_now_price
    """
    try:
        user_or_error = verify_storefront_access_func()
    
        # Check if it returned an error
        if isinstance(user_or_error, tuple):
            return user_or_error

        user = user_or_error
        user_id = user["id"]
        data = request.get_json(force=True) or {}

        title = data.get("title")
        description = data.get("description")
        price = data.get("price")
        category = data.get("category")
        chain = data.get("chain")
        is_physical = bool(data.get("isPhysical"))
        images = data.get("images")
        tags = data.get("tags")

        stock_quantity = data.get("stock_quantity")
        low_stock_threshold = data.get("low_stock_threshold")
        
        shipping_from = data.get("address")
        
        # Validate shipping_from
        if shipping_from is not None:
            if not isinstance(shipping_from, dict):
                return jsonify({"error": "shipping_from must be an object"}), 400
            
            # Required fields
            required_fields = ["street", "city", "state", "country", "zipCode", "phone"]
            missing_fields = [field for field in required_fields if field not in shipping_from]
            
            if missing_fields:
                return jsonify({
                    "error": f"Missing required shipping fields: {', '.join(missing_fields)}"
                }), 400
            
            # Validate data types
            if not all(isinstance(shipping_from.get(field), str) for field in required_fields):
                return jsonify({
                    "error": "All shipping fields must be strings"
                }), 400

        # Convert to JSON string if present
        shipping_from_json = json.dumps(shipping_from) if shipping_from is not None else None

        is_auction = bool(data.get("is_auction"))
        starting_bid = data.get("starting_bid")
        bid_increment = data.get("bid_increment")
        auction_end_date = data.get("auction_end_date")
        buy_it_now_price = data.get("buy_it_now_price")

        # Basic validation
        if not all([title, description, price, category, chain]):
            return jsonify({"error": f"Title, description, price, category, and chain are required: {title} , {description}, {price}, {category}, {chain}"}), 400

        try:
            price_val = float(price)
        except Exception:
            return jsonify({"error": "Price must be a number"}), 400
        if price_val <= 0:
            return jsonify({"error": "Price must be greater than 0"}), 400

        # Auction validation
        if is_auction:
            try:
                sb = float(starting_bid)
            except Exception:
                return jsonify({"error": "Starting bid is required for auctions and must be greater than 0"}), 400
            if sb <= 0:
                return jsonify({"error": "Starting bid is required for auctions and must be greater than 0"}), 400

            if not auction_end_date:
                return jsonify({"error": "Auction end date is required for auctions"}), 400

            # robust ISO parsing
            try:
                # handle e.g. "2025-08-01T12:00:00Z"
                end_dt = datetime.fromisoformat(auction_end_date.replace("Z", "+00:00"))
            except Exception:
                return jsonify({"error": "Invalid auction_end_date format (use ISO 8601)"}), 400

            now = datetime.now(timezone.utc)
            if end_dt <= now:
                return jsonify({"error": "Auction end date must be in the future"}), 400

            diff_ms = (end_dt - now).total_seconds() * 1000
            one_hour = 60 * 60 * 1000
            thirty_days = 30 * 24 * 60 * 60 * 1000

            if diff_ms < one_hour:
                return jsonify({"error": "Auction must run for at least 1 hour"}), 400
            if diff_ms > thirty_days:
                return jsonify({"error": "Auction cannot run for more than 30 days"}), 400

            if buy_it_now_price is not None:
                try:
                    binp = float(buy_it_now_price)
                except Exception:
                    return jsonify({"error": "Buy it now price must be a number"}), 400
                if binp <= sb:
                    return jsonify({"error": "Buy it now price must be higher than starting bid"}), 400

        # Stock & images
        stock_qty = int(stock_quantity or 1)
        if stock_qty < 1:
            return jsonify({"error": "Stock quantity must be at least 1"}), 400
        if not images or not isinstance(images, list) or len(images) == 0:
            return jsonify({"error": "At least one image is required"}), 400

        # Check membership tier limits
        conn = get_db_connection()
        cursor = conn.cursor()

        cursor.execute("""
            SELECT u.id, u.status, u.membership_tier_id, mt.features
            FROM users u
            JOIN membership_tiers mt ON u.membership_tier_id = mt.id
            WHERE u.id = %s AND u.status = 'active'
        """, (user_id,))
        user_row = cursor.fetchone()
        if not user_row:
            cursor.close(); conn.close()
            return jsonify({"error": "User not found or inactive"}), 404

        features_raw = user_row.get("features")
        try:
            features = json.loads(features_raw) if isinstance(features_raw, str) else (features_raw or {})
        except Exception:
            features = {}

        listings_limit = features.get("listings_limit", -1)
        if listings_limit != -1:
            cursor.execute(
                'SELECT COUNT(*) AS cnt FROM listings WHERE user_id = %s AND status != "sold"',
                (user_id,)
            )
            cnt = cursor.fetchone()["cnt"]
            if cnt >= listings_limit:
                cursor.close(); conn.close()
                return jsonify({
                    "error": f"You have reached your listing limit of {listings_limit}. "
                             f"Upgrade your membership to create more listings."
                }), 403

        # Process tags
        processed_tags = []
        if tags:
            if isinstance(tags, str):
                processed_tags = [t.strip() for t in tags.split(",") if t.strip()]
            elif isinstance(tags, list):
                processed_tags = tags

        listing_id = str(uuid4())

        if is_auction:
            cursor.execute("""
                INSERT INTO listings
                (id, user_id, title, description, price, category, chain, is_physical, images, tags,
                 stock_quantity, original_stock, low_stock_threshold,
                 is_auction, starting_bid, current_bid, bid_increment, auction_end_date, buy_now_price,
                 auction_status, status, shipping_from)
                VALUES
                (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                 %s, %s, %s,
                 %s, %s, %s, %s, %s, %s,
                 'active', 'pending', %s)
            """, (
                listing_id,
                user_id,
                title,
                description,
                price_val,
                category,
                chain,
                1 if is_physical else 0,
                json.dumps(images),
                json.dumps(processed_tags),
                stock_qty,
                stock_qty,
                int(low_stock_threshold or 5),
                1,  # is_auction
                float(starting_bid),
                float(starting_bid),  # current_bid starts at starting_bid
                float(bid_increment or 10),
                end_dt.astimezone(timezone.utc).strftime("%Y-%m-%d %H:%M:%S"),
                float(buy_it_now_price) if buy_it_now_price is not None else None,
                shipping_from_json
            ))
        else:
            cursor.execute("""
                INSERT INTO listings
                (id, user_id, title, description, price, category, chain, is_physical, images, tags,
                 stock_quantity, original_stock, low_stock_threshold, status, shipping_from)
                VALUES
                (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s,
                 %s, %s, %s, 'pending', %s)
            """, (
                listing_id,
                user_id,
                title,
                description,
                price_val,
                category,
                chain,
                1 if is_physical else 0,
                json.dumps(images),
                json.dumps(processed_tags),
                stock_qty,
                stock_qty,
                int(low_stock_threshold or 5),
                shipping_from_json
            ))

        # Fetch created listing
        cursor.execute("""
            SELECT id, title, description, price, category, chain, is_physical,
                   images, tags, status, views, created_at, updated_at, shipping_from
            FROM listings WHERE id = %s
        """, (listing_id,))
        listing = cursor.fetchone()

        cursor.close()
        conn.commit()
        conn.close()

        # Parse JSON fields for response
        if isinstance(listing.get("images"), str):
            try:
                listing["images"] = json.loads(listing["images"])
            except Exception:
                listing["images"] = []
        if isinstance(listing.get("tags"), str):
            try:
                listing["tags"] = json.loads(listing["tags"])
            except Exception:
                listing["tags"] = []

        if isinstance(listing.get("shipping_from"), str):
            try:
                listing["shipping_from"] = json.loads(listing["shipping_from"])
            except Exception:
                listing["shipping_from"] = None

        return jsonify({
            "message": "Listing created successfully and is pending approval",
            "listing": listing
        }), 201

    except Exception as e:
        print("Error creating listing:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefront_bp.route("/escrows", methods=["GET"])
def get_escrows():
    try:
        # Verify user access
        auth_result = verify_storefront_access_func()
        if isinstance(auth_result, tuple):
            # Failed verification, auth_result is (response, status_code)
            return auth_result
        print(f"Auth Ressult: {auth_result}")

        user = auth_result  # This is the verified user dict
        limit = int(request.args.get("limit", 50))
        offset = int(request.args.get("offset", 0))
        status = request.args.get("status")

        conn = get_db_connection()
        cursor = conn.cursor()

        # Fetch orders for this seller with escrow_id
        order_query = """
            SELECT o.*, 
                   l.title AS listing_title,
                   l.price AS listing_price,
                   l.images AS listing_images
            FROM orders o
            JOIN listings l ON o.listing_id = l.id
            WHERE o.seller_id = %s AND o.escrow_id IS NOT NULL
            ORDER BY o.created_at DESC
            LIMIT %s OFFSET %s
        """
        cursor.execute(order_query, (user["id"], limit, offset))
        orders = cursor.fetchall()

        if not orders:
            return jsonify({
                "escrows": [],
                "pagination": {"total": 0, "limit": limit, "offset": offset, "hasMore": False}
            })

        escrow_ids = [order["escrow_id"] for order in orders]
        escrow_placeholders = ", ".join(["%s"] * len(escrow_ids))

        # Fetch escrow details
        escrow_query = f"SELECT * FROM escrows WHERE id IN ({escrow_placeholders})"
        escrow_params = escrow_ids
        if status:
            escrow_query += " AND status = %s"
            escrow_params.append(status)

        escrow_query += " ORDER BY created_at DESC"
        cursor.execute(escrow_query, escrow_params)
        escrows = cursor.fetchall()

        # Combine escrow and order data
        combined_data = []
        for escrow in escrows:
            related_order = next((o for o in orders if o["escrow_id"] == escrow["id"]), None)
            combined_data.append({
                **escrow,
                "order_id": related_order.get("id") if related_order else None,
                "listing_title": related_order.get("listing_title") if related_order else None,
                "listing_price": related_order.get("listing_price") if related_order else None,
                "listing_images": related_order.get("listing_images") if related_order else None,
                "order_amount": related_order.get("amount") if related_order else None,
                "transaction_hash": related_order.get("transaction_hash") if related_order else None,
                "payment_chain": related_order.get("payment_chain") if related_order else None,
            })

        # Get total count for pagination
        count_query = "SELECT COUNT(*) AS total FROM orders WHERE seller_id = %s AND escrow_id IS NOT NULL"
        count_params = [user["id"]]
        if status:
            count_query += """
                AND EXISTS (
                    SELECT 1 FROM escrows e WHERE e.id = orders.escrow_id AND e.status = %s
                )
            """
            count_params.append(status)

        cursor.execute(count_query, count_params)
        total = cursor.fetchone()["total"]

        cursor.close()
        conn.close()

        return jsonify({
            "escrows": combined_data,
            "pagination": {
                "total": total,
                "limit": limit,
                "offset": offset,
                "hasMore": offset + limit < total
            }
        }), 200

    except Exception as e:
        print("Error fetching storefront escrows:", e)
        return jsonify({"error": "Internal server error"}), 500

def get_db_connection():
    return pymysql.connect(
        host=os.environ.get("DB_HOST", "localhost"),
        user=os.environ.get("DB_USER", "root"),
        password=os.environ.get("DB_PASSWORD", ""),
        database=os.environ.get("DB_NAME", "mydb"),
        cursorclass=pymysql.cursors.DictCursor,
        autocommit=True
    )

def create_table_if_not_exists():
    conn = get_db_connection()
    try:
        with conn.cursor() as cur:
            cur.execute("""
                CREATE TABLE IF NOT EXISTS storefront_profiles (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    username VARCHAR(255),
                    picture VARCHAR(500),
                    btc VARCHAR(255),
                    eth VARCHAR(255),
                    xrpbEvm VARCHAR(255),
                    xrpbSol VARCHAR(255),
                    xrpbXrpl VARCHAR(255)
                )
            """)
    finally:
        conn.close()

create_table_if_not_exists()

# GET profile
@storefront_bp.route("/profile", methods=["GET"])
def get_profile():
    conn = get_db_connection()
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM storefront_profiles LIMIT 1")
            profile = cur.fetchone()
            return jsonify({"success": True, "profile": profile})
    finally:
        conn.close()

# POST profile (insert or update)
@storefront_bp.route("/profile", methods=["POST"])
def save_profile():
    data = request.json
    conn = get_db_connection()
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM storefront_profiles LIMIT 1")
            existing = cur.fetchone()
            if existing:
                cur.execute("""
                    UPDATE storefront_profiles SET
                        username=%s, picture=%s, btc=%s, eth=%s, xrpbEvm=%s, xrpbSol=%s, xrpbXrpl=%s
                    WHERE id=%s
                """, (
                    data.get("username"),
                    data.get("picture"),
                    data.get("btc"),
                    data.get("eth"),
                    data.get("xrpbEvm"),
                    data.get("xrpbSol"),
                    data.get("xrpbXrpl"),
                    existing["id"]
                ))
            else:
                cur.execute("""
                    INSERT INTO storefront_profiles (username, picture, btc, eth, xrpbEvm, xrpbSol, xrpbXrpl)
                    VALUES (%s,%s,%s,%s,%s,%s,%s)
                """, (
                    data.get("username"),
                    data.get("picture"),
                    data.get("btc"),
                    data.get("eth"),
                    data.get("xrpbEvm"),
                    data.get("xrpbSol"),
                    data.get("xrpbXrpl")
                ))
            return jsonify({"success": True, "message": "Profile saved successfully"})
    finally:
        conn.close()

@storefront_bp.route("/listings/<listing_id>", methods=["GET"])
def get_storefront_listing_by_id(listing_id):
    """
    GET - Fetch a single listing by ID
    URL params: listing_id - The ID of the listing to fetch
    """
    try:
        # Validate listing_id
        if not listing_id:
            return jsonify({"error": "Listing ID is required"}), 400

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        # Fetch listing details
        cursor.execute("""
            SELECT id, user_id, title, description, price, category, chain, is_physical,
                   images, tags, status, views, created_at, updated_at, shipping_from,
                   stock_quantity, original_stock, low_stock_threshold,
                   is_auction, starting_bid, current_bid, bid_increment, auction_end_date, buy_now_price
            FROM listings
            WHERE id = %s
        """, (listing_id,))
        listing = cursor.fetchone()

        if not listing:
            cursor.close()
            conn.close()
            return jsonify({"error": "Listing not found"}), 404

        # Increment views
        cursor.execute("UPDATE listings SET views = views + 1 WHERE id = %s", (listing_id,))
        conn.commit()

        # Parse JSON fields
        # Parse images
        if isinstance(listing.get("images"), str):
            try:
                listing["images"] = json.loads(listing["images"])
            except Exception:
                listing["images"] = []
        
        # Parse tags
        if isinstance(listing.get("tags"), str):
            try:
                listing["tags"] = json.loads(listing["tags"])
            except Exception:
                listing["tags"] = []

        # Parse shipping_from
        if isinstance(listing.get("shipping_from"), str):
            try:
                listing["shipping_from"] = json.loads(listing["shipping_from"])
            except Exception:
                listing["shipping_from"] = None

        # Convert price to float
        if "price" in listing:
            listing["price"] = float(listing["price"])

        # Convert numeric fields
        numeric_fields = ["starting_bid", "current_bid", "bid_increment", "buy_now_price"]
        for field in numeric_fields:
            if field in listing and listing[field] is not None:
                listing[field] = float(listing[field])

        cursor.close()
        conn.close()

        return jsonify({"listing": listing}), 200

    except Exception as e:
        print(f"Error fetching listing: {e}")
        return jsonify({"error": f"Internal server error: {str(e)}"}), 500

# Cloudinary signature endpoint
@storefront_bp.route("/cloudinary/signature", methods=["POST"])
def generate_signature():
    data = request.json
    api_secret = os.environ.get("CLOUDINARY_API_SECRET")
    params_to_sign = {k: v for k, v in data.items() if v is not None}
    sorted_params = sorted(params_to_sign.items())
    query_string = "&".join(f"{k}={v}" for k, v in sorted_params)
    signature = hmac.new(api_secret.encode("utf-8"), query_string.encode("utf-8"), hashlib.sha1).hexdigest()
    return jsonify({"signature": signature, "api_key": os.environ.get("CLOUDINARY_API_KEY")})