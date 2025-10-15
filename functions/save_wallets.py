from extensions.extensions import get_db_connection, mail, Message
from flask import Blueprint, jsonify, request, make_response
import pymysql
import jwt
import os

save_wallets_bp = Blueprint("save_wallets", __name__)

def verify_user_access(req):
    auth_header = req.headers.get("Authorization")

    if not auth_header or not auth_header.startswith("Bearer "):
        return {"error": "Missing or invalid authorization header", "status": 401}

    token = auth_header.split(" ")[1]

    try:
        decoded = jwt.decode(token, os.getenv("JWT_SECRET"), algorithms=["HS256"])
    except jwt.ExpiredSignatureError:
        return {"error": "Token has expired", "status": 401}
    except jwt.InvalidTokenError:
        return {"error": "Invalid token", "status": 401}

    user_id = decoded.get("userId") or decoded.get("id") or decoded.get("user_id")
    if not user_id:
        return {"error": "Invalid token payload", "status": 401}

    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SELECT id, email, username FROM users WHERE id = %s", (user_id,))
        user = cursor.fetchone()
        conn.close()

        if not user:
            return {"error": "User not found", "status": 404}

        return {"user": user}

    except Exception as e:
        print("DB error in verify_user_access:", e)
        return {"error": "Internal server error", "status": 500}


def create_wallets_table():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS wallets (
                id INT AUTO_INCREMENT PRIMARY KEY,
                user_id INT NOT NULL UNIQUE,
                sui_address TEXT DEFAULT NULL,
                sui_enc_key TEXT DEFAULT NULL,
                evm_address TEXT DEFAULT NULL,
                evm_enc_key TEXT DEFAULT NULL,
                sol_address TEXT DEFAULT NULL,
                sol_enc_key TEXT DEFAULT NULL,
                xrp_address TEXT DEFAULT NULL,
                xrp_enc_key TEXT DEFAULT NULL,
                FOREIGN KEY (user_id) REFERENCES users(id)
            )
        """)
        conn.commit()
        conn.close()
    except Exception as e:
        print("DB error in create_wallets_table:", e)
        return {"error": "Internal server error", "status": 500}

create_wallets_table()


@save_wallets_bp.route("/save-wallet", methods=["POST"])
def saveWalletsForUser():
    try:
        auth_result = verify_user_access(request)
        if "user" not in auth_result:
            return make_response(jsonify({"error": auth_result.get("error", "Unauthorized")}), auth_result.get("status", 401))

        user_id = auth_result["user"]["id"]
        data = request.json

        # Extract possible wallet fields
        sui_address = data.get("sui_address")
        sui_enc_key = data.get("sui_enc_key")
        evm_address = data.get("evm_address")
        evm_enc_key = data.get("evm_enc_key")
        sol_address = data.get("sol_address")
        sol_enc_key = data.get("sol_enc_key")
        xrp_address = data.get("xrp_address")
        xrp_enc_key = data.get("xrp_enc_key")

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        # Check if wallet row exists
        cursor.execute("SELECT * FROM wallets WHERE user_id = %s", (user_id,))
        wallet = cursor.fetchone()

        # Create an empty wallet row if none exists yet
        if not wallet:
            cursor.execute("INSERT INTO wallets (user_id) VALUES (%s)", (user_id,))
            conn.commit()
            cursor.execute("SELECT * FROM wallets WHERE user_id = %s", (user_id,))
            wallet = cursor.fetchone()

        updates = []
        values = []

        # Check each type individually
        if sui_address and sui_enc_key:
            if wallet["sui_address"] is not None:
                conn.close()
                return make_response(jsonify({"error": "Sui wallet already exists for this user"}), 409)
            updates.append("sui_address = %s")
            updates.append("sui_enc_key = %s")
            values.extend([sui_address, sui_enc_key])

        if evm_address and evm_enc_key:
            if wallet["evm_address"] is not None:
                conn.close()
                return make_response(jsonify({"error": "EVM wallet already exists for this user"}), 409)
            updates.append("evm_address = %s")
            updates.append("evm_enc_key = %s")
            values.extend([evm_address, evm_enc_key])

        if sol_address and sol_enc_key:
            if wallet["sol_address"] is not None:
                conn.close()
                return make_response(jsonify({"error": "Solana wallet already exists for this user"}), 409)
            updates.append("sol_address = %s")
            updates.append("sol_enc_key = %s")
            values.extend([sol_address, sol_enc_key])

        if xrp_address and xrp_enc_key:
            if wallet["xrp_address"] is not None:
                conn.close()
                return make_response(jsonify({"error": "XRP wallet already exists for this user"}), 409)
            updates.append("xrp_address = %s")
            updates.append("xrp_enc_key = %s")
            values.extend([xrp_address, xrp_enc_key])

        if not updates:
            conn.close()
            return make_response(jsonify({"error": "No valid wallet data provided"}), 400)

        values.append(user_id)
        query = f"UPDATE wallets SET {', '.join(updates)} WHERE user_id = %s"
        cursor.execute(query, tuple(values))
        conn.commit()
        conn.close()

        return make_response(jsonify({"message": "Wallet saved successfully"}), 200)

    except Exception as e:
        print("Error in saveWalletsForUser:", e)
        return make_response(jsonify({"error": "Internal server error"}), 500)


@save_wallets_bp.route("/get-wallet", methods=["GET"])
def getWalletsForUser():
    try:
        user_id = request.args.get("user_id")
        email = request.args.get("email")

        if not user_id and not email:
            return make_response(jsonify({"error": "Provide either user_id or email"}), 400)

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        if email:
            cursor.execute("SELECT id FROM users WHERE email = %s", (email,))
            user_row = cursor.fetchone()
            if not user_row:
                conn.close()
                return make_response(jsonify({"error": "User not found"}), 404)
            user_id = user_row["id"]

        cursor.execute("SELECT * FROM wallets WHERE user_id = %s", (user_id,))
        wallet = cursor.fetchone()
        conn.close()

        if not wallet:
            return make_response(jsonify({"error": "Wallet not found"}), 404)

        return make_response(jsonify({"wallet": wallet}), 200)

    except Exception as e:
        print("Error in getWalletsForUser:", e)
        return make_response(jsonify({"error": "Internal server error"}), 500)
