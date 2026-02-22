import os
import json
import time
import re
import requests
from base64 import b64encode
from dotenv import load_dotenv

load_dotenv()

CLIENT_ID = os.environ.get("EBAY_CLIENT_ID")
CLIENT_SECRET = os.environ.get("EBAY_CLIENT_SECRET")

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

# === CONFIGURE THIS ===
EBAY_TOKEN = get_token()
CATEGORY_ID = "177"  # Category to fetch (laptops)
PER_PAGE = 10  # Number of listings per request
OUT_DIR = "ebay_specifics_dump"

# Create output folder
os.makedirs(OUT_DIR, exist_ok=True)

HEADERS = {
    "Authorization": f"Bearer {EBAY_TOKEN}",
    "Content-Type": "application/json",
    "Accept": "application/json",
}

# --- Helper functions ---

def sanitize_filename(s):
    """Replace invalid Windows filename characters with underscores."""
    return re.sub(r'[^a-zA-Z0-9_-]', '_', s)

def save_listing(listing):
    item_id = listing.get("itemId")
    safe_id = sanitize_filename(item_id)
    filepath = os.path.join(OUT_DIR, f"{safe_id}.json")
    with open(filepath, "w", encoding="utf-8") as f:
        json.dump(listing, f, indent=4)

def fetch_category_listings(category_id, limit=PER_PAGE):
    """Fetch listings from eBay Browse API by category."""
    url = (
        "https://api.ebay.com/buy/browse/v1/item_summary/search"
        f"?category_ids={category_id}&limit={limit}"
    )
    resp = requests.get(url, headers=HEADERS)
    if resp.status_code != 200:
        print("ERROR fetching category listings:", resp.status_code, resp.text)
        return []

    return resp.json().get("itemSummaries", [])

def fetch_full_item(item_id):
    """Fetch full item details including itemSpecifics."""
    url = f"https://api.ebay.com/buy/browse/v1/item/{item_id}"
    resp = requests.get(url, headers=HEADERS)
    if resp.status_code != 200:
        print("ERROR fetching item", item_id, resp.status_code, resp.text)
        return None
    return resp.json()

# --- Main ---

def main():
    listings = fetch_category_listings(CATEGORY_ID)

    print(f"Found {len(listings)} listings in category {CATEGORY_ID}")

    for item in listings:
        item_id = item.get("itemId")
        print("Fetching full item:", item_id)

        full = fetch_full_item(item_id)
        if full:
            save_listing(full)

        # Avoid hitting rate limits
        time.sleep(0.2)

if __name__ == "__main__":
    main()