from app import create_app
import asyncio
from app.services.testing_db import *
from app.services.pipeline import run_pipeline
from app.services.fetch import (get_thinkpads, 
                                new_listings, 
                                fetch_item_details, 
                                get_paginated_summaries,
                                fetch_item_details_async)


app = create_app()

with app.app_context():
    #insert_summaries_from_log()
    #insert_details_from_log()
    #insert_into_temp_summaries()    
    #insert_into_temp_details()
    items = get_paginated_summaries()
    save_temp_summaries(items)
    listings = new_listings()
    details = asyncio.run(fetch_item_details_async(listings))
    save_temp_details(details)
    run_pipeline()
