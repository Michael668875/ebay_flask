from app.extensions import db
from sqlalchemy import text
from app.services.parse import insert_storage_type
    
def insert_models():
    db.session.execute(text(r"""
        INSERT INTO models (listing_id, raw_model, raw_mpn)
        SELECT
            l.id,
            NULLIF(TRIM(td.model), ''),
            NULLIF(TRIM(td.mpn), '')
        FROM listings l
        JOIN temp_details td
          ON td.ebay_item_id = l.ebay_item_id
        WHERE NOT EXISTS (
            SELECT 1
            FROM models m
            WHERE m.listing_id = l.id
        );
    """))

# add detailed specs from temp to main table.
def insert_specs():
    """
    Insert specs from temp details
    """
    db.session.execute(text(r"""
        INSERT INTO specs (
            cpu,
            cpu_freq,
            raw_ram,
            raw_storage,
            raw_storage_type,
            screen_size,
            display,
            gpu,
            os,
            listing_id,
            ram_processed,
            storage_processed,
            storage_type_processed
        )
        SELECT
            td.cpu,
            td.cpu_freq,
            td.ram,
            td.storage,         
            td.storage_type,
            td.screen_size,
            td.display,
            td.gpu,
            td.os,
            l.id,
            FALSE,
            FALSE,
            FALSE
        FROM temp_details td
        JOIN listings l
        ON l.ebay_item_id = td.ebay_item_id
        WHERE l.category_id = '177'
        ON CONFLICT (listing_id) 
        DO UPDATE SET
        ram = COALESCE(EXCLUDED.ram, specs.ram),
        storage = COALESCE(EXCLUDED.storage, specs.storage),
        cpu = COALESCE(EXCLUDED.cpu, specs.cpu),
        cpu_freq = COALESCE(EXCLUDED.cpu_freq, specs.cpu_freq),
        raw_ram = EXCLUDED.raw_ram,
        raw_storage = EXCLUDED.raw_storage,
        raw_storage_type = EXCLUDED.raw_storage_type;
    """))

# add summaries from temp tabel into main listings table
def insert_listings():
    """
    Insert listings joined with temp details and models.
    """
    db.session.execute(text(r"""
        INSERT INTO listings (
            category_id,
            ebay_item_id,
            title,
            price,
            currency,
            condition,
            listing_type,
            marketplace,
            item_country,
            item_url,
            status,
            first_seen,
            last_seen,
            last_updated,
            ended_at,
            miss_count
        )
        SELECT
            ts.category_id,
            ts.ebay_item_id,
            ts.title,
            ts.price,
            ts.currency,
            ts.condition,
            ts.listing_type,
            ts.marketplace,
            ts.item_country,
            ts.item_url,
            'ACTIVE',
            NOW(),
            NOW(),
            NOW(),
            NULL,
            0
        FROM temp_summaries ts
        WHERE ts.category_id = '177'
        ON CONFLICT (ebay_item_id) DO NOTHING;
    """))

# update the price if it has changed
def update_listing_prices():
    db.session.execute(text(r"""
        UPDATE listings l
        SET
            price = ts.price,
            last_updated = NOW()
        FROM temp_summaries ts
        WHERE l.ebay_item_id = ts.ebay_item_id
        AND l.status = 'ACTIVE'
        AND l.price <> ts.price;
    """))

def mark_sold_listings():
    """
    Mark listings as ENDED if temp_summaries.sold_at is not NULL.
    """
    result = db.session.execute(text(r"""
        UPDATE listings l
        SET
            status = 'ENDED',
            ended_at = ts.sold_at,
            last_updated = NOW()
        FROM temp_summaries ts
        WHERE l.ebay_item_id = ts.ebay_item_id
        AND ts.sold_at IS NOT NULL
        AND l.status != 'ENDED';
    """))
    print(f"Marked {result.rowcount} listings as sold.")

# update last_seen, miss_count, last_updated 
# each time a listing appears from api
def update_seen_listings():
    db.session.execute(text(r"""
        UPDATE listings l
        SET
            last_seen = NOW(),
            miss_count = 0,
            last_updated = NOW()
        FROM temp_summaries ts
        WHERE l.ebay_item_id = ts.ebay_item_id
        AND l.status = 'ACTIVE';
    """))

# increment the miss_count so listings can be marked as ended.
def increment_miss_count():
    db.session.execute(text(r"""
        UPDATE listings l
        SET
            miss_count = miss_count + 1,
            last_updated = NOW()
        WHERE status = 'ACTIVE'
        AND NOT EXISTS (
            SELECT 1
            FROM temp_summaries ts
            WHERE ts.ebay_item_id = l.ebay_item_id
        );
    """))

# change status to ended for listings
def mark_ended_listings():
    result = db.session.execute(text(r"""
        UPDATE listings
        SET
            status = 'ENDED',
            ended_at = NOW(),
            last_updated = NOW()
        WHERE status = 'ACTIVE'
        AND miss_count >= 3;
    """))
    print(f"Marked {result.rowcount} listings as ended.")

# create data for price_history table
def insert_price_history():
    """
    Append a price_history row only when the current listing price differs
    from the most recent recorded price (or if no history exists yet),
    limited to listings present in the current scrape.
    """
    db.session.execute(text(r"""
        INSERT INTO price_history (listing_id, price, currency)
        SELECT
            l.id,
            l.price,
            l.currency
        FROM listings l
        JOIN temp_summaries ts
          ON ts.ebay_item_id = l.ebay_item_id
        LEFT JOIN LATERAL (
            SELECT ph.price, ph.currency
            FROM price_history ph
            WHERE ph.listing_id = l.id
            ORDER BY ph.recorded_at DESC, ph.id DESC
            LIMIT 1
        ) last_ph ON TRUE
        WHERE last_ph.price IS NULL
           OR last_ph.price <> l.price
           OR last_ph.currency <> l.currency;
    """))
    
# track prices by model
def update_model_price_stats():
    """
    Update aggregated model pricing stats using the new Model → Listing relationship.
    """
    db.session.execute(text(r"""
        INSERT INTO model_price_stats (
            model_id,
            marketplace,
            avg_price,
            min_price,
            max_price,
            listing_count,
            updated_at
        )
        SELECT
            m.id AS model_id,
            l.marketplace,
            AVG(l.price),
            MIN(l.price),
            MAX(l.price),
            COUNT(*),
            NOW()
        FROM listings l
        JOIN models m
          ON m.listing_id = l.id
        WHERE l.status = 'ACTIVE'
        GROUP BY m.id, l.marketplace
        ON CONFLICT (model_id, marketplace)
        DO UPDATE SET
            avg_price = EXCLUDED.avg_price,
            min_price = EXCLUDED.min_price,
            max_price = EXCLUDED.max_price,
            listing_count = EXCLUDED.listing_count,
            updated_at = NOW();
    """))

# delete temp data
def truncate_temp_tables():
    """
    Clear temp tables for next scrape.
    """
    db.session.execute(text(r"""
        TRUNCATE temp_summaries, temp_details;
    """))


def run_pipeline():
    """
    Full ingestion pipeline.
    """
    insert_listings()
    insert_models()
    update_listing_prices()
    mark_sold_listings()
    update_seen_listings()
    increment_miss_count()
    mark_ended_listings()
    insert_price_history()
    update_model_price_stats()
    insert_specs()
    insert_storage_type() # gets storage_type from raw_storage_type    

    db.session.commit()

