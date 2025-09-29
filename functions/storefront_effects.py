from flask import Blueprint, request, jsonify
import pymysql
import jwt
import os
from datetime import datetime, timezone
from functools import wraps
from extensions.extensions import get_db_connection
import json

# Blueprint for storefront effects
storefront_effects_bp = Blueprint('storefront_effects', __name__)

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

def create_effects_table():
    """Create storefront_effects table if it doesn't exist"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS storefront_effects (
                id INT AUTO_INCREMENT PRIMARY KEY,
                storefront_id VARCHAR(36) NOT NULL,
                effect_type ENUM('blur', 'brightness', 'contrast', 'saturate', 'hue-rotate', 'sepia', 'grayscale', 'invert', 'opacity', 'drop-shadow') NOT NULL,
                effect_name VARCHAR(100) NOT NULL,
                effect_config JSON,
                intensity INT DEFAULT 50,
                is_active BOOLEAN DEFAULT FALSE,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                INDEX idx_storefront_id (storefront_id),
                INDEX idx_effect_type (effect_type),
                UNIQUE KEY unique_storefront_effect (storefront_id, effect_type, effect_name)
            )
        """)
        
        # Check if we need to update the ENUM to remove 'font' and ensure all effect types are present
        try:
            cursor.execute("""
                SELECT COLUMN_TYPE 
                FROM INFORMATION_SCHEMA.COLUMNS 
                WHERE TABLE_SCHEMA = DATABASE() 
                AND TABLE_NAME = 'storefront_effects' 
                AND COLUMN_NAME = 'effect_type'
            """)
            
            result = cursor.fetchone()
            if result:
                current_enum = result['COLUMN_TYPE']
                # Check if the ENUM needs updating (contains 'font' or missing any effect types)
                if "'font'" in current_enum or "'drop-shadow'" not in current_enum:
                    cursor.execute("""
                        ALTER TABLE storefront_effects 
                        MODIFY COLUMN effect_type ENUM('blur', 'brightness', 'contrast', 'saturate', 'hue-rotate', 'sepia', 'grayscale', 'invert', 'opacity', 'drop-shadow') NOT NULL
                    """)
                    print("Updated effect_type ENUM to match frontend effect types")
                    
        except Exception as enum_error:
            print(f"ENUM update error: {str(enum_error)}")
        
        # Check if intensity column exists, if not add it
        try:
            cursor.execute("""
                SELECT COUNT(*) as column_count
                FROM INFORMATION_SCHEMA.COLUMNS 
                WHERE TABLE_SCHEMA = DATABASE() 
                AND TABLE_NAME = 'storefront_effects' 
                AND COLUMN_NAME = 'intensity'
            """)
            
            result = cursor.fetchone()
            intensity_exists = result['column_count'] if result else 0
            
            if intensity_exists == 0:
                cursor.execute("""
                    ALTER TABLE storefront_effects 
                    ADD COLUMN intensity INT DEFAULT 50 AFTER effect_config
                """)
                print("Added intensity column to storefront_effects table")
                
        except Exception as migration_error:
            print(f"Migration error: {str(migration_error)}")
            # Try alternative approach - check if column exists by trying to select it
            try:
                cursor.execute("SELECT intensity FROM storefront_effects LIMIT 1")
                print("Intensity column already exists")
            except:
                # Column doesn't exist, add it
                try:
                    cursor.execute("""
                        ALTER TABLE storefront_effects 
                        ADD COLUMN intensity INT DEFAULT 50 AFTER effect_config
                    """)
                    print("Added intensity column to storefront_effects table (alternative method)")
                except Exception as alt_error:
                    print(f"Failed to add intensity column: {str(alt_error)}")
        
        # Create fonts table for font management
        cursor.execute("""
            CREATE TABLE IF NOT EXISTS storefront_fonts (
                id INT AUTO_INCREMENT PRIMARY KEY,
                storefront_id VARCHAR(36) NOT NULL,
                font_family VARCHAR(100) NOT NULL,
                is_selected BOOLEAN DEFAULT FALSE,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                INDEX idx_storefront_id (storefront_id),
                UNIQUE KEY unique_storefront_font (storefront_id)
            )
        """)
        
        conn.commit()
        cursor.close()
        conn.close()
        
    except Exception as e:
        print(f"Error creating storefront_effects table: {str(e)}")

