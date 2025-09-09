from flask import Blueprint, request, jsonify
import jwt
from extensions.extensions import get_db_connection, app
import os

user_bp = Blueprint('user', __name__)

# Add JWT_SECRET with fallback
JWT_SECRET = os.getenv("JWT_SECRET", "supersecret")

@user_bp.route("/me", methods=["GET"])
def get_current_user():
    try:
        auth_header = request.headers.get("Authorization")

        # 🔹 Check for Bearer token
        if not auth_header or not auth_header.startswith("Bearer "):
            return jsonify({"error": "Missing or invalid authorization header"}), 401

        token = auth_header.split(" ")[1]

        try:
            # 🔹 Decode JWT using JWT_SECRET variable
            decoded = jwt.decode(token, JWT_SECRET, algorithms=["HS256"])
        except jwt.ExpiredSignatureError:
            return jsonify({"error": "Token has expired"}), 401
        except jwt.InvalidTokenError:
            return jsonify({"error": "Invalid token"}), 401

        # 🔹 Check for both 'id' and 'userId' for compatibility
        user_id = decoded.get("id") or decoded.get("userId")
        if not user_id:
            return jsonify({"error": "Invalid token payload"}), 401

        # 🔹 Query database
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute(
            "SELECT id, email, username, role_id, created_at FROM users WHERE id = %s",
            (user_id,)
        )
        user = cursor.fetchone()
        conn.close()

        if not user:
            return jsonify({"error": "User not found"}), 404

        # 🔹 Format response (exclude password)
        user_data = {
            "id": user[0],
            "email": user[1],
            "username": user[2],
            "role_id": user[3],
            "created_at": user[4].strftime("%Y-%m-%d %H:%M:%S") if user[4] else None
        }

        return jsonify(user_data), 200

    except Exception as e:
        print("Get user error:", e)
        return jsonify({"error": "Internal server error"}), 500