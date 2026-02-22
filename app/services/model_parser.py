import re

# Known ThinkPad models
THINKPAD_MODELS = [
    "t480",
    "t490",
    "t14",
    "t14s",
    "t15",
    "x1 carbon",
    "x1 yoga",
    "x280",
    "x390",
    "p52",
    "p53",
    "p1",
]

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

#def is_real_laptop(specifics_dict: dict) -> bool:
#    """
#    Returns True if the listing has at least one key spec indicating it's a real ThinkPad laptop.
#    
#    :param specifics_dict: dictionary from eBay item specifics
#    """
#    for key in REQUIRED_SPEC_KEYS:
#        # Check if key exists and has a non-empty value
#        if key in specifics_dict and specifics_dict[key]:
#            return True
#    return False

#def is_real_laptop(specifics_dict: dict) -> bool:
#    """
#    Returns True if the listing has key specifics indicating it's a real ThinkPad laptop.
#    
#    :param specifics_dict: dictionary from eBay item specifics
#    """
#    specs = ["model", "processor", "ram", "storage"]
#    present = [key for key in specs if key in specifics_dict and specifics_dict[key]]
#    return len(present) >= 2  # require at least 2 key specs

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