# Create table when module is imported
create_effects_table()

@storefront_effects_bp.route("/get/<string:storefront_id>", methods=["GET"])
def get_effects(storefront_id):
    """Get all effects for a specific storefront"""
    try:
        create_effects_table()
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Get filter parameters
        effect_type = request.args.get('type')
        active_only = request.args.get('active_only', 'false').lower() == 'true'
        
        query = """
            SELECT id, storefront_id, effect_type, effect_name, effect_config, 
                   intensity, is_active, created_at, updated_at
            FROM storefront_effects 
            WHERE storefront_id = %s
        """
        params = [storefront_id]
        
        if effect_type:
            query += " AND effect_type = %s"
            params.append(effect_type)
        
        if active_only:
            query += " AND is_active = TRUE"
        
        query += " ORDER BY effect_type, effect_name"
        
        cursor.execute(query, params)
        effects = cursor.fetchall()
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "effects": effects,
            "count": len(effects)
        })
            
    except Exception as e:
        print(f"Error getting effects: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_effects_bp.route("/create", methods=["POST"])
@verify_storefront_access
def create_effect():
    """Create or update an effect for storefront"""
    try:
        data = request.get_json()
        required_fields = ['type', 'intensity']
        
        for field in required_fields:
            if not data or field not in data:
                return jsonify({"error": f"{field} is required"}), 400
        
        effect_type = data['type']
        effect_name = data.get('effect_name', effect_type)
        intensity = data['intensity']
        is_active = data.get('isActive', True)
        storefront_id = data.get('storefront_id') or request.storefront_id
        
        # Validate effect_type
        valid_types = ['blur', 'brightness', 'contrast', 'saturate', 'hue-rotate', 'sepia', 'grayscale', 'invert', 'opacity', 'drop-shadow']
        if effect_type not in valid_types:
            return jsonify({"error": f"Invalid effect_type. Must be one of: {', '.join(valid_types)}"}), 400
        
        # Validate intensity
        if not isinstance(intensity, int) or intensity < 0 or intensity > 100:
            return jsonify({"error": "Intensity must be an integer between 0 and 100"}), 400
        
        create_effects_table()
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Check if effect already exists for this storefront
        cursor.execute("""
            SELECT id FROM storefront_effects 
            WHERE storefront_id = %s AND effect_type = %s AND effect_name = %s
        """, (storefront_id, effect_type, effect_name))
        
        existing = cursor.fetchone()
        
        if existing:
            # Update existing effect
            cursor.execute("""
                UPDATE storefront_effects 
                SET intensity = %s, is_active = %s, updated_at = NOW()
                WHERE storefront_id = %s AND effect_type = %s AND effect_name = %s
            """, (intensity, is_active, storefront_id, effect_type, effect_name))
            
            message = f"Effect '{effect_name}' updated successfully"
        else:
            # Create new effect
            cursor.execute("""
                INSERT INTO storefront_effects (storefront_id, effect_type, effect_name, intensity, is_active)
                VALUES (%s, %s, %s, %s, %s)
            """, (storefront_id, effect_type, effect_name, intensity, is_active))
            
            message = f"Effect '{effect_name}' created successfully"
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "message": message
        })
        
    except Exception as e:
        print(f"Error creating/updating effect: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_effects_bp.route("/update/<int:effect_id>", methods=["PUT"])
@verify_storefront_access
def update_effect(effect_id):
    """Update an existing effect"""
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "No data provided"}), 400
        
        create_effects_table()
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Verify effect belongs to the authenticated storefront
        cursor.execute("""
            SELECT storefront_id FROM storefront_effects 
            WHERE id = %s
        """, (effect_id,))
        
        result = cursor.fetchone()
        if not result:
            cursor.close()
            conn.close()
            return jsonify({"error": "Effect not found"}), 404
        
        
        # Build update query dynamically
        update_fields = []
        params = []
        
        if 'type' in data:
            update_fields.append("effect_type = %s")
            params.append(data['type'])
        
        if 'intensity' in data:
            if not isinstance(data['intensity'], int) or data['intensity'] < 0 or data['intensity'] > 100:
                cursor.close()
                conn.close()
                return jsonify({"error": "Intensity must be an integer between 0 and 100"}), 400
            update_fields.append("intensity = %s")
            params.append(data['intensity'])
        
        if 'isActive' in data:
            update_fields.append("is_active = %s")
            params.append(data['isActive'])
        
        if not update_fields:
            cursor.close()
            conn.close()
            return jsonify({"error": "No valid fields to update"}), 400
        
        update_fields.append("updated_at = NOW()")
        params.append(effect_id)
        
        query = f"UPDATE storefront_effects SET {', '.join(update_fields)} WHERE id = %s"
        cursor.execute(query, params)
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "message": "Effect updated successfully"
        })
        
    except Exception as e:
        print(f"Error updating effect: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_effects_bp.route("/toggle/<int:effect_id>", methods=["PUT"])
@verify_storefront_access
def toggle_effect(effect_id):
    """Activate or deactivate a specific effect"""
    try:
        data = request.get_json()
        if not data or 'is_active' not in data:
            return jsonify({"error": "is_active field is required"}), 400
        
        is_active = data['is_active']
        
        create_effects_table()
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Verify effect belongs to the authenticated storefront
        cursor.execute("""
            SELECT storefront_id FROM storefront_effects 
            WHERE id = %s
        """, (effect_id,))
        
        result = cursor.fetchone()
        if not result:
            cursor.close()
            conn.close()
            return jsonify({"error": "Effect not found"}), 404
        

        cursor.execute("""
            UPDATE storefront_effects 
            SET is_active = %s, updated_at = NOW()
            WHERE id = %s
        """, (is_active, effect_id))
        
        conn.commit()
        cursor.close()
        conn.close()
        
        status = "activated" if is_active else "deactivated"
        return jsonify({
            "success": True,
            "message": f"Effect {status} successfully"
        })
        
    except Exception as e:
        print(f"Error toggling effect: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_effects_bp.route("/delete/<int:effect_id>", methods=["DELETE"])
@verify_storefront_access
def delete_effect(effect_id):
    """Delete a specific effect"""
    try:
        create_effects_table()
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Verify effect belongs to the authenticated storefront
        cursor.execute("""
            SELECT storefront_id FROM storefront_effects 
            WHERE id = %s
        """, (effect_id,))
        
        result = cursor.fetchone()
        if not result:
            cursor.close()
            conn.close()
            return jsonify({"error": "Effect not found"}), 404
        

        cursor.execute("""
            DELETE FROM storefront_effects 
            WHERE id = %s
        """, (effect_id,))
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "message": "Effect deleted successfully"
        })
        
    except Exception as e:
        print(f"Error deleting effect: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

# Font Management Routes
@storefront_effects_bp.route("/fonts/get/<string:storefront_id>", methods=["GET"])
def get_selected_font(storefront_id):
    """Get the selected font for a storefront"""
    try:
        create_effects_table()
        
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        cursor.execute("""
            SELECT font_family FROM storefront_fonts 
            WHERE storefront_id = %s AND is_selected = TRUE
        """, (storefront_id,))
        
        result = cursor.fetchone()
        cursor.close()
        conn.close()
        
        font_family = result['font_family'] if result else 'Inter'
        
        return jsonify({
            "success": True,
            "font_family": font_family
        })
        
    except Exception as e:
        print(f"Error getting selected font: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_effects_bp.route("/fonts/set", methods=["POST"])
@verify_storefront_access
def set_font():
    """Set the selected font for a storefront"""
    try:
        data = request.get_json()
        if not data or 'font_family' not in data:
            return jsonify({"error": "font_family is required"}), 400
        
        font_family = data['font_family']
        storefront_id = data.get('storefront_id') or request.storefront_id
        
        # Available fonts validation
        available_fonts = [
            'Inter', 'Roboto', 'Open Sans', 'Lato', 'Montserrat', 'Poppins',
            'Source Sans Pro', 'Oswald', 'Raleway', 'PT Sans', 'Merriweather',
            'Playfair Display', 'Crimson Text', 'Libre Baskerville'
        ]
        
        if font_family not in available_fonts:
            return jsonify({"error": f"Invalid font. Must be one of: {', '.join(available_fonts)}"}), 400
        
        create_effects_table()
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Check if font record exists
        cursor.execute("""
            SELECT id FROM storefront_fonts 
            WHERE storefront_id = %s
        """, (storefront_id,))
        
        existing = cursor.fetchone()
        
        if existing:
            # Update existing font
            cursor.execute("""
                UPDATE storefront_fonts 
                SET font_family = %s, is_selected = TRUE, updated_at = NOW()
                WHERE storefront_id = %s
            """, (font_family, storefront_id))
        else:
            # Create new font record
            cursor.execute("""
                INSERT INTO storefront_fonts (storefront_id, font_family, is_selected)
                VALUES (%s, %s, TRUE)
            """, (storefront_id, font_family))
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            "success": True,
            "message": f"Font set to {font_family}",
            "font_family": font_family
        })
        
    except Exception as e:
        print(f"Error setting font: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500

@storefront_effects_bp.route("/available-effects", methods=["GET"])
def get_available_effects():
    """Get list of available effects with descriptions"""
    available_effects = [
        { "id": "blur", "name": "Blur", "description": "Add blur effect to background" },
        { "id": "brightness", "name": "Brightness", "description": "Adjust brightness level" },
        { "id": "contrast", "name": "Contrast", "description": "Adjust contrast level" },
        { "id": "saturate", "name": "Saturation", "description": "Adjust color saturation" },
        { "id": "hue-rotate", "name": "Hue Rotate", "description": "Rotate color hue" },
        { "id": "sepia", "name": "Sepia", "description": "Add sepia tone effect" },
        { "id": "grayscale", "name": "Grayscale", "description": "Convert to grayscale" },
        { "id": "invert", "name": "Invert", "description": "Invert colors" },
        { "id": "opacity", "name": "Opacity", "description": "Adjust transparency" },
        { "id": "drop-shadow", "name": "Drop Shadow", "description": "Add drop shadow effect" }
    ]
    
    return jsonify({
        "success": True,
        "effects": available_effects
    })

@storefront_effects_bp.route("/available-fonts", methods=["GET"])
def get_available_fonts():
    """Get list of available fonts"""
    available_fonts = [
        'Inter', 'Roboto', 'Open Sans', 'Lato', 'Montserrat', 'Poppins',
        'Source Sans Pro', 'Oswald', 'Raleway', 'PT Sans', 'Merriweather',
        'Playfair Display', 'Crimson Text', 'Libre Baskerville'
    ]
    
    return jsonify({
        "success": True,
        "fonts": available_fonts
    })

@storefront_effects_bp.route("/bulk-toggle", methods=["PUT"])
@verify_storefront_access
def bulk_toggle_effects():
    """Activate or deactivate multiple effects"""
    try:
        data = request.get_json()
        if not data or 'effect_ids' not in data or 'is_active' not in data:
            return jsonify({"error": "effect_ids and is_active fields are required"}), 400
        
        effect_ids = data['effect_ids']
        is_active = data['is_active']
        storefront_id = request.storefront_id
        
        if not isinstance(effect_ids, list) or not effect_ids:
            return jsonify({"error": "effect_ids must be a non-empty list"}), 400
        
        create_effects_table()
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Create placeholders for the IN clause
        placeholders = ','.join(['%s'] * len(effect_ids))
        
        cursor.execute(f"""
            UPDATE storefront_effects 
            SET is_active = %s, updated_at = NOW()
            WHERE storefront_id = %s AND id IN ({placeholders})
        """, [is_active, storefront_id] + effect_ids)
        
        affected_rows = cursor.rowcount
        conn.commit()
        cursor.close()
        conn.close()
        
        status = "activated" if is_active else "deactivated"
        return jsonify({
            "success": True,
            "message": f"{affected_rows} effects {status} successfully"
        })
        
    except Exception as e:
        print(f"Error bulk toggling effects: {str(e)}")
        return jsonify({"error": "Internal server error"}), 500