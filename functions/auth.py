from flask import Blueprint, request, jsonify
from extensions.extensions import get_db_connection
import bcrypt
import jwt
import os
from datetime import datetime, timedelta
import uuid

auth_bp = Blueprint("auth", __name__)

JWT_SECRET = os.getenv("JWT_SECRET", "supersecret")

# -------------------- LOGIN -----------------------
@auth_bp.route("/login", methods=["POST"])
def login():
    try:
        data = request.get_json()
        email = data.get("email")
        password = data.get("password")

        # ✅ Validate input
        if not email or not password:
            return jsonify({"error": "Missing required fields"}), 400

        conn = get_db_connection()
        if not conn:
            return jsonify({"error": "Database connection failed"}), 500

        try:
            with conn.cursor() as cursor:
                cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
                user = cursor.fetchone()
        finally:
            conn.close()

        if not user:
            return jsonify({"error": "Invalid credentials"}), 401

        # ✅ Verify password
        if not bcrypt.checkpw(password.encode("utf-8"), user["password"].encode("utf-8")):
            return jsonify({"error": "Invalid credentials"}), 401

        # ✅ Generate JWT token with new payload structure
        payload = {
            "id": user["id"],
            "email": user["email"],
            "username": user["username"],
            "iat": datetime.utcnow(),
            "exp": datetime.utcnow() + timedelta(days=7)  # 7 day expiry
        }
        token = jwt.encode(payload, JWT_SECRET, algorithm="HS256")

        # ✅ Remove password before sending user back
        user.pop("password", None)

        return jsonify({
            "user": user,
            "token": token
        }), 200

    except Exception as e:
        print("Login error:", e)
        return jsonify({"error": "Internal server error"}), 500


# -------------------- REGISTER --------------------
@auth_bp.route("/register", methods=["POST"])
def register():
    try:
        data = request.get_json()
        username = data.get("username")
        email = data.get("email")
        password = data.get("password")

        # Validate input
        if not username or not email or not password:
            return jsonify({"error": "Missing required fields"}), 400

        conn = get_db_connection()
        if not conn:
            return jsonify({"error": "Database connection failed"}), 500

        try:
            with conn.cursor() as cursor:
                # Check if user exists
                cursor.execute(
                    "SELECT * FROM users WHERE email = %s OR username = %s",
                    (email, username)
                )
                existing = cursor.fetchone()

                if existing:
                    return jsonify({"error": "User already exists"}), 400

                # Hash password
                hashed_password = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
                user_id = str(uuid.uuid4())

                # Insert user (role_id = 3 for normal user, adjust as needed)
                cursor.execute(
                    "INSERT INTO users (id, username, email, password, role_id) VALUES (%s, %s, %s, %s, %s)",
                    (user_id, username, email, hashed_password, 3)
                )
                conn.commit()

                # Fetch created user (without password)
                cursor.execute(
                    "SELECT id, username, email, created_at FROM users WHERE id = %s",
                    (user_id,)
                )
                new_user = cursor.fetchone()

                # ✅ Generate JWT token for new user
                payload = {
                    "id": new_user["id"],
                    "email": new_user["email"],
                    "username": new_user["username"],
                    "iat": datetime.utcnow(),
                    "exp": datetime.utcnow() + timedelta(days=7)  # 7 day expiry
                }
                token = jwt.encode(payload, JWT_SECRET, algorithm="HS256")

        finally:
            conn.close()

        return jsonify({
            "user": new_user,
            "token": token
        }), 200

    except Exception as e:
        print("Registration error:", e)
        return jsonify({"error": "Internal server error"}), 500