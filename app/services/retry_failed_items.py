# THIS FILE IS TO RETRY ITEMS THAT FAILED WITH SYNC.PY
# CHECK FAILED_ITEMS.JSONL TO SEE WHAT DIDN'T WORK

import json
from pathlib import Path
from app.services.sync import save_thinkpads

FAIL_FILE = Path(__file__).parent / "failed_items.jsonl"
DEAD_FILE = Path(__file__).parent / "dead_letter.jsonl"
MAX_RETRIES = 3

def load_failed_items():
    if not FAIL_FILE.exists():
        return []
    
    failed_items = []
    with FAIL_FILE.open("r", encoding="utf-8") as f:
        for line in f:
            failed_items.append(json.loads(line))  #["items"]

    return failed_items

# Then call save_thinkpads(failed_items, app)
def retry_failed(app):    
    failed_items = load_failed_items()

    if not failed_items:
        print("No failed items to retry.")
        return
    
    print(f"Retrying {len(failed_items)} failed items...")

    # Clear file before retrying
    FAIL_FILE.unlink(missing_ok=True)

    retry_items = []
    permanently_failed = []

    for entry in failed_items:
        retry_count = entry.get("retry_count", 1)
        item = entry["item"]

        if retry_count >= MAX_RETRIES:
            permanently_failed.append(entry)
        else:
            # Attach retry_count back onto item for next attempt
            item["retry_count"] = retry_count
            retry_items.append(item)

    # Log permanent failures
    if permanently_failed:
        with DEAD_FILE.open("a", encoding="utf-8") as f:
            for entry in permanently_failed:
                f.write(json.dumps(entry) + "\n")

        print(f"{len(permanently_failed)} items moved to dead_letter.jsonl")

    # Retry remaining items
    if retry_items:
        save_thinkpads(retry_items, app)
        print(f"Retried {len(retry_items)} items.")

    print("Retry complete.")