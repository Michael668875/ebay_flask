from app import create_app
import asyncio
from app.services.save_temp import *
from app.services.pipeline import run_pipeline
from app.services.fetch import (new_listings, 
                                get_paginated_summaries,
                                fetch_item_details_async)
from app.services.parse import (insert_storage_type, normalize_specs_field, load_thinkpad_model_map, build_model_resolution_payload, 
                                backfill_parse_table_new_only, update_model_from_parse)
from app.models import Model, Specs, Listing


app = create_app()

with app.app_context():
   backfill_parse_table_new_only()
   update_model_from_parse()
   """ model_map = load_thinkpad_model_map()

    rows = (
        db.session.query(Listing, Model, Specs)
        .outerjoin(Model, Model.listing_id == Listing.id)
        .outerjoin(Specs, Specs.listing_id == Listing.id)
        .limit(20)
        .all()
    )

    for listing, model_row, specs_row in rows:
        payload = build_model_resolution_payload(listing, model_row, model_map)

        print("=" * 80)
        print("Listing ID:", payload["listing_id"])
        print("Title:", listing.title if listing else None)
        print("raw_model ->", payload["raw_model_candidate"], payload["raw_model_confidence"])
        print("title     ->", payload["title_candidate"], payload["title_confidence"])
        print("raw_mpn   ->", payload["mpn_candidate"], payload["mpn_confidence"])
        print("FINAL     ->", payload["resolved_model_name"], payload["resolved_model_method"], payload["resolved_model_confidence"])"""

    