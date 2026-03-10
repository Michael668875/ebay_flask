from app.extensions import db
from sqlalchemy import text

"""
UPDATE listings
SET status='ENDED'
WHERE last_seen < NOW() - INTERVAL '1 day'
"""


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
            item_url,
            first_seen,
            last_seen,
            sold_at,
            last_updated,
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
            ts.item_url,
            ts.first_seen,
            ts.last_seen,
            ts.sold_at,
            ts.last_updated,
            'ACTIVE'
        FROM temp_summaries ts
        WHERE ts.category_id = '177'
        ON CONFLICT (ebay_item_id) DO NOTHING;
    """))


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
        CREATE INDEX idx_listings_model_active_price
        ON listings (model_id, price)
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
    insert_listings()
    insert_models()
    update_listing_models()
    insert_price_history()
    update_model_price_stats()
    insert_specs()
    #truncate_temp_tables()

    db.session.commit()