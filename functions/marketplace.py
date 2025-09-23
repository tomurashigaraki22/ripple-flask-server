from flask import Blueprint, request, jsonify
from extensions.extensions import get_db_connection  # your helper for DB connection

marketplace_bp = Blueprint("marketplace", __name__)

@marketplace_bp.route("/listings", methods=["GET"]) 
def get_marketplace_listings(): 
    try: 
        # Query params 
        limit = int(request.args.get("limit", 8)) 
        page = int(request.args.get("page", 1)) 
        offset = (page - 1) * limit 
        category = request.args.get("category") 
        subcategory = request.args.get("subcategory")  # Add subcategory parameter
        chain = request.args.get("chain") 
        is_physical = request.args.get("isPhysical") 
        search = request.args.get("search") 
        sort_by = request.args.get("sortBy", "recent") 
        price_range = request.args.get("priceRange")

        # Base query 
        where_clause = 'WHERE l.status = "approved" AND l.status != "sold"' 
        query_params = [] 

        # Handle category and subcategory filtering
        if category and category != "all": 
            where_clause += " AND l.category = %s" 
            query_params.append(category)
            
            # Add subcategory filtering if provided
            if subcategory and subcategory != "all":
                where_clause += " AND l.subcategory = %s"
                query_params.append(subcategory)

        if chain and chain != "all": 
            where_clause += " AND l.chain = %s" 
            query_params.append(chain) 

        if is_physical and is_physical.lower() != "all": 
            where_clause += " AND LOWER(l.category) = 'physical' AND l.is_physical = %s" 
            query_params.append(1 if is_physical.lower() == "physical" else 0) 

        # Add price range filtering 
        if price_range and price_range != "all": 
            if price_range == "1000+": 
                where_clause += " AND l.price >= %s" 
                query_params.append(1000) 
            else: 
                # Handle ranges like "0-50", "50-200", etc. 
                price_min, price_max = map(float, price_range.split("-")) 
                where_clause += " AND l.price >= %s AND l.price <= %s" 
                query_params.extend([price_min, price_max]) 

        if search: 
            where_clause += " AND (l.title LIKE %s OR l.description LIKE %s)" 
            query_params.extend([f"%{search}%", f"%{search}%"]) 

        # Sorting 
        order_clause = "ORDER BY l.created_at DESC" 
        if sort_by == "price_low": 
            order_clause = "ORDER BY l.price ASC" 
        elif sort_by == "price_high": 
            order_clause = "ORDER BY l.price DESC" 
        elif sort_by == "popular": 
            order_clause = "ORDER BY l.views DESC" 

        conn = get_db_connection() 
        cursor = conn.cursor() 

        # Main query 
        cursor.execute(f""" 
            SELECT 
                l.id, 
                l.title, 
                l.description, 
                l.price, 
                l.category, 
                l.subcategory,  # Add subcategory to the SELECT statement
                l.chain, 
                l.is_physical, 
                l.images, 
                l.tags, 
                l.views, 
                l.created_at, 
                l.shipping_from, 
                l.updated_at, 
                u.username as seller_username, 
                u.id as seller_id 
            FROM listings l 
            JOIN users u ON l.user_id = u.id 
            {where_clause} 
            {order_clause} 
            LIMIT %s OFFSET %s 
        """, (*query_params, limit, offset)) 
        listings = cursor.fetchall() 

        # Count query 
        cursor.execute(f""" 
            SELECT COUNT(*) as total 
            FROM listings l 
            JOIN users u ON l.user_id = u.id 
            {where_clause} 
        """, tuple(query_params)) 
        total = cursor.fetchone()["total"] 

        cursor.close() 
        conn.close() 

        total_pages = (total + limit - 1) // limit  # ceiling division 

        # Parse JSON fields 
        for listing in listings: 
            if isinstance(listing.get("images"), str): 
                try: 
                    import json 
                    listing["images"] = json.loads(listing["images"]) 
                except: 
                    listing["images"] = [] 
            if isinstance(listing.get("tags"), str): 
                try: 
                    import json 
                    listing["tags"] = json.loads(listing["tags"]) 
                except: 
                    listing["tags"] = [] 
            if isinstance(listing.get("shipping_from"), str): 
                try: 
                    import json 
                    listing["shipping_from"] = json.loads(listing["shipping_from"]) 
                except: 
                    listing["shipping_from"] = {} 

        return jsonify({ 
            "listings": listings, 
            "pagination": { 
                "total": total, 
                "totalPages": total_pages, 
                "currentPage": page, 
                "limit": limit, 
                "hasMore": page < total_pages, 
                "hasPrevious": page > 1 
            } 
        }) 

    except Exception as e: 
        print("Error fetching marketplace listings:", e) 
        return jsonify({"error": "Internal server error"}), 500

