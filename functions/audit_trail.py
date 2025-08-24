from flask import Blueprint, request, jsonify
from extensions.extensions import get_db_connection
from middleware.admin_auth import verify_admin_token
import uuid
import json

audit_bp = Blueprint("audit", __name__)

@audit_bp.route("/audit-trail", methods=["GET"])
def get_audit_trail():
    try:
        # Verify admin token
        auth_header = request.headers.get("Authorization")
        auth_result = verify_admin_token(auth_header)
        if not auth_result["success"]:
            return jsonify({"error": auth_result["error"]}), auth_result["status"]

        # Must be admin (role_id = 1)
        # if auth_result["user"]["role_id"] != 1:
        #     return jsonify({"error": "Admin access required"}), 403

        # Query params
        page = int(request.args.get("page", 1))
        limit = int(request.args.get("limit", 100))
        action = request.args.get("action")
        target_type = request.args.get("target_type")
        admin_id = request.args.get("admin_id")
        start_date = request.args.get("start_date")
        end_date = request.args.get("end_date")
        offset = (page - 1) * limit

        # Build dynamic WHERE clause
        where_conditions = []
        query_params = []

        if action:
            where_conditions.append("at.action = %s")
            query_params.append(action)
        if target_type:
            where_conditions.append("at.target_type = %s")
            query_params.append(target_type)
        if admin_id:
            where_conditions.append("at.admin_id = %s")
            query_params.append(admin_id)
        if start_date:
            where_conditions.append("at.created_at >= %s")
            query_params.append(start_date)
        if end_date:
            where_conditions.append("at.created_at <= %s")
            query_params.append(end_date)

        where_clause = "WHERE " + " AND ".join(where_conditions) if where_conditions else ""

        conn = get_db_connection()
        cursor = conn.cursor()

        # Get total count
        count_query = f"SELECT COUNT(*) as total FROM audit_trail at {where_clause}"
        cursor.execute(count_query, query_params)
        count_result = cursor.fetchone()
        total = count_result["total"]

        # Get logs with pagination
        logs_query = f"""
            SELECT 
                at.*,
                u.username as admin_username,
                u.email as admin_email
            FROM audit_trail at
            JOIN users u ON at.admin_id = u.id
            {where_clause}
            ORDER BY at.created_at DESC
            LIMIT %s OFFSET %s
        """
        cursor.execute(logs_query, query_params + [limit, offset])
        logs = cursor.fetchall()

        # Parse details JSON
        formatted_logs = []
        for log in logs:
            log["details"] = json.loads(log["details"]) if log.get("details") and isinstance(log["details"], str) else log.get("details")
            formatted_logs.append(log)

        cursor.close()
        conn.close()

        return jsonify({
            "logs": formatted_logs,
            "pagination": {
                "page": page,
                "limit": limit,
                "total": total,
                "totalPages": (total + limit - 1) // limit
            }
        })

    except Exception as e:
        print("Error fetching audit trail:", e)
        return jsonify({"error": "Internal server error"}), 500


@audit_bp.route("/audit-trail", methods=["POST"])
def create_audit_log():
    try:
        # Verify admin token
        auth_header = request.headers.get("Authorization")
        auth_result = verify_admin_token(auth_header)
        if not auth_result["success"]:
            return jsonify({"error": auth_result["error"]}), auth_result["status"]

        # Must be admin (role_id = 1)
        # if auth_result["user"]["role_id"] != 1:
        #     return jsonify({"error": "Admin access required"}), 403

        data = request.get_json()
        action = data.get("action")
        target_type = data.get("target_type")
        target_id = data.get("target_id")
        details = data.get("details", {})
        ip_address = data.get("ip_address")

        # Validate required fields
        if not action or not target_type:
            return jsonify({"error": "Action and target_type are required"}), 400

        audit_id = str(uuid.uuid4())
        client_ip = ip_address or request.headers.get("X-Forwarded-For") or request.headers.get("X-Real-IP") or request.remote_addr or "unknown"

        conn = get_db_connection()
        cursor = conn.cursor()

        insert_query = """
            INSERT INTO audit_trail (id, admin_id, action, target_type, target_id, details, ip_address, created_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, NOW())
        """
        cursor.execute(insert_query, (
            audit_id,
            auth_result["user"]["id"],
            action,
            target_type,
            target_id,
            json.dumps(details),
            client_ip
        ))
        conn.commit()

        cursor.close()
        conn.close()

        return jsonify({
            "success": True,
            "audit_id": audit_id,
            "message": "Audit log created successfully"
        })

    except Exception as e:
        print("Error creating audit log:", e)
        return jsonify({"error": "Internal server error"}), 500
