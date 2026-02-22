import os
import requests
import csv
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

def fetch_aspects(token, marketplace_id):
    url = "https://api.ebay.com/commerce/taxonomy/v1/category_tree/0/get_item_aspects_for_category"
    headers = {
        "Authorization": f"Bearer {token}",
        "X-EBAY-C-MARKETPLACE-ID": marketplace_id
    }
    params = {"category_id": CATEGORY_ID}
    resp = requests.get(url, headers=headers, params=params)
    resp.raise_for_status()
    return resp.json().get("aspects", [])

def main():
    token = get_token()
    all_rows = []

    for country, marketplace_id in MARKETPLACES.items():
        print(f"Fetching aspects for {country}...")
        aspects = fetch_aspects(token, marketplace_id)

        for aspect in aspects:
            constraint = aspect.get("aspectConstraint", {})
            values = aspect.get("aspectValues", [])

            allowed_values = ", ".join(
                [v.get("localizedValue") for v in values if v.get("localizedValue")]
            )

            row = {
                "Marketplace": country,
                "Aspect Name": aspect.get("localizedAspectName"),
                "Required": constraint.get("aspectRequired", False),
                "MultiValue": constraint.get("itemToAspectCardinality", ""),
                "Allowed Values": allowed_values
            }

            all_rows.append(row)

    with open("category_177_item_specifics_full.csv", "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(
            f,
            fieldnames=[
                "Marketplace",
                "Aspect Name",
                "Required",
                "MultiValue",
                "Allowed Values"
            ]
        )
        writer.writeheader()
        writer.writerows(all_rows)

    print("Done! File saved as category_177_item_specifics_full.csv")

if __name__ == "__main__":
    main()


# Use these commands after changing the database 

# flask db init
# flask db migrate -m "Initial schema"
# flask db upgrade

# If Flask complains about not finding the app, set:
# set FLASK_APP=run.py