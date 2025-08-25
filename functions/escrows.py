from flask import Blueprint, jsonify, request
from xrpl.models.transactions import Payment
from extensions.extensions import ESCROW_ADDRESS, ISSUER_ADDRESS, client
from xrpl.transaction import autofill
from extensions.extensions import get_db_connection
from xrpl.models.amounts import IssuedCurrencyAmount


escrows_bp = Blueprint("escrows", __name__)

@escrows_bp.route("/escrows", methods=["GET"])
def get_escrows():
    try:
        return jsonify({"message": "Hello, World!"})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

@escrows_bp.route("/create", methods=["POST"])
def create_escrow():
    """
    Prepare an unsigned Payment transaction payload for XAMAN wallet
    and store escrow info in the database.
    Expected JSON body:
    {
        "buyer_address": "rXXXX",
        "amount": "100",
        "chain": "XRPL"
    }
    """
    try:
        data = request.get_json()
        buyer_address = data.get("buyer_address")
        amount = data.get("amount")
        chain = data.get("chain", "XRPL")  # default to XRPL

        if not buyer_address or not amount:
            return jsonify({"error": "Buyer address and amount are required"}), 400

        # Build unsigned Payment transaction
        tx = Payment(
            account=buyer_address,
            destination=ESCROW_ADDRESS,
            amount=IssuedCurrencyAmount(
                currency="5852504200000000000000000000000000000000",
                issuer=ISSUER_ADDRESS,
                value=str(amount)
            )
        )

        # Autofill fee and sequence (unsigned)
        tx_autofilled = autofill(tx, client)

        # Store escrow info in DB
        # Store escrow info in DB
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute("""
            INSERT INTO escrow_accounts (
                escrow_address,
                destination_address,
                chain,
                amount,
                currency,
                transaction_hash,
                status
            ) VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (
            ESCROW_ADDRESS,
            buyer_address,
            chain,
            amount,
            "XRPB",        # <-- Add currency here
            None,          # transaction_hash unknown until signed
            "PENDING"      # initial status
        ))
        conn.commit()
        cursor.close()
        conn.close()


        return jsonify(tx_autofilled.to_dict()), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

@escrows_bp.route("/get", methods=["GET"])
def get_escrow_details():
    """
    Get details of an escrow
    Expected query params:
    {
        "escrow_address": "rXXXX",
        "transaction_hash": "TX_HASH"
    }
    """
    try:
        data = request.get_json()
        escrow_address = data.get("escrow_address")
        transaction_hash = data.get("transaction_hash")

        if not escrow_address or not transaction_hash:
            return jsonify({"error": "Escrow address and transaction hash are required"}), 400

        # Get escrow details from the database
        conn = get_db_connection()
        cursor = conn.cursor()
        cursor.execute(
            "SELECT * FROM escrow_accounts WHERE escrow_address = %s AND transaction_hash = %s",
            (escrow_address, transaction_hash)
        )
        escrow = cursor.fetchone()
        cursor.close()
        conn.close()

        if not escrow:
            return jsonify({"error": "Escrow not found"}), 404

        return jsonify(escrow), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500
