from flask import Blueprint, jsonify, request
from extensions.extensions import get_db_connection

escrows_bp = Blueprint("escrows", __name__)


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

        # Insert corresponding order
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
                created_at
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, NOW())
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
            order_type
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
