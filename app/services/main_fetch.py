from app import create_app
import asyncio
from app.services.save_temp import *
from app.services.pipeline import run_pipeline
from app.services.fetch import (new_listings, 
                                get_paginated_summaries,
                                fetch_item_details_async)
from app.services.parse import insert_storage_type, normalize_specs_field



app = create_app()

with app.app_context():
    #items = get_paginated_summaries()
    #save_temp_summaries(items)
    #listings = new_listings()
    #details = asyncio.run(fetch_item_details_async(listings))
    #save_temp_details(details)
    #run_pipeline()
    insert_storage_type()
    normalize_specs_field("raw_ram", "ram", "ram_processed")
    normalize_specs_field("raw_storage", "storage", "storage_processed")
