import json
import base64
import urllib.parse

unsigned_tx = {
    "account": "rL56jbotdLLpThXctCpB3vZR9kXe5QzVDb",
    "amount": {
        "currency": "5852504200000000000000000000000000000000",
        "issuer": "rsEaYfqdZKNbD3SK55xzcjPm3nDrMj4aUT",
        "value": "50"
    },
    "destination": "rpeh58KQ7cs76Aa2639LYT2hpw4D6yrSDq",
    "fee": "10",
    "last_ledger_sequence": 10049206,
    "sequence": 10036548,
    "signing_pub_key": "",
    "transaction_type": "Payment"
}

# Encode JSON payload
json_str = json.dumps(unsigned_tx)
b64_payload = base64.urlsafe_b64encode(json_str.encode()).decode()

# Deep link
callback_url = urllib.parse.quote("myapp://xaman_callback")  # where XAMAN returns signed tx
deep_link = f"xaman://sign?data={b64_payload}"

print(deep_link)