@marketplace_bp.route("/listings/<string:id>", methods=["GET"])
def get_listing(id):
    try:
        wallet_address = request.args.get("wallet")
        conn = get_db_connection()
        cursor = conn.cursor()

        # Fetch listing details
        cursor.execute("""
            SELECT 
                l.id,
                l.title,
                l.description,
                l.price,
                l.category,
                l.subcategory,
                l.brand,
                l.model,
                l.condition_type,
                l.chain,
                l.status,
                l.stock_quantity,
                l.original_stock,
                l.low_stock_threshold,
                l.is_physical,
                l.is_auction,
                l.shipping_from,
                l.starting_bid,
                l.current_bid,
                l.bid_increment,
                l.buy_now_price,
                l.auction_end_date,
                l.weight,
                l.length,
                l.width,
                l.height,
                l.color,
                l.size,
                l.material,
                l.sku,
                l.isbn,
                l.upc_ean,
                l.country,
                l.state_province,
                l.city,
                l.original_price,
                l.discount_percentage,
                l.bulk_pricing,
                l.key_features,
                l.technical_specs,
                l.compatibility,
                l.warranty_period,
                l.warranty_type,
                l.return_policy,
                l.return_period_days,
                l.shipping_weight,
                l.shipping_dimensions,
                l.shipping_cost,
                l.free_shipping,
                l.shipping_methods,
                l.processing_time_days,
                l.quantity_available,
                l.min_order_quantity,
                l.max_order_quantity,
                l.age_restriction,
                l.requires_assembly,
                l.energy_rating,
                l.certifications,
                l.included_accessories,
                l.care_instructions,
                l.storage_requirements,
                l.images,
                l.tags,
                l.views,
                l.created_at,
                l.updated_at,
                u.username as seller_username,
                u.id as seller_id
            FROM listings l
            JOIN users u ON l.user_id = u.id
            WHERE l.id = %s AND l.status = 'approved'
        """, (id,))
        listings = cursor.fetchall()

        if len(listings) == 0:
            return jsonify({"error": "Listing not found or not available"}), 404

        listing = listings[0]

        # Fetch seller wallets
        cursor.execute("""
            SELECT chain, address, is_primary
            FROM wallet_addresses
            WHERE user_id = %s
            ORDER BY is_primary DESC, chain ASC
        """, (listing["seller_id"],))
        seller_wallets = cursor.fetchall()

        # Determine payment info
        payment_info = None
        if wallet_address:
            cursor.execute("""
                SELECT chain FROM wallet_addresses WHERE address = %s
            """, (wallet_address,))
            connected_wallet_info = cursor.fetchall()

            if connected_wallet_info:
                connected_chain = connected_wallet_info[0]["chain"]
                matching_seller_wallet = next(
                    (w for w in seller_wallets if w["chain"] == connected_chain),
                    None
                )

                if matching_seller_wallet:
                    payment_info = {
                        "buyerWallet": wallet_address,
                        "sellerWallet": matching_seller_wallet["address"],
                        "chain": connected_chain,
                        "price": listing["price"],
                        "currency": get_chain_currency(connected_chain)
                    }

        # Get recent orders / bids
        cursor.execute("""
            SELECT 
                o.amount,
                o.created_at,
                u.username as bidder_username
            FROM orders o
            JOIN users u ON o.buyer_id = u.id
            WHERE o.listing_id = %s AND o.status != 'cancelled'
            ORDER BY o.created_at DESC
            LIMIT 10
        """, (id,))
        recent_orders = cursor.fetchall()

        # Increment views
        cursor.execute("UPDATE listings SET views = views + 1 WHERE id = %s", (id,))
        conn.commit()

        # Format response
        formatted_listing = {
            **listing,
            "images": parse_json_field(listing.get("images")),
            "tags": parse_json_field(listing.get("tags")),
            "dimensions": parse_json_field(listing.get("dimensions")),
            "features": parse_json_field(listing.get("features")),
            "specifications": parse_json_field(listing.get("specifications")),
            "shipping_info": parse_json_field(listing.get("shipping_info")),
            "shipping_from": parse_json_field(listing.get("shipping_from")),
            "seller": {
                "id": listing["seller_id"],
                "username": listing["seller_username"],
                "wallets": seller_wallets
            },
            "paymentInfo": payment_info,
            "bidHistory": [
                {
                    "amount": order["amount"],
                    "bidder": order["bidder_username"],
                    "time": order["created_at"]
                }
                for order in recent_orders
            ]
        }

        return jsonify({"listing": formatted_listing})

    except Exception as e:
        print("Error fetching listing details:", e)
        return jsonify({"error": "Internal server error"}), 500
    finally:
        cursor.close()
        conn.close()

def parse_json_field(value):
    import json
    if isinstance(value, str):
        try:
            return json.loads(value)
        except Exception:
            return value
    return value

def get_chain_currency(chain):
    # All chains use XRPB token
    return "XRPB"