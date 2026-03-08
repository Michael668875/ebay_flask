from app.extensions import db
from sqlalchemy import text


def clean_temp_data():
    """
    Clean raw temp table data.
    """
    db.session.execute(text("""
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
    db.session.execute(text("""
        INSERT INTO models (name, slug)
        SELECT
            m.model,
            'thinkpad-' || lower(replace(m.model, ' ', '-'))
        FROM (
            SELECT DISTINCT model
            FROM temp_details
            WHERE model IS NOT NULL
        ) m
        LEFT JOIN models existing
            ON existing.name = m.model
        WHERE existing.id IS NULL;
    """))
    
def insert_specs():
    """
    Insert specs from temp details
    """
    db.session.execute(text("""
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
            td.ram,
            td.storage,
            td.storage_type,
            td.screen_size,
            td.display,
            td.gpu,
            td.os,
            l.id
        FROM temp_details td
        JOIN listings l
        ON l.ebay_item_id = td.ebay_item_id
        WHERE td.category_id = '177'
        ON CONFLICT (listing_id) DO NOTHING;
    """))


def insert_listings():
    """
    Insert listings joined with temp details and models.
    """
    db.session.execute(text("""
        INSERT INTO listings (
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
    db.session.execute(text("""
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
    db.session.execute(text("""
        INSERT INTO model_price_stats (
            model_id,
            avg_price,
            min_price,
            max_price,
            listing_count,
            updated_at
        )
        SELECT
            model_id,
            AVG(price),
            MIN(price),
            MAX(price),
            COUNT(*),
            NOW()
        FROM listings
        WHERE status = 'ACTIVE'
        GROUP BY model_id
        ON CONFLICT (model_id)
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
    db.session.execute(text("""
        TRUNCATE temp_summaries, temp_details;
    """))


def run_pipeline():
    """
    Full ingestion pipeline.
    """
    clean_temp_data()
    insert_models()
    insert_listings()
    insert_price_history()
    update_model_price_stats()
    truncate_temp_tables()

    db.session.commit()