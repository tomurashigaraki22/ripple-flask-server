from flask import Blueprint, request, jsonify
import pymysql
import jwt
import os
from datetime import datetime, timezone
from functools import wraps
from extensions.extensions import get_db_connection

# Blueprint for storefront background
storefront_background_bp = Blueprint('storefront_background', __name__)

JWT_SECRET = os.getenv("JWT_SECRET", "your-secret-key")

def verify_storefront_access(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        token = request.headers.get('Authorization')
        if not token:
            return jsonify({"error": "No token provided"}), 401
        
        try:
            if token.startswith('Bearer '):
                token = token[7:]
            decoded = jwt.decode(token, JWT_SECRET, algorithms=['HS256'])
            request.storefront_id = decoded.get('storefront_id')
            request.user_id = decoded.get('user_id')
        except jwt.ExpiredSignatureError:
            return jsonify({"error": "Token has expired"}), 401
        except jwt.InvalidTokenError:
            return jsonify({"error": "Invalid token"}), 401
        
        return f(*args, **kwargs)
    return decorated_function

def create_background_table():
    """Create storefront_backgrounds table if it doesn't exist"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS storefront_backgrounds (
                id INT AUTO_INCREMENT PRIMARY KEY,
                storefront_id VARCHAR(36) NOT NULL,
                background_url TEXT,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                is_active BOOLEAN DEFAULT TRUE,
                INDEX idx_storefront_id (storefront_id)
            )
        """)
        
        conn.commit()
        cursor.close()
        conn.close()
        
    except Exception as e:
        print(f"Error creating storefront_backgrounds table: {str(e)}")

