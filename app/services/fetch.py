from app import create_app, db
import requests
from base64 import b64encode
import os
from dotenv import load_dotenv
from sqlalchemy import text



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
def get_thinkpads(limit=10):  
    token = get_token()
    all_items = []

    #marketplaces = Marketplace.query.filter_by(enabled=True).all()
    marketplaces = ["EBAY_US", "EBAY_GB", "EBAY_DE", "EBAY_AU"]

    for market in marketplaces:
        try:
            url = "https://api.ebay.com/buy/browse/v1/item_summary/search"
            headers = {
                "Authorization": f"Bearer {token}",
                "X-EBAY-C-MARKETPLACE-ID": market,
                "X-EBAY-C-ENDUSERCTX": f"affiliateCampaignId={CAMPAIGN_ID}"
            }
            params = {"q": "thinkpad", "category_id": CATEGORY_ID, "limit": limit, "fieldgroups": "EXTENDED"}
            resp = requests.get(url, headers=headers, params=params)
            resp.raise_for_status()

            items = resp.json().get("itemSummaries", [])

            for item in items:
                item["marketplace_country"] = market.split("_", 1)[1]
                item["marketplace_id"] = market

            all_items.extend(items)    
        
        except requests.RequestException as e:
                print(f"Failed fetching {market}: {e}")

    #with open("get_thinkpads_log.txt", "w", encoding="utf-8") as f:
    #    json.dump(all_items, f, indent=2, ensure_ascii=False)
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
    
    #with open("get_details_log.txt", "w", encoding="utf-8") as f:
    #    json.dump(detailed_items, f, indent=2, ensure_ascii=False)

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




# THIS WILL REPLACE THE ABOVE

import requests
import time
from base64 import b64encode
from app import create_app
from dotenv import load_dotenv
import os
import random


load_dotenv()
app = create_app()

CLIENT_ID = os.environ.get("EBAY_CLIENT_ID")
CLIENT_SECRET = os.environ.get("EBAY_CLIENT_SECRET")
CAMPAIGN_ID = os.environ.get("CAMPAIGN_ID")
CATEGORY_ID = "177"


def get_token():
    """Get OAuth token from eBay."""
    auth = b64encode(f"{CLIENT_ID}:{CLIENT_SECRET}".encode()).decode()
    url = "https://api.ebay.com/identity/v1/oauth2/token"
    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": f"Basic {auth}"
    }
    data = {
        "grant_type": "client_credentials",
        "scope": "https://api.ebay.com/oauth/api_scope"
    }
    resp = requests.post(url, headers=headers, data=data)
    resp.raise_for_status()
    return resp.json()["access_token"]


#def get_paginated_summaries(query="thinkpad", limit=200, maximum_items=2000):
#    """Fetch all item summaries with pagination across marketplaces."""
#    token = get_token()
#    marketplaces = ["EBAY_US", "EBAY_GB", "EBAY_DE", "EBAY_AU"]
#    all_items = []
#
#    for market in marketplaces:
#        offset = 0
#        while len(all_items) < maximum_items:
#            url = "https://api.ebay.com/buy/browse/v1/item_summary/search"
#            headers = {
#                "Authorization": f"Bearer {token}",
#                "X-EBAY-C-MARKETPLACE-ID": market,
#                "X-EBAY-C-ENDUSERCTX": f"affiliateCampaignId={CAMPAIGN_ID}"
#            }
#            params = {
#                "q": query,
#                "category_id": CATEGORY_ID,
#                "limit": limit,
#                "offset": offset,
#                "fieldgroups": "EXTENDED"
#            }
#
#            try:
#                resp = requests.get(url, headers=headers, params=params)
#                resp.raise_for_status()
#                items = resp.json().get("itemSummaries", [])
#
#                if not items:
#                    break
#
#                for item in items:
#                    item["marketplace_id"] = market
#                    item["marketplace_country"] = market.split("_", 1)[1]
#
#                all_items.extend(items)
#                offset += limit
#
#                # small sleep between pages
#                time.sleep(0.2)
#
#            except requests.RequestException as e:
#                print(f"Failed fetching {market} page {offset // limit + 1}: {e}")
#                break
#
#    return all_items


def get_paginated_summaries(query="thinkpad", limit=200, maximum_items=600):
    """Fetch item summaries with pagination across marketplaces."""

    token = get_token()
    marketplaces = ["EBAY_US", "EBAY_GB", "EBAY_DE", "EBAY_AU"]
    all_items = []

    for market in marketplaces:

        offset = 0
        market_items = []

        while len(market_items) < maximum_items:

            url = "https://api.ebay.com/buy/browse/v1/item_summary/search"

            headers = {
                "Authorization": f"Bearer {token}",
                "X-EBAY-C-MARKETPLACE-ID": market,
                "X-EBAY-C-ENDUSERCTX": f"affiliateCampaignId={CAMPAIGN_ID}"
            }

            params = {
                "q": query,
                "category_ids": CATEGORY_ID,
                "limit": limit,
                "offset": offset,
                "fieldgroups": "EXTENDED",
                "sort": "newlyListed",
                "filter": "conditionIds:{1000|1500|2000|2500|3000},buyingOptions:{FIXED_PRICE}"
            }

            try:
                print(f"{market}: page {offset // limit + 1}")
                resp = requests.get(url, headers=headers, params=params)
                resp.raise_for_status()

                items = resp.json().get("itemSummaries", [])

                if not items:
                    break

                for item in items:
                    item["marketplace_id"] = market
                    item["marketplace_country"] = market.split("_", 1)[1]

                    remaining = maximum_items - len(market_items)
                    market_items.extend(items[:remaining])

                offset += limit

                # stop if last page
                if len(items) < limit:
                    break

                time.sleep(0.2)

            except requests.RequestException as e:
                print(f"Failed fetching {market} page {offset // limit + 1}: {e}")
                break

        print(f"{market}: fetched {len(market_items)} items")

        all_items.extend(market_items)

    unique = {item["itemId"]: item for item in all_items}
    return list(unique.values())


