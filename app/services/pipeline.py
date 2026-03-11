from app.extensions import db
from sqlalchemy import text


# remove "thinkpad" and "lenovo" from model name
def clean_temp_data():
    """
    Clean raw temp table data.
    """
    db.session.execute(text(r"""
        UPDATE temp_details
        SET model =
            INITCAP(
                TRIM(
                    REPLACE(
                        REPLACE(LOWER(model), 'lenovo', ''),
                        'thinkpad', ''
                    )
                )
            )
        WHERE model IS NOT NULL;
    """))

# add models from temp to main table. one of each model type.
def insert_models():
    db.session.execute(text(r"""
        INSERT INTO models (name, slug)
        SELECT DISTINCT
            td.model,
            'thinkpad-' || lower(replace(td.model, ' ', '-'))
        FROM temp_details td
        LEFT JOIN models m
            ON m.name = td.model
        WHERE td.model IS NOT NULL
        AND m.id IS NULL;
    """))

# this connects listings with models
def update_listing_models():
    db.session.execute(text(r"""
        UPDATE listings l
        SET model_id = m.id
        FROM temp_details td
        JOIN models m
            ON m.name = td.model
        WHERE l.ebay_item_id = td.ebay_item_id
        AND l.model_id IS NULL;
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
            ram,
            storage,
            storage_type,
            screen_size,
            display,
            gpu,
            os,
            listing_id
        )
        SELECT
            td.cpu,
            td.cpu_freq,

            CASE
                WHEN td.ram ILIKE '%MB%'
                    THEN regexp_replace(td.ram, '^.*?(\d+(\.\d+)?).*$', '\1')::numeric / 1024
                WHEN td.ram ILIKE '%GB%'
                    THEN regexp_replace(td.ram, '^.*?(\d+(\.\d+)?).*$', '\1')::numeric
                WHEN td.ram ILIKE '%TB%'
                    THEN regexp_replace(td.ram, '^.*?(\d+(\.\d+)?).*$', '\1')::numeric * 1024                            
                ELSE NULL
            END AS ram,

            CASE
                WHEN td.storage ILIKE '%TB%'
                    THEN regexp_replace(td.storage, '^.*?(\d+(\.\d+)?).*$', '\1')::numeric * 1024
                WHEN td.storage ILIKE '%GB%'
                    THEN regexp_replace(td.storage, '^.*?(\d+(\.\d+)?).*$', '\1')::numeric
                WHEN td.storage ILIKE '%MB%'
                    THEN regexp_replace(td.storage, '^.*?(\d+(\.\d+)?).*$', '\1')::numeric / 1024
                ELSE NULL
            END AS storage,

            td.storage_type,
            td.screen_size,
            td.display,
            td.gpu,
            td.os,
            l.id
        FROM temp_details td
        JOIN listings l
        ON l.ebay_item_id = td.ebay_item_id
        WHERE l.category_id = '177'
        ON CONFLICT (listing_id) 
        DO UPDATE SET
        ram = COALESCE(EXCLUDED.ram, specs.ram),
        storage = COALESCE(EXCLUDED.storage, specs.storage),
        cpu = COALESCE(EXCLUDED.cpu, specs.cpu),
        cpu_freq = COALESCE(EXCLUDED.cpu_freq, specs.cpu_freq);
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
            first_seen,
            last_seen,
            last_updated,
            ended_at,
            status
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
            NOW(),
            NOW(),
            NOW(),
            ts.ended_at,
            'ACTIVE'
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
        AND l.price <> ts.price;
    """))

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
        WHERE l.ebay_item_id = ts.ebay_item_id;
    """))

# increment the miss_count so listings can be marked as ended.
def increment_miss_count():
    db.session.execute(text(r"""
        UPDATE listings l
        SET
            miss_count = miss_count + 1
        WHERE status = 'ACTIVE'
        AND NOT EXISTS (
            SELECT 1
            FROM temp_summaries ts
            WHERE ts.ebay_item_id = l.ebay_item_id
        );
    """))

# change status to ended for listings
def mark_ended_listings():
    db.session.execute(text(r"""
        UPDATE listings
        SET
            status = 'ENDED',
            ended_at = NOW()
        WHERE status = 'ACTIVE'
        AND miss_count >= 3;
    """))

# create data for price_history table
def insert_price_history():
    """
    Insert price history for newly inserted listings.
    """
    db.session.execute(text(r"""
        INSERT INTO price_history (listing_id, model_id, price, currency)
        SELECT
            l.id,
            l.model_id,
            l.price,
            l.currency
        FROM listings l
        WHERE NOT EXISTS (
            SELECT 1
            FROM price_history ph
            WHERE ph.listing_id = l.id
        );
    """))

# track prices by model
def update_model_price_stats():
    """
    Update aggregated model pricing stats.
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
            model_id,
            marketplace,
            AVG(price),
            MIN(price),
            MAX(price),
            COUNT(*),
            NOW()
        FROM listings
        WHERE status = 'ACTIVE'
        AND model_id IS NOT NULL
        GROUP BY model_id, marketplace
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
    clean_temp_data()
    insert_models()
    insert_listings()
    update_listing_prices()
    update_listing_models()
    update_seen_listings()
    increment_miss_count()
    mark_ended_listings()
    insert_price_history()
    update_model_price_stats()
    insert_specs()
    #truncate_temp_tables()

    db.session.commit()

