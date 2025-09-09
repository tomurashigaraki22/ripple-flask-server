from extensions.extensions import app
from flask import jsonify, request
from functions.escrows import escrows_bp
from functions.storefront_orders import storefront_orders_bp
from functions.auth import auth_bp   # ⬅️ import the blueprint
from functions.user import user_bp
from functions.marketplace import marketplace_bp
import os
import hashlib
import uuid
from dotenv import load_dotenv
from functions.storefront import storefront_bp
from functions.storefront_analytics import storefront_analytics_bp
from functions.storefront_settings import storefront_settings_bp
from functions.admin_auth import admin_auth_bp
from functions.admin_dashboard import admin_dashboard_bp
from functions.admin_users import admin_users_bp
from functions.admin_listings import admin_listings_bp
from functions.admin import admin_bp
from functions.audit_trail import audit_bp
from functions.admin_settings import admin_settings_bp
from functions.escrows import escrows_bp
from functions.membership import membership_bp
from functions.orders import orders_bp
from functions.storefronts import storefronts_bp
from functions.storefront_notifications import storefront_notifications_bp
from functions.storefront_followers import storefront_followers_bp
import pymysql
from extensions.extensions import get_db_connection

from datetime import datetime
from flask_mail import Message
from extensions.extensions import mail, get_db_connection
from io import StringIO

load_dotenv()

# Health check
@app.route("/", methods=["GET"])
def checkHealth():
    return jsonify({
        "message": "Health Status is ok!",
        "status": 200
    })

#Cloudinary Signer
CLOUDINARY_API_KEY = os.getenv("CLOUDINARY_API_KEY")
CLOUDINARY_API_SECRET = os.getenv("CLOUDINARY_API_SECRET")

@app.route("/cloudinary/signature", methods=["POST"])
def cloudinary_signature():
    if not CLOUDINARY_API_KEY or not CLOUDINARY_API_SECRET:
        return jsonify({"error": "Cloudinary credentials not configured"}), 500

    try:
        data = request.get_json()
        timestamp = data.get("timestamp")
        folder = data.get("folder")
        public_id = data.get("public_id")

        # Create params to sign
        params_to_sign = {
            "folder": folder,
            "public_id": public_id,
            "timestamp": timestamp
        }

        # Sort params alphabetically and create query string
        sorted_params = "&".join(f"{k}={params_to_sign[k]}" for k in sorted(params_to_sign.keys()))

        # Append API secret
        string_to_sign = f"{sorted_params}{CLOUDINARY_API_SECRET}"

        # SHA1 hash
        signature = hashlib.sha1(string_to_sign.encode("utf-8")).hexdigest()

        return jsonify({
            "signature": signature,
            "api_key": CLOUDINARY_API_KEY,
            "timestamp": timestamp,
            "folder": folder,
            "public_id": public_id
        })

    except Exception as e:
        print("Signature generation error:", e)
        return jsonify({"error": "Failed to generate signature"}), 500

@app.route("/admin/database/add-shipping-column", methods=["POST"])
def add_shipping_column():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()

        # Check if column exists
        cursor.execute("""
            SELECT COUNT(*) AS count 
            FROM information_schema.columns 
            WHERE table_name = 'listings'
            AND column_name = 'shipping_from'
        """)
        result = cursor.fetchone()
        
        if result['count'] == 0:
            # Add the column if it doesn't exist
            cursor.execute("""
                ALTER TABLE listings 
                ADD COLUMN shipping_from JSON NULL
            """)
            conn.commit()
            return jsonify({"message": "shipping_from column added successfully"}), 200
        else:
            return jsonify({"message": "shipping_from column already exists"}), 200

    except Exception as e:
        print("Error adding shipping column:", str(e))
        return jsonify({"error": "Failed to add shipping column"}), 500
    finally:
        cursor.close()
        conn.close()

