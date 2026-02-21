from app.celery import celery
from fetch_ebay import get_thinkpads
from app.ebay_sync import upsert_listings
from app import create_app

app = create_app()

@celery.task
def sync_ebay():
    with app.app_context():
        items = get_thinkpads()
        upsert_listings(items)
        return f"Synced {len(items)} listings"