def get_item_details(item_id, marketplace_id, token):
    """Fetch detailed info for a single item."""
    url = f"https://api.ebay.com/buy/browse/v1/item/{item_id}"
    headers = {
        "Authorization": f"Bearer {token}",
        "X-EBAY-C-MARKETPLACE-ID": marketplace_id,
        "X-EBAY-C-ENDUSERCTX": f"affiliateCampaignId={CAMPAIGN_ID}"
    }

    resp = requests.get(url, headers=headers)
    resp.raise_for_status()
    return resp.json()

# check temp_summaries against listings to fetch only items not already there
def new_listings():
        return db.session.execute(text("""
        SELECT ts.*
        FROM temp_summaries ts
        LEFT JOIN listings l
            ON l.ebay_item_id = ts.ebay_item_id
        WHERE l.id IS NULL
    """)).mappings().all()


def fetch_item_details(listings, token=None, max_retries=5):
    """Fetch details only for listings that need them, with retries/backoff."""
    
    if token is None:
        token = get_token()

    detailed_items = []

    for i, listing in enumerate(listings, start=1):

        item_id = listing["ebay_item_id"]
        marketplace_id = listing["marketplace"]

        attempt = 0
        while attempt < max_retries:
            try:
                details = get_item_details(item_id, marketplace_id, token)
                detailed_items.append(details)

                # small pause to avoid throttling
                #time.sleep(0.2)
                if i % 20 == 0:
                    time.sleep(1)
                break  # success, break retry loop

            except requests.RequestException as e:
                attempt += 1
                status = getattr(e.response, "status_code", None)
                
                # add a back off function when hitting rate limit
                # only retry on 429 (rate limit) or 5xx errors
                if status in [429] or (status and 500 <= status < 600):
                    wait_time = 2 ** attempt + random.random()
                    print(f"Attempt {attempt} failed for {item_id} (status {status}). Retrying in {wait_time:.1f}s...")
                    time.sleep(wait_time)
                else:
                    print(f"Failed fetching details for {item_id}: {e}")
                    break  # don't retry on other errors

    return detailed_items

#def extract_localized_aspects(detailed_items, summary_items):
#    """Combine localized aspects with marketplace info from summaries."""
#    summary_lookup = {item["itemId"]: item for item in summary_items}
#    extracted = []
#
#    for item in detailed_items:
#        item_id = item.get("itemId")
#        localized_aspects = item.get("localizedAspects", [])
#        summary_item = summary_lookup.get(item_id, {})
#
#        extracted.append({
#            "itemId": item_id,
#            "marketplace_id": summary_item.get("marketplace_id"),
#            "localizedAspects": localized_aspects
#        })
#
#    return extracted


if __name__ == "__main__":
    print("Fetching all ThinkPad summaries...")
    summaries = get_paginated_summaries()
    print(f"Total summaries fetched: {len(summaries)}")

    # insert into temp summaries
    # testing_db - save_temp_summaries(summaries)

    # find summaries not in listings table
    listings = new_listings()

    print("Fetching item details for new listings...")
    details = fetch_item_details(listings) # fetch only new thinkpads
    print(f"Total detailed items fetched: {len(details)}")

    # insert details into temp details
    #testing_db - save_temp_details(details)

    

    # move data to permanent tables
    # pipeline




import asyncio
import httpx
import random


async def fetch_one(client, listing, token, sem):

    item_id = listing["ebay_item_id"]
    marketplace = listing["marketplace"]

    url = f"https://api.ebay.com/buy/browse/v1/item/{item_id}"

    headers = {
        "Authorization": f"Bearer {token}",
        "X-EBAY-C-MARKETPLACE-ID": marketplace,
        "X-EBAY-C-ENDUSERCTX": f"affiliateCampaignId={CAMPAIGN_ID}"

    }

    async with sem:

        for attempt in range(5):

            try:
                r = await client.get(url, headers=headers, timeout=30)
                r.raise_for_status()
                return r.json()

            except httpx.HTTPStatusError as e:

                status = e.response.status_code

                if status == 429 or 500 <= status < 600:

                    wait = 2 ** attempt + random.random()
                    print(f"{item_id} retry {attempt} in {wait:.1f}s")

                    await asyncio.sleep(wait)

                else:
                    print(f"{item_id} failed: {status}")
                    return None

        return None
    

async def fetch_item_details_async(listings):

    token = get_token()

    sem = asyncio.Semaphore(8)  # concurrency limit

    async with httpx.AsyncClient() as client:

        tasks = [
            fetch_one(client, listing, token, sem)
            for listing in listings
        ]

        results = await asyncio.gather(*tasks)

    return [r for r in results if r]


"""
# how to call it
listings = new_listings()

details = asyncio.run(fetch_item_details_async(listings))
"""

"""

Instead of lowering maximum_items, add a cap on detail fetches per run.

Example:

MAX_DETAIL_CALLS = 300

new_listings = new_listings_query()[:MAX_DETAIL_CALLS]

This guarantees you never exceed your budget.

Example daily usage:

300 calls/run
6 runs/day
= 1800 calls/day

Safe.
"""