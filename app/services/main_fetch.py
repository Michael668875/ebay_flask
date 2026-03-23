#!/usr/bin/env python3
import os
import sys
import asyncio
import logging
from app import create_app
from app.services.save_temp import save_temp_summaries, save_temp_details
from app.services.pipeline import run_pipeline
from app.services.fetch import new_listings, get_paginated_summaries, fetch_item_details_async
from app.services.parse import insert_storage_type, normalize_specs_field, parse_all_models, blacklist

# -----------------------------
# CONFIG
# -----------------------------
PROJECT_ROOT = os.path.dirname(os.path.abspath(__file__))
LOG_DIR = os.path.join(PROJECT_ROOT, "logs")
LOG_FILE = os.path.join(LOG_DIR, "main_fetch.log")
LOCK_FILE = "/tmp/main_fetch.lock"

# Ensure logs directory exists
os.makedirs(LOG_DIR, exist_ok=True)

# -----------------------------
# Logging setup
# -----------------------------
logging.basicConfig(
    filename=LOG_FILE,
    level=logging.INFO,
    format="%(asctime)s %(levelname)s %(message)s"
)

# -----------------------------
# Prevent overlapping runs
# -----------------------------
if os.path.exists(LOCK_FILE):
    logging.warning("Another main_fetch.py job is already running. Exiting.")
    sys.exit(0)

# Create lock file
open(LOCK_FILE, "w").close()

# -----------------------------
# Main job
# -----------------------------
def main():
    logging.info("Starting main_fetch.py job")
    app = create_app()
    try:
        with app.app_context():
            # Fetch summaries
            items = get_paginated_summaries()
            clean_items = blacklist(items)
            save_temp_summaries(clean_items)
            logging.info(f"Fetched and saved {len(items)} summaries")

            # Fetch new listings and details
            listings = new_listings()
            details = asyncio.run(fetch_item_details_async(listings))
            save_temp_details(details)
            logging.info(f"Fetched and saved details for {len(details)} listings")

            # Run pipeline and parsing
            run_pipeline()
            insert_storage_type()
            normalize_specs_field("raw_ram", "ram", "ram_processed")
            normalize_specs_field("raw_storage", "storage", "storage_processed")
            parse_all_models()
            logging.info("Pipeline and parsing completed successfully")

    except Exception:
        logging.exception("Error occurred in main_fetch.py")
    finally:
        # Remove lock file
        if os.path.exists(LOCK_FILE):
            os.remove(LOCK_FILE)
        logging.info("Finished main_fetch.py job")

# -----------------------------
# Entry point
# -----------------------------
if __name__ == "__main__":
    main()