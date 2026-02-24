from app import create_app
import requests
from base64 import b64encode
import os
from dotenv import load_dotenv

load_dotenv()

app = create_app()


# Production credentials

CLIENT_ID = os.environ.get("EBAY_CLIENT_ID")
CLIENT_SECRET = os.environ.get("EBAY_CLIENT_SECRET")
CAMPAIGN_ID = os.environ.get("CAMPAIGN_ID")
CATEGORY_ID = "177"
MARKET_PLACES = {
    "US": "EBAY_US",
    "UK": "EBAY_UK",
    "DE": "EBAY_DE",
    "AU": "EBAY_AU",
}

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

def get_thinkpads(token, marketplace_id, limit=100):
    url = "https://api.ebay.com/buy/browse/v1/item_summary/search"
    headers = {
        "Authorization": f"Bearer {token}",
        "X-EBAY-C-MARKETPLACE-ID": marketplace_id,
        "X-EBAY-C-ENDUSERCTX": f"affiliateCampaignId={CAMPAIGN_ID}"
    }
    params = {"q": "thinkpad", "category_id": CATEGORY_ID, "limit": limit, "fieldgroups": "EXTENDED"}
    resp = requests.get(url, headers=headers, params=params)
    resp.raise_for_status()
    return resp.json().get("itemSummaries", [])

def get_markets():
    token = get_token()
    all_items = []

    for country, marketplace_id in MARKET_PLACES.items():
        print(f"Fetching items for {country}...")
        try:
            items = get_thinkpads(token, marketplace_id)

            # Attach country metadata for DB
            for item in items:
                item["marketplace_country"] = country
                item["marketplace_id"] = marketplace_id

            all_items.extend(items)

            print(f"Fetched {len(items)} items for {country}")

        except requests.RequestException as e:
            print(f"Failed fetching {country}: (e)")
    
    print(f"Total items fetched: {len(all_items)}")
    return all_items




