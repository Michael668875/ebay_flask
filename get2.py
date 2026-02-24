import os
import json
import requests
from base64 import b64encode
from dotenv import load_dotenv

load_dotenv()

CLIENT_ID = os.getenv("EBAY_CLIENT_ID")
CLIENT_SECRET = os.getenv("EBAY_CLIENT_SECRET")
CATEGORY_ID = "177"

MARKETPLACES = {
    "US": "EBAY_US",
    "UK": "EBAY_GB",
    "DE": "EBAY_DE",
    "AU": "EBAY_AU"
}

def get_token():
    auth = b64encode(f"{CLIENT_ID}:{CLIENT_SECRET}".encode()).decode()
    url = "https://api.ebay.com/identity/v1/oauth2/token"
    headers = {"Content-Type": "application/x-www-form-urlencoded",
               "Authorization": f"Basic {auth}"}
    data = {"grant_type": "client_credentials",
            "scope": "https://api.ebay.com/oauth/api_scope"}
    resp = requests.post(url, headers=headers, data=data)
    resp.raise_for_status()
    return resp.json()["access_token"]

def fetch_items(token, marketplace_id, limit=5):
    url = "https://api.ebay.com/buy/browse/v1/item_summary/search"
    headers = {
        "Authorization": f"Bearer {token}",
        "X-EBAY-C-MARKETPLACE-ID": marketplace_id
    }
    params = {
        "q": "thinkpad",
        "category_id": CATEGORY_ID,
        "limit": limit,
        "fieldgroups": "EXTENDED"  # try to get localizedAspects if available
    }
    resp = requests.get(url, headers=headers, params=params)
    resp.raise_for_status()
    return resp.json().get("itemSummaries", [])

if __name__ == "__main__":
    token = get_token()
    
    for country, marketplace_id in MARKETPLACES.items():
        print(f"\nFetching items for {country}...")
        items = fetch_items(token, marketplace_id)
        print(f"Fetched {len(items)} items for {country}\n")
        
        # Save to a JSON file for inspection
        filename = f"ebay_{country}_items.json"
        with open(filename, "w", encoding="utf-8") as f:
            json.dump(items, f, indent=4)
        
        # Optional: print the first item for quick look
        if items:
            print(f"First item keys for {country}:", items[0].keys())