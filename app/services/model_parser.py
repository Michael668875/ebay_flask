import re
from app.models import ThinkPadModel, CPU, RAM, Storage

MODEL = [m.name for m in ThinkPadModel.query.all()]
PROCESSOR = [c.name for c in CPU.query.all()]
MEMORY = [r.size for r in RAM.query.all()]
STORAGE = [s.size for s in Storage.query.all()]


def parse_model_from_title(title: str, specifics_model: str = None) -> str:
    """
    Returns the ThinkPad model name from title or eBay specifics.
    
    :param title: The listing title
    :param specifics_model: Optional model from eBay specifics
    :return: Model name in uppercase or fallback
    """
    # Use specifics if available
    if specifics_model:
        return specifics_model.upper()
    
    title_lower = title.lower()

    # Check for known models in title
    for model in MODEL:
        # Word boundary to avoid partial matches
        pattern = r"\b" + re.escape(model) + r"\b"
        if re.search(pattern, title_lower):
            return model.upper()
    
    # Fallback: first 3 words
    return " ".join(title.split()[:3])

# filter out batteries and other junk from the listings
REQUIRED_SPEC_KEYS = ["model", "processor", "ram", "storage"]

def is_real_laptop(product_dict: dict) -> bool: # this won't work with the browse api as it doesn't return item specifics
    """
    Returns True if this product looks like a real laptop.
    Requires:
    - model_name must exist
    - At least one of cpu, ram, or storage must be filled
    """
    # model_name must exist
    if not product_dict.get("model"):
        return False

    # At least one spec
    if product_dict.get("cpu") or product_dict.get("ram") or product_dict.get("storage"):
        return True

    # Otherwise, treat as junk
    return False

def parse_product_details(title: str):
    """
    Parse ThinkPad title to extract model, CPU, RAM, and storage.
    """
    title_lower = title.lower()

    # ----- Model -----
    model = "Unknown"
    longest_match_len = 0
    for m in MODEL:
        if m.lower() in title_lower and len(m) > longest_match_len:
            model = m
            longest_match_len = len(m)

    # ----- CPU -----
    cpu = "Unknown"
    for c in PROCESSOR:
        if c.lower() in title_lower:
            cpu = c
            break

    # ----- RAM -----
    ram = "Unknown"
    for r in MEMORY:
        if r.lower() in title_lower:
            ram = r
            break

    # ----- Storage -----
    storage = "Unknown"
    for s in STORAGE:
        # Remove spaces for more robust matching
        if s.lower().replace(" ", "") in title_lower.replace(" ", ""):
            storage = s
            break
    print(model, cpu, ram, storage)
    return model, cpu, ram, storage

