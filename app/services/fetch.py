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

# get item summaries
def get_thinkpads(limit=3):  
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

# get item specifics from more detailed api
def get_item_details(item_id, marketplace_id, token):
    url = f"https://api.ebay.com/buy/browse/v1/item/{item_id}"

    headers = {
        "Authorization": f"Bearer {token}",
        "X-EBAY-C-MARKETPLACE-ID": marketplace_id,
        "X-EBAY-C-ENDUSERCTX": f"affiliateCampaignId={CAMPAIGN_ID}"
    }

    resp = requests.get(url, headers=headers)
    resp.raise_for_status()
    return resp.json()

# fetch item specifics in lots of 20 to avoid rate limit
def fetch_items_in_batches(items, batch_size=20):
    token = get_token()
    detailed_items = []

    for i in range(0, len(items), batch_size):
        batch = items[i:i + batch_size]

        print(f"Fetching batch {i // batch_size + 1}")

        for item in batch:
            try:
                item_id = item["itemId"]
                marketplace_id = item["marketplace_id"]

                details = get_item_details(item_id, marketplace_id, token)

                detailed_items.append(details)

            except requests.RequestException as e:
                print(f"Failed fetching {item_id}: {e}")

    return detailed_items


# make a function to extract localizedaspects and save to db

# try something like this:

def extract_localized_aspects(detailed_items, summary_items):
    """
    Returns a list of dicts with:
      - itemId
      - marketplace_id
      - localizedAspects
    detailed_items: full item responses
    summary_items: original item summaries (to get marketplace_id)
    """
    # Build lookup from summary items
    summary_lookup = {item["itemId"]: item for item in summary_items}

    extracted = []
    for item in detailed_items:
        item_id = item.get("itemId")
        localized_aspects = item.get("localizedAspects", [])

        summary_item = summary_lookup.get(item_id, {})
        marketplace_id = summary_item.get("marketplace_id")

        extracted.append({
            "itemId": item_id,
            "marketplace_id": marketplace_id,
            "localizedAspects": localized_aspects
        })

    return extracted

# add a back off function when hitting rate limit