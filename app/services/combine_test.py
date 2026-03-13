from app import create_app
import asyncio
from app.services.fetch import get_item_details
from app.services.save_temp import *
from app.services.pipeline import run_pipeline
from app.services.fetch import (new_listings, 
                                get_paginated_summaries,
                                fetch_item_details_async)


app = create_app()

with app.app_context():
    #items = get_paginated_summaries()
    save_temp_summaries()
    #listings = new_listings()
    #details = asyncio.run(fetch_item_details_async(listings))
    save_temp_details()
    run_pipeline()
    #get_item_details("v1|257389702682|0", "EBAY_US")
