from flask import Blueprint, request, jsonify
from extensions.extensions import get_db_connection
from middleware.admin_auth import verify_admin_token
import pymysql

admin_users_bp = Blueprint("admin_users", __name__)

# --- Helper to verify admin ---
def admin_required(auth_header):
    result = verify_admin_token(auth_header)
    if not result.get("success"):
        return None, jsonify({"error": result.get("error")}), result.get("status", 401)
    return result.get("user"), None, None

# --- GET Users ---
@admin_users_bp.route("/users", methods=["GET", "OPTIONS"])
def get_admin_users():
    if request.method == "OPTIONS":
        return '', 200

    auth_header = request.headers.get("Authorization", "")
    _, err_response, err_status = admin_required(auth_header)
    if err_response:
        return err_response, err_status

    try:
        role = request.args.get("role")
        membership = request.args.get("membership")
        search = request.args.get("search")
        status = request.args.get("status")
        get_all_users = request.args.get("all", "false").lower() == "true"

        limit = int(request.args.get("limit", 50))
        offset = int(request.args.get("offset", 0))

        where_clauses = ["1=1"]
        query_params = []

        if role and role != "all":
            where_clauses.append("r.name = %s")
            query_params.append(role)

        if membership and membership != "all":
            where_clauses.append("mt.name = %s")
            query_params.append(membership)

        if status and status != "all":
            where_clauses.append("u.status = %s")
            query_params.append(status)

        if search:
            where_clauses.append("(u.username LIKE %s OR u.email LIKE %s OR u.id LIKE %s)")
            query_params.extend([f"%{search}%", f"%{search}%", f"%{search}%"])

        where_clause = " AND ".join(where_clauses)
        limit_clause = ""
        if not get_all_users:
            limit_clause = "LIMIT %s OFFSET %s"
            query_params.extend([limit, offset])

        conn = get_db_connection()
        try:
            with conn.cursor(pymysql.cursors.DictCursor) as cur:
                cur.execute(f"""
                    SELECT 
                        u.id,
                        u.username,
                        u.email,
                        u.status,
                        u.created_at,
                        u.updated_at,
                        r.name AS role,
                        mt.name AS membershipTier
                    FROM users u
                    JOIN roles r ON u.role_id = r.id
                    JOIN membership_tiers mt ON u.membership_tier_id = mt.id
                    WHERE {where_clause}
                    ORDER BY u.created_at DESC
                    {limit_clause}
                """, query_params)

                users = cur.fetchall()

                if not get_all_users:
                    count_query_params = query_params[:-2]
                    cur.execute(f"""
                        SELECT COUNT(*) AS total
                        FROM users u
                        JOIN roles r ON u.role_id = r.id
                        JOIN membership_tiers mt ON u.membership_tier_id = mt.id
                        WHERE {where_clause}
                    """, count_query_params)
                    total = cur.fetchone()["total"]
                    return jsonify({
                        "users": users,
                        "total": total,
                        "page": (offset // limit) + 1,
                        "totalPages": -(-total // limit)
                    })

                return jsonify({
                    "users": users,
                    "total": len(users)
                })
        finally:
            conn.close()

    except Exception as e:
        print("Error fetching users:", str(e))
        return jsonify({"error": "Internal server error"}), 500

# --- Suspend User ---
@admin_users_bp.route("/users/<string:user_id>/suspend", methods=["POST"])
def suspend_user(user_id):
    auth_header = request.headers.get("Authorization", "")
    _, err_response, err_status = admin_required(auth_header)
    if err_response:
        return err_response, err_status

    try:
        conn = get_db_connection()
        with conn.cursor(pymysql.cursors.DictCursor) as cur:
            cur.execute("UPDATE users SET status='suspended' WHERE id=%s", (user_id,))
            conn.commit()
        return jsonify({"success": True, "message": f"User {user_id} suspended"})
    finally:
        conn.close()

# --- Reactivate User ---
@admin_users_bp.route("/users/<string:user_id>/reactivate", methods=["POST"])
def reactivate_user(user_id):
    auth_header = request.headers.get("Authorization", "")
    _, err_response, err_status = admin_required(auth_header)
    if err_response:
        return err_response, err_status

    try:
        conn = get_db_connection()
        with conn.cursor(pymysql.cursors.DictCursor) as cur:
            cur.execute("UPDATE users SET status='active' WHERE id=%s", (user_id,))
            conn.commit()
        return jsonify({"success": True, "message": f"User {user_id} reactivated"})
    finally:
        conn.close()

# --- Make User Admin ---
@admin_users_bp.route("/users/<string:user_id>/make-admin", methods=["POST"])
def make_admin(user_id):
    auth_header = request.headers.get("Authorization", "")
    _, err_response, err_status = admin_required(auth_header)
    if err_response:
        return err_response, err_status

    try:
        conn = get_db_connection()
        with conn.cursor(pymysql.cursors.DictCursor) as cur:
            cur.execute("SELECT id FROM roles WHERE name='admin'")
            admin_role = cur.fetchone()
            if not admin_role:
                return jsonify({"error": "Admin role not found"}), 500
            cur.execute("UPDATE users SET role_id=%s WHERE id=%s", (admin_role["id"], user_id))
            conn.commit()
        return jsonify({"success": True, "message": f"User {user_id} is now an admin"})
    finally:
        conn.close()

# --- Delete User ---
@admin_users_bp.route("/users/<string:user_id>/delete", methods=["DELETE"])
def delete_user(user_id):
    auth_header = request.headers.get("Authorization", "")
    _, err_response, err_status = admin_required(auth_header)
    if err_response:
        return err_response, err_status

    try:
        conn = get_db_connection()
        with conn.cursor(pymysql.cursors.DictCursor) as cur:
            cur.execute("DELETE FROM users WHERE id=%s", (user_id,))
            conn.commit()
        return jsonify({"success": True, "message": f"User {user_id} deleted"})
    finally:
        conn.close()
