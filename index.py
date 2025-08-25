from extensions.extensions import app
from flask import jsonify, request
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
# from functions.escrows import escrows_bp
from functions.membership import membership_bp

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
# app.register_blueprint(escrows_bp, url_prefix="/escrows")
app.register_blueprint(membership_bp, url_prefix="/membership")

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=1234, use_reloader=True)