def update_storefront_profiles_table():
    """Add background_preference column to storefront_profiles table if it doesn't exist"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Check if column exists
        cursor.execute("""
            SELECT COLUMN_NAME 
            FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_NAME = 'storefront_profiles' 
            AND COLUMN_NAME = 'background_preference'
        """)
        
        if not cursor.fetchone():
            # Add the column if it doesn't exist
            cursor.execute("""
                ALTER TABLE storefront_profiles 
                ADD COLUMN background_preference ENUM('gradient', 'image') DEFAULT 'gradient'
            """)
            conn.commit()
            print("✅ Added background_preference column to storefront_profiles table")
        
        cursor.close()
        conn.close()
        
    except Exception as e:
        print(f"Error updating storefront_profiles table: {str(e)}")

# Create tables when module is imported
create_background_table()
update_storefront_profiles_table()

@storefront_background_bp.route("/get/<string:storefront_id>", methods=["GET"])
def get_background(storefront_id):
    """Get background for a specific storefront"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        cursor.execute("""
            SELECT id, storefront_id, background_url, created_at, updated_at, is_active
            FROM storefront_backgrounds 
            WHERE storefront_id = %s
            ORDER BY updated_at DESC
            LIMIT 1
        """, (storefront_id,))
        
        background = cursor.fetchone()
        cursor.close()
        conn.close()
        
        if background:
            return jsonify({
                "success": True,
                "background": background
            })
        else:
            return jsonify({
                "success": True,
                "background": None,
                "message": "No background found for this storefront"
            })
            
    except Exception as e:
        print(f"Error getting background: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_background_bp.route("/preference", methods=["GET"])
def get_background_preference():
    """Get background preference for storefront profile"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        cursor.execute("""
            SELECT background_preference 
            FROM storefront_profiles 
            LIMIT 1
        """)
        
        result = cursor.fetchone()
        cursor.close()
        conn.close()
        print(f"Result: {result}")
        
        preference = result['background_preference'] if result else 'gradient'
        
        return jsonify({
            "success": True,
            "background_preference": preference
        })
            
    except Exception as e:
        print(f"Error getting background preference: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_background_bp.route("/preference", methods=["POST"])
@verify_storefront_access
def set_background_preference():
    """Set background preference (gradient or image) for storefront"""
    try:
        data = request.get_json()
        print(f"Data: {data}")
        if not data or 'preference' not in data:
            return jsonify({"error": "Background preference is required"}), 400
        
        preference = data['preference']
        if preference not in ['gradient', 'image']:
            return jsonify({"error": "Invalid preference. Must be 'gradient' or 'image'"}), 400
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Check if profile exists
        cursor.execute("SELECT id FROM storefront_profiles LIMIT 1")
        existing = cursor.fetchone()
        print(f"Existing: {existing}")
        
        if existing:
            # Update existing profile
            cursor.execute("""
                UPDATE storefront_profiles 
                SET background_preference = %s
                WHERE id = %s
            """, (preference, existing['id']))
        else:
            # Create new profile with preference
            cursor.execute("""
                INSERT INTO storefront_profiles (background_preference)
                VALUES (%s)
            """, (preference,))
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "message": f"Background preference set to {preference}",
            "background_preference": preference
        })
        
    except Exception as e:
        print(f"Error setting background preference: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_background_bp.route("/create", methods=["POST"])
@verify_storefront_access
def create_background():
    """Create or update background for storefront"""
    try:
        data = request.get_json()
        if not data or 'background_url' not in data:
            return jsonify({"error": "Background URL is required"}), 400
        
        background_url = data['background_url']
        storefront_id = data.get("storefront_id") or data.get("id") or data.get("userId") or data.get("user_id")
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Check if background already exists for this storefront
        cursor.execute("""
            SELECT id FROM storefront_backgrounds 
            WHERE storefront_id = %s
        """, (storefront_id,))
        
        existing = cursor.fetchone()
        
        if existing:
            # Update existing background
            cursor.execute("""
                UPDATE storefront_backgrounds 
                SET background_url = %s, updated_at = NOW()
                WHERE storefront_id = %s
            """, (background_url, storefront_id))
            
            message = "Background updated successfully"
        else:
            # Create new background
            cursor.execute("""
                INSERT INTO storefront_backgrounds (storefront_id, background_url)
                VALUES (%s, %s)
            """, (storefront_id, background_url))
            
            message = "Background created successfully"
        
        # Automatically set preference to 'image' when background is created/updated
        # First get the profile ID, then update it
        cursor.execute("SELECT id FROM storefront_profiles LIMIT 1")
        profile = cursor.fetchone()
        
        if profile:
            cursor.execute("""
                UPDATE storefront_profiles 
                SET background_preference = 'image'
                WHERE id = %s
            """, (profile['id'],))
        else:
            # Create a new profile if none exists
            cursor.execute("""
                INSERT INTO storefront_profiles (background_preference)
                VALUES ('image')
            """)
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "message": message,
            "background_preference": "image"
        })
        
    except Exception as e:
        print(f"Error creating/updating background: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_background_bp.route("/toggle/<string:storefront_id>", methods=["PUT"])
@verify_storefront_access
def toggle_background(storefront_id):
    """Activate or deactivate background"""
    try:
        data = request.get_json()
        if not data or 'is_active' not in data:
            return jsonify({"error": "is_active field is required"}), 400
        
        is_active = data['is_active']
        
        # Verify storefront ownership
        if request.storefront_id != storefront_id:
            return jsonify({"error": "Unauthorized access to this storefront"}), 403
        
        create_background_table()
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute("""
            UPDATE storefront_backgrounds 
            SET is_active = %s, updated_at = NOW()
            WHERE storefront_id = %s
        """, (is_active, storefront_id))
        
        if cursor.rowcount == 0:
            cursor.close()
            conn.close()
            return jsonify({"error": "Background not found for this storefront"}), 404
        
        conn.commit()
        cursor.close()
        conn.close()
        
        status = "activated" if is_active else "deactivated"
        return jsonify({
            "success": True,
            "message": f"Background {status} successfully"
        })
        
    except Exception as e:
        print(f"Error toggling background: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_background_bp.route("/delete/<string:storefront_id>", methods=["DELETE"])
@verify_storefront_access
def delete_background(storefront_id):
    """Delete background for storefront"""
    try:
        # Verify storefront ownership
        if request.storefront_id != storefront_id:
            return jsonify({"error": "Unauthorized access to this storefront"}), 403
        
        create_background_table()
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute("""
            DELETE FROM storefront_backgrounds 
            WHERE storefront_id = %s
        """, (storefront_id,))
        
        if cursor.rowcount == 0:
            cursor.close()
            conn.close()
            return jsonify({"error": "Background not found for this storefront"}), 404
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "message": "Background deleted successfully"
        })
        
    except Exception as e:
        print(f"Error deleting background: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500