from app import db
from app.models import (Model, 
                        Listing, 
                        PriceHistory, 
                        ThinkPadModel, 
                        CPU, 
                        RAM, 
                        Storage, 
                        Marketplace, 
                        TempSummaries, 
                        TempDetails,
                        generate_unique_slug)



def insert_and_clean():
# load all temp summaries and details into dictionaries for fast lookup

    temp_summaries = {t.ebay_item_id: t for t in TempSummaries.query.all()}
    temp_details = {t.ebay_item_id: t for t in TempDetails.query.all()}


    cleaned_listings = []
    cleaned_models = []

    for ebay_id, summary in temp_summaries.items():

        # Remove listings not in category 177
        if summary.category_id != "177":
            continue

        details = temp_details.get(ebay_id)

        """# Clean model name
        model_name = (details.model if details else summary.title).lower()
        for word in ["lenovo", "thinkpad"]:
            model_name = model_name.replace(word, "")
        model_name = model_name.strip().title()  # optional capitalization"""

        """# Clean storage type
        storage_type = None
        if details and details.storage_type:
            if "solid state drive" in details.storage_type.lower():
                storage_type = "SSD"
            else:
                storage_type = details.storage_type"""
        
        # Prepare permanent Model object (or just normalized specs)
        if details:
            model = Model(
                name=details.model
            )
            cleaned_models.append(model)


        # Prepare permanent Listing object
        listing = Listing(
            ebay_item_id=ebay_id,
            title=summary.title,
            price=summary.price,
            currency=summary.currency,
            condition=summary.condition,
            listing_type=summary.listing_type,
            marketplace=summary.marketplace,
            item_url=summary.item_url,
            first_seen=summary.first_seen,
            last_seen=summary.last_seen,
            sold_at=summary.sold_at,
            last_updated=summary.last_updated,
            cpu=details.cpu,
            cpu_freq=details.cpu_freq,
            ram=details.ram,
            storage=details.storage,
            storage_type=details.storage_type,
            screen_size=details.screen_size,
            display=details.display,
            gpu=details.gpu,
            os=details.os,
            model=model
        )
        cleaned_listings.append(listing)


    for model, listing in zip(cleaned_models, cleaned_listings):
        listing.model_id = model.id

    db.session.add_all(cleaned_models)
    db.session.add_all(cleaned_listings)
    db.session.commit()

