import os
import jwt
import pymysql
from extensions.extensions import get_db_connection
from dotenv import load_dotenv

# Load .env variables
load_dotenv()
JWT_SECRET = os.getenv("JWT_SECRET")

def verify_admin_token(auth_header):
    """
    Verifies the admin JWT token from the Authorization header.
    Returns a dict with success, user (if valid), error, and status.
    """
    try:
        if not auth_header or not auth_header.startswith("Bearer "):
            return {"success": False, "error": "No authentication token provided", "status": 401}

        token = auth_header.replace("Bearer ", "")

        # Decode JWT
        decoded = jwt.decode(token, JWT_SECRET, algorithms=["HS256"])
        user_id = decoded.get("userId")
        print(f"Decoded: {decoded}")
        if not user_id:
            return {"success": False, "error": "Invalid token payload", "status": 401}

        # Fetch user with role information
        conn = get_db_connection()
        try:
            with conn.cursor(pymysql.cursors.DictCursor) as cur:
                cur.execute("""
                    SELECT u.*, r.name as role_name 
                    FROM users u 
                    JOIN roles r ON u.role_id = r.id 
                    WHERE u.id=%s AND u.status='active'
                """, (user_id,))
                user = cur.fetchone()
                # print(f"User: {user}")

                if not user:
                    return {"success": False, "error": "User not found or inactive", "status": 404}

                if user["role_name"] != "admin":
                    return {"success": False, "error": "Admin access required", "status": 403}

                return {"success": True, "user": user}

        except Exception as e:
            print("Database error:", e)
            return {"success": False, "error": "Database error", "status": 500}

        finally:
            conn.close()

    except jwt.ExpiredSignatureError:
        return {"success": False, "error": "Authentication token expired", "status": 401}
    except jwt.InvalidTokenError:
        return {"success": False, "error": "Invalid authentication token", "status": 401}
    except Exception as e:
        print("Authentication error:", e)
        return {"success": False, "error": "Authentication error", "status": 500}