@app.route("/admin/database/dump", methods=["POST"])
def dump_database():
    """Generate database dump and email it"""
    try:
        conn = get_db_connection()
        if not conn:
            return jsonify({"error": "Database connection failed"}), 500
            
        cursor = conn.cursor()
        
        # Get all tables
        cursor.execute("SHOW TABLES")
        tables = [table.values()[0] for table in cursor.fetchall()]
        
        # Create string buffer for SQL content
        sql_content = StringIO()
        
        # Write header
        sql_content.write("-- RippleBids Database Dump\n")
        sql_content.write(f"-- Generated: {datetime.now()}\n\n")
        sql_content.write("SET NAMES utf8mb4;\n")
        sql_content.write("SET FOREIGN_KEY_CHECKS = 0;\n\n")
        
        # Dump each table
        for table in tables:
            # Get table creation SQL
            cursor.execute(f"SHOW CREATE TABLE {table}")
            create_table = cursor.fetchone()['Create Table']
            
            sql_content.write(f"-- Table structure for {table}\n")
            sql_content.write(f"DROP TABLE IF EXISTS `{table}`;\n")
            sql_content.write(create_table + ";\n\n")
            
            # Get table data
            cursor.execute(f"SELECT * FROM {table}")
            rows = cursor.fetchall()
            
            if rows:
                # Get column names
                columns = rows[0].keys()
                columns_str = ', '.join(f"`{col}`" for col in columns)
                
                sql_content.write(f"-- Data for {table}\n")
                
                # Process rows in batches of 1000
                batch_size = 1000
                for i in range(0, len(rows), batch_size):
                    batch = rows[i:i + batch_size]
                    values = []
                    
                    for row in batch:
                        row_values = []
                        for column in columns:
                            value = row[column]
                            if value is None:
                                row_values.append('NULL')
                            elif isinstance(value, (int, float)):
                                row_values.append(str(value))
                            elif isinstance(value, (datetime, datetime.date)):
                                row_values.append(f"'{value.strftime('%Y-%m-%d %H:%M:%S')}'")
                            else:
                                # Escape single quotes in strings
                                row_values.append(f"'{str(value).replace('\'', '\'\'')}'")
                        values.append(f"({', '.join(row_values)})")
                    
                    sql_content.write(f"INSERT INTO `{table}` ({columns_str}) VALUES\n")
                    sql_content.write(',\n'.join(values) + ";\n")
                
                sql_content.write("\n")
        
        # Reset settings
        sql_content.write("SET FOREIGN_KEY_CHECKS = 1;\n")
        
        # Close database connection
        cursor.close()
        conn.close()
        
        # Create email with attachment
        timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        msg = Message(
            subject=f"RippleBids Database Dump - {timestamp}",
            recipients=["devtomiwa9@gmail.com"],
            body=f"Please find attached the database dump generated on {datetime.now()}"
        )
        
        # Attach SQL file
        msg.attach(
            f"database_dump_{timestamp}.sql",
            "text/plain",
            sql_content.getvalue()
        )
        
        # Send email
        mail.send(msg)
        
        return jsonify({
            "message": "Database dump generated and emailed successfully",
            "timestamp": timestamp
        }), 200
        
    except Exception as e:
        print("Error generating database dump:", str(e))
        return jsonify({"error": "Failed to generate database dump"}), 500

# ✅ Register blueprint(s)
app.register_blueprint(auth_bp, url_prefix="/auth")
app.register_blueprint(user_bp, url_prefix="/user")
app.register_blueprint(marketplace_bp, url_prefix="/marketplace")
app.register_blueprint(storefront_bp, url_prefix="/storefront")
app.register_blueprint(storefront_orders_bp, url_prefix="/storefront/orders-list")
app.register_blueprint(storefront_analytics_bp, url_prefix="/storefront/analytics")
app.register_blueprint(storefront_settings_bp, url_prefix="/storefront/me")
app.register_blueprint(admin_auth_bp, url_prefix="/admin/auth")
app.register_blueprint(admin_dashboard_bp, url_prefix="/admin/metrics")
app.register_blueprint(admin_users_bp, url_prefix="/admin/get")
app.register_blueprint(admin_listings_bp, url_prefix="/admin/fetch")
app.register_blueprint(admin_bp, url_prefix="/admin")
app.register_blueprint(audit_bp, url_prefix="/admin/audit")
app.register_blueprint(admin_settings_bp, url_prefix="/admin/settings")
app.register_blueprint(escrows_bp, url_prefix="/escrows")
app.register_blueprint(membership_bp, url_prefix="/membership")
app.register_blueprint(orders_bp, url_prefix="/orders")
app.register_blueprint(storefronts_bp, url_prefix="/storefronts")
app.register_blueprint(storefront_notifications_bp, url_prefix="/notifications")
app.register_blueprint(storefront_followers_bp, url_prefix="/storefront/followers")

if __name__ == "__main__":
    # print(app.url_map)
    app.run(debug=True, host='0.0.0.0', port=1234, use_reloader=True)
