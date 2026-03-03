from app import create_app
from app.services.sync import save_thinkpads, save_thinkpads_detailed, build_context
from app.services.fetch import get_thinkpads, fetch_items_in_batches, extract_localized_aspects
from app.services.retry_failed_items import retry_failed

def run_sync():
    app = create_app()
    
    with app.app_context():

        items = get_thinkpads()

        context = build_context(items)
        save_thinkpads(items, context)

        details = fetch_items_in_batches(items)
        detailed_with_marketplace = extract_localized_aspects(details, items) 

        context = build_context(items)
        save_thinkpads_detailed(detailed_with_marketplace, context)
        retry_failed(context)

        print(f"Synced {len(items)} ThinkPad listings.")
        
        
if __name__ == "__main__":
    run_sync()



