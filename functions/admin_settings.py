import pymysql
from flask import Blueprint, jsonify, request
from extensions.extensions import get_db_connection  # assuming you have this already

admin_settings_bp = Blueprint('admin_settings', __name__)

def init_site_settings_table():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS site_settings (
            id INT PRIMARY KEY AUTO_INCREMENT,
            is_maintenance BOOLEAN NOT NULL DEFAULT FALSE,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        )
    """)
    conn.commit()

    # ✅ Ensure at least one row exists
    cursor.execute("SELECT COUNT(*) as cnt FROM site_settings")
    result = cursor.fetchone()
    count = result[0] if isinstance(result, tuple) else result["cnt"]

    if count == 0:
        cursor.execute("INSERT INTO site_settings (is_maintenance) VALUES (FALSE)")
        conn.commit()

    cursor.close()
    conn.close()


@admin_settings_bp.route('/api/admin/settings/status', methods=['GET'])
def get_maintenance_status():
    try:
        init_site_settings_table()  # ✅ make sure table + row exist
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute("SELECT is_maintenance FROM site_settings LIMIT 1")
        result = cursor.fetchone()
        cursor.close()
        conn.close()
        print(f"Result: {bool(result["is_maintenance"])}")

        return jsonify({"is_maintenance": bool(result["is_maintenance"])}), 200
    except Exception as e:
        print(f"Error fetching maintenance status: {str(e)}")
        return jsonify({"error": str(e)}), 500


@admin_settings_bp.route('/api/admin/settings/toggle', methods=['POST'])
def toggle_maintenance_status():
    try:
        data = request.get_json()
        new_status = data.get("is_maintenance")

        if new_status is None:
            return jsonify({"error": "Missing 'is_maintenance'"}), 400

        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("UPDATE site_settings SET is_maintenance = %s WHERE id = 1", (new_status,))
        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({
            "success": True,
            "is_maintenance": bool(new_status),
            "message": "Maintenance mode updated"
        }), 200
    except Exception as e:
        return jsonify({"error": str(e)}), 500
