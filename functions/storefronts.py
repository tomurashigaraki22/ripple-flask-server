from flask import Blueprint, request, jsonify
from extensions.extensions import get_db_connection
from datetime import datetime
import json
from uuid import uuid4
import pymysql

storefronts_bp = Blueprint('storefronts', __name__)

# User Profiles Routes
@storefronts_bp.route("/profile", methods=["POST"])
def create_profile():
    try:
        data = request.get_json()
        required_fields = ["owner_id", "name"]
        
        if not all(field in data for field in required_fields):
            return jsonify({"error": "Missing required fields"}), 400
            
        storefront_id = str(uuid4())  # Generate unique storefront ID
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute("""
            INSERT INTO user_profiles 
            (owner_id, storefront_id, name, title, bio, avatar, cover_image, 
             location, joined_date, email, phone)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            data["owner_id"],
            storefront_id,
            data["name"],
            data.get("title"),
            data.get("bio"),
            data.get("avatar"),
            data.get("cover_image"),
            data.get("location"),
            datetime.now().date(),
            data.get("email"),
            data.get("phone")
        ))
        
        conn.commit()
        cursor.close()
        conn.close()
        
        return jsonify({
            "message": "Profile created successfully",
            "storefront_id": storefront_id
        }), 201
        
    except Exception as e:
        print("Error creating profile:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefronts_bp.route("/profile/<storefront_id>", methods=["GET"])
def get_profile(storefront_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Fetch profile
        cursor.execute("""
            SELECT * FROM user_profiles WHERE storefront_id = %s
        """, (storefront_id,))
        profile = cursor.fetchone()
        
        if not profile:
            return jsonify({"error": "Profile not found"}), 404
            
        # Fetch services
        cursor.execute("""
            SELECT * FROM services WHERE storefront_id = %s
        """, (storefront_id,))
        services = cursor.fetchall()
        
        # Fetch social links
        cursor.execute("""
            SELECT * FROM social_media_links WHERE storefront_id = %s
        """, (storefront_id,))
        social_links = cursor.fetchall()
        
        # Fetch theme
        cursor.execute("""
            SELECT * FROM gradient_themes 
            WHERE storefront_id = %s AND is_active = TRUE
        """, (storefront_id,))
        theme = cursor.fetchone()
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "profile": profile,
            "services": services,
            "social_links": social_links,
            "theme": theme
        })
        
    except Exception as e:
        print("Error fetching profile:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefronts_bp.route("/profile/<storefront_id>", methods=["PUT"])
def update_profile(storefront_id):
    try:
        data = request.get_json()
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        update_fields = []
        params = []
        
        # Dynamically build update query based on provided fields
        for field in ["name", "title", "bio", "avatar", "cover_image", 
                     "location", "email", "phone"]:
            if field in data:
                update_fields.append(f"{field} = %s")
                params.append(data[field])
        
        if not update_fields:
            return jsonify({"error": "No fields to update"}), 400
            
        params.append(storefront_id)
        
        query = f"""
            UPDATE user_profiles 
            SET {", ".join(update_fields)}
            WHERE storefront_id = %s
        """
        
        cursor.execute(query, params)
        conn.commit()
        
        if cursor.rowcount == 0:
            return jsonify({"error": "Profile not found"}), 404
            
        cursor.close()
        conn.close()
        
        return jsonify({"message": "Profile updated successfully"}), 200
        
    except Exception as e:
        print("Error updating profile:", e)
        return jsonify({"error": "Internal server error"}), 500

# Services Routes
@storefronts_bp.route("/services", methods=["POST"])
def create_service():
    try:
        data = request.get_json()
        required_fields = ["owner_id", "storefront_id", "title", "description"]
        
        if not all(field in data for field in required_fields):
            return jsonify({"error": "Missing required fields"}), 400
            
        features = json.dumps(data.get("features", []))
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute("""
            INSERT INTO services 
            (owner_id, storefront_id, title, description, price_text, 
             starting_price, features, category)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            data["owner_id"],
            data["storefront_id"],
            data["title"],
            data["description"],
            data.get("price_text"),
            data.get("starting_price"),
            features,
            data.get("category")
        ))
        
        conn.commit()
        service_id = cursor.lastrowid
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "message": "Service created successfully",
            "service_id": service_id
        }), 201
        
    except Exception as e:
        print("Error creating service:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefronts_bp.route("/services/<int:service_id>", methods=["PUT"])
def update_service(service_id):
    try:
        data = request.get_json()
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        update_fields = []
        params = []
        
        for field in ["title", "description", "price_text", "starting_price", 
                     "features", "category", "is_active"]:
            if field in data:
                if field == "features":
                    update_fields.append("features = %s")
                    params.append(json.dumps(data[field]))
                else:
                    update_fields.append(f"{field} = %s")
                    params.append(data[field])
        
        if not update_fields:
            return jsonify({"error": "No fields to update"}), 400
            
        params.append(service_id)
        
        query = f"""
            UPDATE services 
            SET {", ".join(update_fields)}
            WHERE id = %s
        """
        
        cursor.execute(query, params)
        conn.commit()
        
        if cursor.rowcount == 0:
            return jsonify({"error": "Service not found"}), 404
            
        cursor.close()
        conn.close()
        
        return jsonify({"message": "Service updated successfully"}), 200
        
    except Exception as e:
        print("Error updating service:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefronts_bp.route("/services/<int:service_id>", methods=["DELETE"])
def delete_service(service_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute("DELETE FROM services WHERE id = %s", (service_id,))
        conn.commit()
        
        if cursor.rowcount == 0:
            return jsonify({"error": "Service not found"}), 404
            
        cursor.close()
        conn.close()
        
        return jsonify({"message": "Service deleted successfully"}), 200
        
    except Exception as e:
        print("Error deleting service:", e)
        return jsonify({"error": "Internal server error"}), 500

# Theme Routes
@storefronts_bp.route("/themes", methods=["POST"])
def create_theme():
    try:
        data = request.get_json()
        required_fields = ["owner_id", "storefront_id", "name", 
                         "primary_color", "secondary_color", "accent_color"]
        
        if not all(field in data for field in required_fields):
            return jsonify({"error": "Missing required fields"}), 400
            
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Deactivate other themes if this one is active
        if data.get("is_active", False):
            cursor.execute("""
                UPDATE gradient_themes 
                SET is_active = FALSE 
                WHERE storefront_id = %s
            """, (data["storefront_id"],))
        
        cursor.execute("""
            INSERT INTO gradient_themes 
            (owner_id, storefront_id, name, primary_color, 
             secondary_color, accent_color, is_active)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (
            data["owner_id"],
            data["storefront_id"],
            data["name"],
            data["primary_color"],
            data["secondary_color"],
            data["accent_color"],
            data.get("is_active", False)
        ))
        
        conn.commit()
        theme_id = cursor.lastrowid
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "message": "Theme created successfully",
            "theme_id": theme_id
        }), 201
        
    except Exception as e:
        print("Error creating theme:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefronts_bp.route("/themes/<storefront_id>", methods=["GET"])
def get_themes(storefront_id):
    """Get all themes for a storefront"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        cursor.execute("""
            SELECT id, name, primary_color, secondary_color, accent_color, 
                   is_active, is_preset, created_at, updated_at
            FROM gradient_themes 
            WHERE storefront_id = %s
            ORDER BY is_active DESC, created_at DESC
        """, (storefront_id,))
        
        themes = cursor.fetchall()
        cursor.close()
        conn.close()
        
        return jsonify({
            "themes": themes
        }), 200
        
    except Exception as e:
        print("Error fetching themes:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefronts_bp.route("/social-links/<storefront_id>", methods=["GET"])
def get_social_links(storefront_id):
    """Get all social links for a storefront"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        cursor.execute("""
            SELECT id, platform, url, is_active, created_at
            FROM social_media_links
            WHERE storefront_id = %s AND is_active = TRUE
            ORDER BY created_at DESC
        """, (storefront_id,))
        
        social_links = cursor.fetchall()
        cursor.close()
        conn.close()
        
        return jsonify({
            "social_links": social_links
        }), 200
        
    except Exception as e:
        print("Error fetching social links:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefronts_bp.route("/social-links/<int:link_id>", methods=["DELETE"])
def delete_social_link(link_id):
    """Delete a social media link"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute("DELETE FROM social_media_links WHERE id = %s", (link_id,))
        conn.commit()
        
        if cursor.rowcount == 0:
            return jsonify({"error": "Social link not found"}), 404
            
        cursor.close()
        conn.close()
        
        return jsonify({"message": "Social link deleted successfully"}), 200
        
    except Exception as e:
        print("Error deleting social link:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefronts_bp.route("/music-widgets/<storefront_id>", methods=["GET"])
def get_music_widgets(storefront_id):
    """Get all music widgets for a storefront"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        cursor.execute("""
            SELECT id, widget_type, widget_url, is_active, created_at, updated_at
            FROM music_widget_settings
            WHERE storefront_id = %s AND is_active = TRUE
            ORDER BY created_at DESC
        """, (storefront_id,))
        
        widgets = cursor.fetchall()
        cursor.close()
        conn.close()
        
        return jsonify({
            "music_widgets": widgets
        }), 200
        
    except Exception as e:
        print("Error fetching music widgets:", e)
        return jsonify({"error": "Internal server error"}), 500

# Add CRUD operations for music widgets
@storefronts_bp.route("/music-widgets", methods=["POST"])
def create_music_widget():
    """Create a new music widget"""
    try:
        data = request.get_json()
        required_fields = ["owner_id", "storefront_id", "widget_type", "widget_url"]
        
        if not all(field in data for field in required_fields):
            return jsonify({"error": "Missing required fields"}), 400
            
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Validate widget_type
        if data["widget_type"] not in ["spotify", "soundcloud"]:
            return jsonify({"error": "Invalid widget_type. Must be 'spotify' or 'soundcloud'"}), 400
        
        cursor.execute("""
            INSERT INTO music_widget_settings 
            (owner_id, storefront_id, widget_type, widget_url, is_active)
            VALUES (%s, %s, %s, %s, %s)
        """, (
            data["owner_id"],
            data["storefront_id"],
            data["widget_type"],
            data["widget_url"],
            data.get("is_active", True)
        ))
        
        conn.commit()
        widget_id = cursor.lastrowid
        
        cursor.close()
        conn.close()
        
        return jsonify({
            "message": "Music widget created successfully",
            "widget_id": widget_id
        }), 201
        
    except Exception as e:
        print("Error creating music widget:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefronts_bp.route("/music-widgets/<int:widget_id>", methods=["PUT"])
def update_music_widget(widget_id):
    """Update a music widget"""
    try:
        data = request.get_json()
        
        conn = get_db_connection()
        cursor = conn.cursor()
        
        update_fields = []
        params = []
        
        for field in ["widget_type", "widget_url", "is_active"]:
            if field in data:
                if field == "widget_type" and data[field] not in ["spotify", "soundcloud"]:
                    return jsonify({"error": "Invalid widget_type. Must be 'spotify' or 'soundcloud'"}), 400
                update_fields.append(f"{field} = %s")
                params.append(data[field])
        
        if not update_fields:
            return jsonify({"error": "No fields to update"}), 400
            
        params.append(widget_id)
        
        query = f"""
            UPDATE music_widget_settings 
            SET {", ".join(update_fields)}
            WHERE id = %s
        """
        
        cursor.execute(query, params)
        conn.commit()
        
        if cursor.rowcount == 0:
            return jsonify({"error": "Music widget not found"}), 404
            
        cursor.close()
        conn.close()
        
        return jsonify({"message": "Music widget updated successfully"}), 200
        
    except Exception as e:
        print("Error updating music widget:", e)
        return jsonify({"error": "Internal server error"}), 500

@storefronts_bp.route("/music-widgets/<int:widget_id>", methods=["DELETE"])
def delete_music_widget(widget_id):
    """Delete a music widget"""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute("DELETE FROM music_widget_settings WHERE id = %s", (widget_id,))
        conn.commit()
        
        if cursor.rowcount == 0:
            return jsonify({"error": "Music widget not found"}), 404
            
        cursor.close()
        conn.close()
        
        return jsonify({"message": "Music widget deleted successfully"}), 200
        
    except Exception as e:
        print("Error deleting music widget:", e)
        return jsonify({"error": "Internal server error"}), 500