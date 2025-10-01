from flask import Blueprint, jsonify, request
from extensions.extensions import get_db_connection
import pymysql

escrows_bp = Blueprint("escrows", __name__)


def ensure_carrier_id_column():
    """
    Automatically add carrier_id column to orders table if it doesn't exist.
    Column specifications:
    - Type: VARCHAR(255) (string)
    - NOT NULL
    - Default: 'se-3051222'
    """
    try:
        conn = get_db_connection()
        cursor = conn.cursor(pymysql.cursors.DictCursor)
        
        # Check if carrier_id column exists
        cursor.execute("""
            SELECT COUNT(*) as column_count
            FROM INFORMATION_SCHEMA.COLUMNS 
            WHERE TABLE_SCHEMA = DATABASE() 
            AND TABLE_NAME = 'orders' 
            AND COLUMN_NAME = 'carrier_id'
        """)
        
        result = cursor.fetchone()
        carrier_id_exists = result['column_count'] if result else 0
        
        if carrier_id_exists == 0:
            # Add the carrier_id column
            cursor.execute("""
                ALTER TABLE orders 
                ADD COLUMN carrier_id VARCHAR(255) NOT NULL DEFAULT 'se-3051222'
            """)
            conn.commit()
            print("Added carrier_id column to orders table")
        else:
            print("carrier_id column already exists in orders table")
            
        cursor.close()
        conn.close()
        
    except Exception as e:
        print(f"Error ensuring carrier_id column: {str(e)}")
        # Try alternative approach - check if column exists by trying to select it
        try:
            conn = get_db_connection()
            cursor = conn.cursor()
            cursor.execute("SELECT carrier_id FROM orders LIMIT 1")
            cursor.close()
            conn.close()
            print("carrier_id column already exists (verified by select)")
        except:
            # Column doesn't exist, try to add it
            try:
                conn = get_db_connection()
                cursor = conn.cursor()
                cursor.execute("""
                    ALTER TABLE orders 
                    ADD COLUMN carrier_id VARCHAR(255) NOT NULL DEFAULT 'se-3051222'
                """)
                conn.commit()
                cursor.close()
                conn.close()
                print("Added carrier_id column to orders table (alternative method)")
            except Exception as alt_error:
                print(f"Failed to add carrier_id column: {str(alt_error)}")


# Call the function automatically when the module is imported
ensure_carrier_id_column()


@escrows_bp.route("/create", methods=["POST"])
def create_escrow():
    """
    Endpoint to create an escrow record and corresponding order.
    Expects JSON body:
    {
        "seller": "seller_wallet_address",
        "buyer": "buyer_wallet_address",
        "amount": 123.45,
        "chain": "xrpl" | "xrpl_evm" | "solana",
        "conditions": {
            "delivery_required": true,
            "satisfactory_condition": true,
            "auto_release_days": 20
        },
        "listingId": 123,
        "transactionHash": "abc123",
        "paymentVerified": true,
        "buyerId": 1,                # optional, for orders table
        "orderType": "purchase",     # optional
        "shippingInfo": {...}        # optional
        "carrierId": "se-3051222"    # optional, defaults to "se-3051222"
    }
    """
    try:
        data = request.get_json()

        # Required fields
        seller = data.get("seller")
        buyer = data.get("buyer")
        amount = data.get("amount")
        chain = data.get("chain")
        conditions = data.get("conditions", {})
        listing_id = data.get("listingId")
        tx_hash = data.get("transactionHash")
        payment_verified = data.get("paymentVerified", False)
        buyer_id = data.get("buyerId")
        order_type = data.get("orderType", "purchase")
        shipping_info = data.get("shippingInfo")
        carrier_id = data.get("carrierId", "se-3051222")  # Default to "se-3051222"

        if not seller or not buyer or not amount or not chain or not listing_id or not tx_hash:
            return jsonify({"success": False, "error": "Missing required fields"}), 400

        conn = get_db_connection()
        cursor = conn.cursor()

        # Insert escrow
        cursor.execute("""
            INSERT INTO escrow_accounts (
                seller_address,
                buyer_address,
                amount,
                chain,
                delivery_required,
                satisfactory_condition,
                auto_release_days,
                listing_id,
                transaction_hash,
                payment_verified,
                status
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (
            seller,
            buyer,
            amount,
            chain,
            conditions.get("delivery_required", True),
            conditions.get("satisfactory_condition", True),
            conditions.get("auto_release_days", 20),
            listing_id,
            tx_hash,
            payment_verified,
            "PENDING"
        ))
        escrow_id = cursor.lastrowid

        # Insert corresponding order with carrier_id
        cursor.execute("""
            INSERT INTO orders (
                listing_id,
                buyer_id,
                seller_id,
                amount,
                transaction_hash,
                status,
                shipping_address,
                escrow_id,
                payment_chain,
                order_type,
                carrier_id,
                created_at
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, NOW())
        """, (
            listing_id,
            buyer_id,
            None,  # seller_id can be fetched if you track users separately
            amount,
            tx_hash,
            "escrow_funded" if payment_verified else "pending",
            shipping_info if shipping_info else None,
            escrow_id,
            chain,
            order_type,
            carrier_id
        ))
        order_id = cursor.lastrowid

        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({
            "success": True,
            "escrowId": escrow_id,
            "orderId": order_id
        }), 200

    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 500

# ----------------------------
# Get all escrows
# ----------------------------
@escrows_bp.route("/api/escrows", methods=["GET"])
def get_all_escrows():
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM escrow_accounts ORDER BY id DESC")
        escrows = cursor.fetchall()
        cursor.close()
        conn.close()

        return jsonify({"success": True, "escrows": escrows}), 200
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 500


# ----------------------------
# Get escrow details
# ----------------------------
@escrows_bp.route("/api/escrow/<int:escrow_id>", methods=["GET"])
def get_escrow_details(escrow_id):
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM escrow_accounts WHERE id = %s", (escrow_id,))
        escrow = cursor.fetchone()
        cursor.close()
        conn.close()

        if not escrow:
            return jsonify({"success": False, "error": "Escrow not found"}), 404

        return jsonify({"success": True, "escrow": escrow}), 200
    except Exception as e:
        return jsonify({"success": False, "error": str(e)}), 500
