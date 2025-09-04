from flask import Blueprint, request, jsonify
from extensions.extensions import get_db_connection
from middleware.admin_auth import verify_admin_token

admin_listings_bp = Blueprint("admin_listings", __name__)

def admin_auth_required():
    auth_header = request.headers.get("Authorization", "")
    token = auth_header.replace("Bearer ", "")
    auth_result = verify_admin_token(auth_header)
    if not auth_result["success"]:
        return None, (jsonify({"error": auth_result.get("error", "Unauthorized")}), auth_result.get("status", 401))
    return token, None

@admin_listings_bp.route("/listings", methods=["GET"])
def get_listings():
    # Verify admin token
    auth_header = request.headers.get("Authorization", "")
    token = auth_header.replace("Bearer ", "")
    print(f"Token: {token}")
    auth_result = verify_admin_token(auth_header)
    if not auth_result["success"]:
        return jsonify({"error": auth_result.get("error", "Unauthorized")}), auth_result.get("status", 401)

    # Query params
    limit = int(request.args.get("limit", 50))
    offset = int(request.args.get("offset", 0))
    status = request.args.get("status")
    category = request.args.get("category")
    search = request.args.get("search")

    where_clause = "WHERE 1=1"
    query_params = []

    if status and status != "all":
        where_clause += " AND l.status = %s"
        query_params.append(status)

    if category and category != "all":
        where_clause += " AND l.category = %s"
        query_params.append(category)

    if search:
        where_clause += " AND (l.title LIKE %s OR l.description LIKE %s)"
        query_params.extend([f"%{search}%", f"%{search}%"])

    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Fetch listings
        cursor.execute(
            f"""
            SELECT 
                l.id,
                l.title,
                l.description,
                l.price,
                l.category,
                l.chain,
                l.is_physical,
                l.images,
                l.tags,
                l.status,
                l.views,
                l.created_at,
                l.shipping_from,
                l.updated_at,
                u.username AS seller,
                u.email AS seller_email
            FROM listings l
            JOIN users u ON l.user_id = u.id
            {where_clause}
            ORDER BY l.created_at DESC
            LIMIT %s OFFSET %s
            """,
            query_params + [limit, offset]
        )
        listings = cursor.fetchall()

        # Parse JSON fields
        for l in listings:
            if isinstance(l.get("images"), str):
                import json
                l["images"] = json.loads(l["images"])
            if isinstance(l.get("tags"), str):
                import json
                l["tags"] = json.loads(l["tags"])
            if isinstance(l.get("shipping_from"), str):
                import json
                l["shipping_from"] = json.loads(l["shipping_from"])
            l["image"] = l["images"][0] if l.get("images") and len(l["images"]) > 0 else None
            l["createdAt"] = l["created_at"]
            l["updatedAt"] = l["updated_at"]

        # Total count for pagination
        cursor.execute(
            f"""
            SELECT COUNT(*) AS total
            FROM listings l
            JOIN users u ON l.user_id = u.id
            {where_clause}
            """,
            query_params
        )
        total = cursor.fetchone()["total"]

        cursor.close()
        conn.close()

        return jsonify({
            "listings": listings,
            "total": total,
            "limit": limit,
            "offset": offset
        })
    except Exception as e:
        print("Error fetching admin listings:", e)
        return jsonify({"error": "Internal server error"}), 500


# Approve Listing
@admin_listings_bp.route("/listings/<string:listing_id>/approve", methods=["POST"])
def approve_listing(listing_id):
    token, error = admin_auth_required()
    if error: return error

    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("UPDATE listings SET status = 'approved' WHERE id = %s", (listing_id,))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"success": True, "message": "Listing approved"})
    except Exception as e:
        print("Error approving listing:", e)
        return jsonify({"error": "Internal server error"}), 500

# Reject Listing
@admin_listings_bp.route("/listings/<string:listing_id>/reject", methods=["POST"])
def reject_listing(listing_id):
    token, error = admin_auth_required()
    if error: return error

    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("UPDATE listings SET status = 'rejected' WHERE id = %s", (listing_id,))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"success": True, "message": "Listing rejected"})
    except Exception as e:
        print("Error rejecting listing:", e)
        return jsonify({"error": "Internal server error"}), 500

# Delete Listing
@admin_listings_bp.route("/listings/<string:listing_id>/delete", methods=["DELETE"])
def delete_listing(listing_id):
    token, error = admin_auth_required()
    if error: return error

    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("DELETE FROM listings WHERE id = %s", (listing_id,))
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({"success": True, "message": "Listing deleted"})
    except Exception as e:
        print("Error deleting listing:", e)
        return jsonify({"error": "Internal server error"}), 500
