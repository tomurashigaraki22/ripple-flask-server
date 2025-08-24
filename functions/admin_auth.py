from flask import Blueprint, request, jsonify
import pymysql
from extensions.extensions import get_db_connection
import bcrypt
import jwt
import os
from datetime import datetime, timedelta

admin_auth_bp = Blueprint("admin_auth", __name__)

@admin_auth_bp.route("/login", methods=["POST"])
def admin_login():
    try:
        data = request.json
        email = data.get("email")
        password = data.get("password")

        if not email or not password:
            return jsonify({"error": "Missing required fields"}), 400

        conn = get_db_connection()
        try:
            with conn.cursor(pymysql.cursors.DictCursor) as cur:
                # Get user with role 'admin'
                cur.execute("""
                    SELECT u.*, r.name as role_name
                    FROM users u
                    JOIN roles r ON u.role_id = r.id
                    WHERE u.email=%s AND r.name='admin'
                """, (email,))
                user = cur.fetchone()

                if not user:
                    return jsonify({"error": "Invalid admin credentials"}), 401

                # Check if account is active
                if user.get("status") != "active":
                    return jsonify({"error": "Account is not active"}), 401

                # Verify password
                if not bcrypt.checkpw(password.encode('utf-8'), user["password"].encode('utf-8')):
                    return jsonify({"error": "Invalid admin credentials"}), 401

                # Generate JWT token
                payload = {
                    "userId": user["id"],
                    "role": user["role_name"],
                    "email": user["email"],
                    "exp": datetime.utcnow() + timedelta(hours=24)
                }
                token = jwt.encode(payload, os.environ.get("JWT_SECRET"), algorithm="HS256")

                # Remove password from response
                user.pop("password", None)

                return jsonify({
                    "message": "Admin login successful",
                    "user": user,
                    "token": token,
                    "role": user["role_name"]
                }), 200

        finally:
            conn.close()

    except Exception as e:
        print("Admin login error:", e)
        return jsonify({"error": "Internal server error"}), 500
