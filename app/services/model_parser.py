import re
import os

# Known ThinkPad models
def load_models(filepath):
    with open(filepath, "r", encoding="utf-8") as f:
        return [line.strip() for line in f if line.strip()]

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
FILE_PATH = os.path.join(BASE_DIR, "..", "data", "thinkpad_models.txt")
CPU_FILE_PATH = os.path.join(BASE_DIR, "..", "data", "cpu_list.txt")
RAM_FILE_PATH = os.path.join(BASE_DIR, "..", "data", "ram_sizes.txt")
SSD_FILE_PATH = os.path.join(BASE_DIR, "..", "data", "storage_sizes.txt")


THINKPAD_MODELS = load_models(FILE_PATH)

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
    for model in THINKPAD_MODELS:
        # Word boundary to avoid partial matches
        pattern = r"\b" + re.escape(model) + r"\b"
        if re.search(pattern, title_lower):
            return model.upper()
    
    # Fallback: first 3 words
    return " ".join(title.split()[:3])

# filter out batteries and other junk from the listings
REQUIRED_SPEC_KEYS = ["model", "processor", "ram", "storage"]

def is_real_laptop(product_dict: dict) -> bool:
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

# Example CPU, RAM, Storage lists
CPUS = load_models(CPU_FILE_PATH)
RAM_SIZES = load_models(RAM_FILE_PATH)
STORAGE_SIZES = load_models(SSD_FILE_PATH)

def parse_product_details(title: str):
    """
    Parse ThinkPad title to extract model, CPU, RAM, and storage.
    """
    title_lower = title.lower()

    # ----- Model -----
    model = "Unknown"
    longest_match_len = 0
    for m in THINKPAD_MODELS:
        if m.lower() in title_lower and len(m) > longest_match_len:
            model = m
            longest_match_len = len(m)

    # ----- CPU -----
    cpu = "Unknown"
    for c in CPUS:
        if c.lower() in title_lower:
            cpu = c
            break

    # ----- RAM -----
    ram = "Unknown"
    for r in RAM_SIZES:
        if r.lower() in title_lower:
            ram = r
            break

    # ----- Storage -----
    storage = "Unknown"
    for s in STORAGE_SIZES:
        # Remove spaces for more robust matching
        if s.lower().replace(" ", "") in title_lower.replace(" ", ""):
            storage = s
            break
    print(model, cpu, ram, storage)
    return model, cpu, ram, storage

