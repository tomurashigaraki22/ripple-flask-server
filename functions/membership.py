from flask import Blueprint, request, jsonify
import jwt
import os
import pymysql
from extensions.extensions import get_db_connection
import json

membership_bp = Blueprint("membership", __name__, url_prefix="/membership")


# Function to verify user access (not a decorator)
def verify_user_access(req):
    print("TRYYY")
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

    user_id = decoded.get("userId")
    if not user_id:
        return {"error": "Invalid token payload", "status": 401}

    # Fetch user from database using DictCursor
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        cursor.execute(
            "SELECT id, email, username FROM users WHERE id = %s",
            (user_id,)
        )
        user = cursor.fetchone()
        conn.close()

        if not user:
            return {"error": "User not found", "status": 404}

        return {"user": user}  # already a dict

    except Exception as e:
        print("DB error in verify_user_access:", e)
        return {"error": "Internal server error", "status": 500}


@membership_bp.route("/info", methods=["GET"])
def get_current_membership():
    try:
        auth_result = verify_user_access(request)
        print(f"Auth Result: {auth_result}")
        if "error" in auth_result:
            return jsonify({"error": auth_result["error"]}), auth_result["status"]

        user_id = auth_result["user"]["id"]

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        cursor.execute(
            """
            SELECT 
                u.id as user_id,
                u.username,
                u.email,
                mt.id as tier_id,
                mt.name as tier_name,
                mt.price as tier_price,
                mt.features as tier_features,
                um.id as membership_id,
                um.expires_at,
                um.is_active,
                um.created_at as membership_start_date
            FROM users u
            JOIN membership_tiers mt ON u.membership_tier_id = mt.id
            LEFT JOIN user_memberships um ON u.id = um.user_id AND um.is_active = TRUE
            WHERE u.id = %s
            """,
            (user_id,)
        )

        membership_data = cursor.fetchone()
        cursor.close()
        conn.close()

        if not membership_data:
            return jsonify({"error": "User membership not found"}), 404

        # Parse tier features if stored as JSON string
        features = membership_data.get("tier_features")
        if isinstance(features, str):
            try:
                features = json.loads(features)
            except:
                features = {}

        response = {
            "currentMembership": {
                "user": {
                    "id": membership_data["user_id"],
                    "username": membership_data["username"],
                    "email": membership_data["email"]
                },
                "tier": {
                    "id": membership_data["tier_id"],
                    "name": membership_data["tier_name"],
                    "price": float(membership_data["tier_price"]) if membership_data["tier_price"] else 0,
                    "features": features
                },
                "membership": {
                    "id": membership_data["membership_id"],
                    "isActive": membership_data["is_active"],
                    "expiresAt": membership_data["expires_at"],
                    "startDate": membership_data["membership_start_date"]
                }
            }
        }

        return jsonify(response)

    except Exception as e:
        print("Error fetching current membership:", e)
        return jsonify({"error": "Internal server error"}), 500

# app/routes/membership.py
from flask import Blueprint, request, jsonify
from extensions.extensions import get_db_connection
from uuid import uuid4
from datetime import datetime, timedelta
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import os
from functions.admin import generate_random_password  # You can create a helper for password generation

membership_bp = Blueprint('membership', __name__)

SMTP_HOST = 'smtp.gmail.com'
SMTP_PORT = 587
SMTP_USER = 'noreply.dropapp@gmail.com'
SMTP_PASSWORD = os.getenv("SMTP_PASSWORD")
SMTP_FROM = 'Ripplebids'
BASE_URL = 'https://ripplebids.com'


def send_storefront_email(email, credentials):
    msg = MIMEMultipart('alternative')
    msg['Subject'] = "Your Ripple Marketplace Storefront Access"
    msg['From'] = SMTP_FROM
    msg['To'] = email

    html = f"""
    <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
        <h2 style="color: #39FF14;">Welcome to Ripple Marketplace Storefront!</h2>
        <p>Congratulations on your membership upgrade! You now have access to the storefront dashboard.</p>
        
        <div style="background: #f5f5f5; padding: 20px; border-radius: 8px; margin: 20px 0;">
          <h3>Your Storefront Login Credentials:</h3>
          <p><strong>Email:</strong> {credentials['email']}</p>
          <p><strong>Password:</strong> {credentials['password']}</p>
          <p><strong>Access URL:</strong> {BASE_URL}/storefront</p>
          <p><strong>Expires:</strong> {credentials['expires_at'].strftime('%Y-%m-%d')}</p>
        </div>
        
        <p style="color: #666;">Please keep these credentials secure and change your password after first login.</p>
        <p style="color: #666;">If you have any questions, please contact our support team.</p>
    </div>
    """
    msg.attach(MIMEText(html, 'html'))

    try:
        with smtplib.SMTP(SMTP_HOST, SMTP_PORT) as server:
            server.starttls()
            server.login(SMTP_USER, SMTP_PASSWORD)
            server.sendmail(SMTP_FROM, email, msg.as_string())
    except Exception as e:
        print("Failed to send email:", e)


