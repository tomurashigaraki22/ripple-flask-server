from flask import Blueprint, request, jsonify
import pymysql
import json
from extensions.extensions import get_db_connection

storefront_settings_bp = Blueprint("storefront_settings", __name__)

# def create_table_if_not_exists():
#     conn = get_db_connection()
#     try:
#         with conn.cursor() as cur:
#             # Check if table exists
#             cur.execute("SHOW TABLES LIKE 'storefront_settings'")
#             if cur.fetchone() is None:
#                 # Table does not exist, create it from scratch
#                 cur.execute("""
#                     CREATE TABLE storefront_settings (
#                         storefront_id CHAR(36) NOT NULL PRIMARY KEY,
#                         low_stock_alert BOOLEAN DEFAULT TRUE,
#                         promotional_email_alert BOOLEAN DEFAULT TRUE,
#                         new_order_alerts BOOLEAN DEFAULT TRUE,
#                         storefront_design JSON
#                     )
#                 """)
#             else:
#                 # Table exists, check for storefront_id
#                 cur.execute("SHOW COLUMNS FROM storefront_settings LIKE 'storefront_id'")
#                 if not cur.fetchone():
#                     # First drop old primary key if exists
#                     cur.execute("SHOW COLUMNS FROM storefront_settings LIKE 'id'")
#                     if cur.fetchone():
#                         # Drop primary key constraint first
#                         cur.execute("ALTER TABLE storefront_settings DROP PRIMARY KEY")
#                         # Optionally drop old id column
#                         cur.execute("ALTER TABLE storefront_settings DROP COLUMN id")
                    
#                     # Now add storefront_id as UUID primary key
#                     cur.execute("""
#                         ALTER TABLE storefront_settings
#                         ADD COLUMN storefront_id CHAR(36) NOT NULL PRIMARY KEY
#                     """)
#             conn.commit()
#     finally:
#         conn.close()


# create_table_if_not_exists()


# GET settings for a storefront UUID
@storefront_settings_bp.route("/settings/<string:storefront_id>", methods=["GET"])
def get_settings(storefront_id):
    conn = get_db_connection()
    try:
        with conn.cursor(pymysql.cursors.DictCursor) as cur:
            cur.execute("SELECT * FROM storefront_settings WHERE storefront_id=%s", (storefront_id,))
            settings = cur.fetchone()
            if not settings:
                # Default settings if none exist
                settings = {
                    "low_stock_alert": True,
                    "promotional_email_alert": True,
                    "new_order_alerts": True,
                    "storefront_design": {}
                }
            return jsonify({"success": True, "settings": settings}), 200
    finally:
        conn.close()


# POST update settings for a storefront UUID (partial update)
@storefront_settings_bp.route("/settings/<string:storefront_id>", methods=["POST"])
def update_settings(storefront_id):
    data = request.json
    conn = get_db_connection()
    try:
        with conn.cursor(pymysql.cursors.DictCursor) as cur:
            cur.execute("SELECT * FROM storefront_settings WHERE storefront_id=%s", (storefront_id,))
            existing = cur.fetchone()

            if existing:
                # Parse existing design JSON
                existing_design = json.loads(existing.get("storefront_design") or "{}")
                new_design = data.get("storefront_design") or {}

                # Ensure new_design is a dict
                if isinstance(new_design, str):
                    try:
                        new_design = json.loads(new_design)
                    except json.JSONDecodeError:
                        new_design = {}

                # Merge
                existing_design.update(new_design)

                cur.execute("""
                    UPDATE storefront_settings SET
                        low_stock_alert=%s,
                        promotional_email_alert=%s,
                        new_order_alerts=%s,
                        storefront_design=%s
                    WHERE storefront_id=%s
                """, (
                    data.get("low_stock_alert", existing["low_stock_alert"]),
                    data.get("promotional_email_alert", existing["promotional_email_alert"]),
                    data.get("new_order_alerts", existing["new_order_alerts"]),
                    json.dumps(existing_design),
                    storefront_id
                ))

            else:
                # Insert new row
                cur.execute("""
                    INSERT INTO storefront_settings 
                        (storefront_id, low_stock_alert, promotional_email_alert, new_order_alerts, storefront_design)
                    VALUES (%s,%s,%s,%s,%s)
                """, (
                    storefront_id,
                    data.get("low_stock_alert", True),
                    data.get("promotional_email_alert", True),
                    data.get("new_order_alerts", True),
                    json.dumps(data.get("storefront_design") or {})
                ))

            conn.commit()
            return jsonify({"success": True, "message": "Settings saved successfully"}), 200
    finally:
        conn.close()
