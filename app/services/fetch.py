from app import create_app
import requests
from base64 import b64encode
import os
from dotenv import load_dotenv
from app.models import Marketplace

load_dotenv()

app = create_app()


# Production credentials

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

def get_thinkpads(limit=10):  
    token = get_token()
    all_items = []

    marketplaces = Marketplace.query.filter_by(enabled=True).all()

    for market in marketplaces:
        try:
            url = "https://api.ebay.com/buy/browse/v1/item_summary/search"
            headers = {
                "Authorization": f"Bearer {token}",
                "X-EBAY-C-MARKETPLACE-ID": market.marketplace_id,
                "X-EBAY-C-ENDUSERCTX": f"affiliateCampaignId={CAMPAIGN_ID}"
            }
            params = {"q": "thinkpad", "category_id": CATEGORY_ID, "limit": limit, "fieldgroups": "EXTENDED"}
            resp = requests.get(url, headers=headers, params=params)
            resp.raise_for_status()

            items = resp.json().get("itemSummaries", [])

            for item in items:
                item["marketplace_country"] = market.country_code
                item["marketplace_id"] = market.marketplace_id

            all_items.extend(items)    
        
        except requests.RequestException as e:
                print(f"Failed fetching {market.marketplace_id}: {e}")

    return all_items