@membership_bp.route('/verify-payment', methods=['POST'])
def verify_payment():
    try:
        auth_result = verify_user_access(request)
        if auth_result.get('error'):
            return jsonify({'error': auth_result['error']}), auth_result.get('status', 401)

        data = request.json
        tier_name = data.get('tierName')
        transaction_hash = data.get('transactionHash')
        payment_method = data.get('paymentMethod')
        amount = data.get('amount')
        currency = data.get('currency')
        payment_url = data.get('paymentUrl')
        verified = data.get('verified', False)
        xumm_uuid = data.get('xummUuid')

        if not tier_name or not transaction_hash or not payment_method:
            return jsonify({'error': 'Tier name, transaction hash, and payment method are required'}), 400

        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)

        # Get membership tier
        cursor.execute("SELECT * FROM membership_tiers WHERE LOWER(name) = %s", (tier_name.lower(),))
        tier = cursor.fetchone()
        if not tier:
            return jsonify({'error': 'Invalid membership tier'}), 400

        # Check existing active membership
        cursor.execute(
            "SELECT * FROM user_memberships WHERE user_id = %s AND is_active = TRUE",
            (auth_result['user']['id'],)
        )
        existing_membership = cursor.fetchone()

        is_first_time_member = existing_membership is None

        if existing_membership:
            current_expiry = existing_membership['expires_at']
            now = datetime.utcnow()
            base_date = current_expiry if current_expiry > now else now
            expires_at = base_date + timedelta(days=30)
        else:
            expires_at = None if tier_name.lower() == 'basic' else datetime.utcnow() + timedelta(days=30)

        try:
            conn.begin()

            if existing_membership:
                cursor.execute(
                    "UPDATE user_memberships SET expires_at = %s, membership_tier_id = %s WHERE user_id = %s AND is_active = TRUE",
                    (expires_at, tier['id'], auth_result['user']['id'])
                )
            else:
                cursor.execute(
                    "UPDATE user_memberships SET is_active = FALSE WHERE user_id = %s",
                    (auth_result['user']['id'],)
                )
                membership_id = str(uuid4())
                cursor.execute(
                    "INSERT INTO user_memberships (id, user_id, membership_tier_id, price, transaction_hash, expires_at, is_active) "
                    "VALUES (%s, %s, %s, %s, %s, %s, TRUE)",
                    (membership_id, auth_result['user']['id'], tier['id'], amount or tier['price'], transaction_hash, expires_at)
                )

            # Update user's current membership tier
            cursor.execute(
                "UPDATE users SET membership_tier_id = %s WHERE id = %s",
                (tier['id'], auth_result['user']['id'])
            )

            storefront_credentials = None
            email_sent = False

            if tier_name.lower() != 'basic':
                cursor.execute("SELECT email FROM users WHERE id = %s", (auth_result['user']['id'],))
                user = cursor.fetchone()
                user_email = user['email'] if user else None

                cursor.execute("SELECT * FROM storefront_logins WHERE user_id = %s", (auth_result['user']['id'],))
                existing_storefront = cursor.fetchone()

                if not existing_storefront:
                    generated_password = generate_random_password(16)
                    storefront_id = str(uuid4())
                    cursor.execute(
                        "INSERT INTO storefront_logins (id, user_id, email, generated_password, expires_at, expired) "
                        "VALUES (%s, %s, %s, %s, %s, FALSE)",
                        (storefront_id, auth_result['user']['id'], user_email, generated_password, expires_at)
                    )
                    storefront_credentials = {
                        'email': user_email,
                        'password': generated_password,
                        'expires_at': expires_at
                    }
                    if is_first_time_member:
                        send_storefront_email(user_email, storefront_credentials)
                        email_sent = True
                else:
                    cursor.execute(
                        "UPDATE storefront_logins SET expires_at = %s, expired = FALSE WHERE user_id = %s",
                        (expires_at, auth_result['user']['id'])
                    )
                    storefront_credentials = {
                        'email': existing_storefront['email'],
                        'password': existing_storefront['generated_password'],
                        'expires_at': expires_at
                    }

            conn.commit()

            return jsonify({
                'success': True,
                'message': 'Membership extended' if existing_membership else 'Payment verified and membership activated',
                'membership': {
                    'tier': tier['name'],
                    'expiresAt': expires_at,
                    'isExtension': existing_membership is not None
                },
                'storefrontCredentials': storefront_credentials,
                'emailSent': email_sent,
                'isFirstTimeMember': is_first_time_member,
                'paymentDetails': {
                    'transactionHash': transaction_hash,
                    'paymentMethod': payment_method,
                    'amount': amount,
                    'currency': currency,
                    'paymentUrl': payment_url,
                    'verified': verified,
                    'xummUuid': xumm_uuid
                }
            }), 201

        except Exception as e:
            conn.rollback()
            print("Transaction failed:", e)
            return jsonify({'error': 'Internal server error'}), 500

    except Exception as e:
        print("Error verifying payment:", e)
        return jsonify({'error': 'Internal server error'}), 500

    finally:
        cursor.close()
        conn.close()
