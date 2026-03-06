# THIS IS A TEST FILE TO GRAB A SOLD LISTING AND SEE WHAT THE ENTRY SAYS
# USE ItemEndDate to record ended listings. Use estimatedSoldQuantity to determine if item sold or ended without sale.

import requests
import json
import requests
from base64 import b64encode
import os
from dotenv import load_dotenv
from pathlib import Path

RESP_FILE = Path(__file__).parent / "response.jsonl"

load_dotenv()


CLIENT_ID = os.environ.get("EBAY_CLIENT_ID")
CLIENT_SECRET = os.environ.get("EBAY_CLIENT_SECRET")
CAMPAIGN_ID = os.environ.get("CAMPAIGN_ID")
CATEGORY_ID = "177"

def get_token():
    auth = b64encode(f"{CLIENT_ID}:{CLIENT_SECRET}".encode()).decode()
    token_url = "https://api.ebay.com/identity/v1/oauth2/token"
    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": f"Basic {auth}"
    }
    data = {
        "grant_type": "client_credentials",
        "scope": "https://api.ebay.com/oauth/api_scope"
    }
    resp = requests.post(token_url, headers=headers, data=data)
    resp.raise_for_status()
    return resp.json()["access_token"]




# ----------------------------
# CONFIG: Put your values here
# ----------------------------
EBAY_API_TOKEN = get_token() # eBay OAuth token with Browse API access
ITEM_ID = "v1|227233479427|0"                 # Replace with a known item ID

# ----------------------------
# Fetch single item from eBay
# ----------------------------
def fetch_item(item_id):
    url = f"https://api.ebay.com/buy/browse/v1/item/{item_id}"

    headers = {
        "Authorization": f"Bearer {EBAY_API_TOKEN}",
        "Content-Type": "application/json"
    }

    response = requests.get(url, headers=headers)

    if response.status_code == 200:
        data = response.json()
        return data
    else:
        print(f"Error fetching item: {response.status_code} - {response.text}")
        return None

# ----------------------------
# Main
# ----------------------------
if __name__ == "__main__":
    item_data = fetch_item(ITEM_ID)
    if item_data:
        # Pretty print the JSON response
        with RESP_FILE.open("a", encoding="utf-8") as f:
                f.write(json.dumps(item_data, indent=2))