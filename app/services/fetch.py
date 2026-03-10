from app import create_app, db
import requests
from base64 import b64encode
import os
from dotenv import load_dotenv
from sqlalchemy import text
import asyncio
import httpx
import time
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



# check temp_summaries against listings to fetch only items not already there
def new_listings():
        return db.session.execute(text("""
        SELECT ts.*
        FROM temp_summaries ts
        LEFT JOIN listings l
            ON l.ebay_item_id = ts.ebay_item_id
        WHERE l.id IS NULL
    """)).mappings().all()


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


#if __name__ == "__main__":
#    print("Fetching all ThinkPad summaries...")
#    summaries = get_paginated_summaries()
#    print(f"Total summaries fetched: {len(summaries)}")
#
#    # insert into temp summaries
#    # testing_db - save_temp_summaries(summaries)
#
#    # find summaries not in listings table
#    listings = new_listings()
#
#    print("Fetching item details for new listings...")
#    details = fetch_item_details(listings) # fetch only new thinkpads
#    print(f"Total detailed items fetched: {len(details)}")
#
#    # insert details into temp details
#    #testing_db - save_temp_details(details)

    

    # move data to permanent tables
    # pipeline






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