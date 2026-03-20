import re
from app.extensions import db
from app.models import Specs


# model selection logic - this is in jinja right now
#    parsed_aspect 
#    parsed_title
#    parsed_mpn
#    model_source
#    name



STORAGE_MAP = {
    "NVMe": ["nvme", "non-volatile memory express"],
    "SSD": ["ssd", "solid state drive", "solid-state-drive"],
    "HDD": ["hdd", "hard disk drive", "hard-disk-drive", "hard disk"],
}

def normalize_storage_type(raw_value):
    if not raw_value:
        return None

    raw_value = raw_value.strip().lower()

    for normalized, aliases in STORAGE_MAP.items():
        if any(alias in raw_value for alias in aliases):
            return normalized

    return None

def insert_storage_type():
    specs = (
        db.session.query(Specs)
        .filter(Specs.storage_type_processed.is_(False))
        .all()
    )

    for spec in specs:
        spec.storage_type = normalize_storage_type(spec.raw_storage_type)
        spec.storage_type_processed = True

    db.session.commit()


def convert_size_to_gb(raw_value):
    """
    Converts values like:
    '512MB', '16 GB', '1TB', '1.5 TB'
    into float GB.
    Returns None if invalid.
    """
    if not raw_value:
        return None

    text = raw_value.strip().upper()

    if text in {"NONE", "N/A", "UNKNOWN", "NULL", "-"}:
        return None

    match = re.search(r'(\d+(?:\.\d+)?)\s*(MB|GB|TB)\b', text)
    if not match:
        return None

    num = float(match.group(1))
    unit = match.group(2)

    if num <= 0:
        return None

    if unit == "TB":
        return num * 1024
    elif unit == "GB":
        return num
    elif unit == "MB":
        return num / 1024

    return None

def normalize_specs_field(field_raw: str, field_clean: str, processed_flag: str):
    """
    Generic function to normalize a Specs field.
    Arguments:
        field_raw: str = column name of raw field (e.g., "raw_ram")
        field_clean: str = column name of clean field (e.g., "ram")
        processed_flag: str = column name of processed boolean (e.g., "ram_processed")
    """
    from sqlalchemy import and_

    # Get unprocessed rows
    rows = db.session.query(Specs).filter(
        getattr(Specs, field_raw).isnot(None),
        getattr(Specs, processed_flag) == False
    ).all()

    updated_count = 0

    for spec in rows:
        raw_value = getattr(spec, field_raw)
        converted = convert_size_to_gb(raw_value)

        setattr(spec, field_clean, converted)
        setattr(spec, processed_flag, True)
        updated_count += 1

    db.session.commit()
    print(f"Updated {updated_count} rows for {field_clean}")

# how to use it
"""
    # Normalize RAM
normalize_specs_field("raw_ram", "ram", "ram_processed")

# Normalize Storage
normalize_specs_field("raw_storage", "storage", "storage_processed")
"""

# Later in font end, convert gb back to MB/GB/TB
"""
def display_size_gb(value_gb: float) -> str:
    if value_gb is None:
        return "N/A"
    if value_gb >= 1024:
        return f"{value_gb / 1024:.1f}TB"
    elif value_gb < 1:
        return f"{value_gb * 1024:.0f}MB"
    else:
        return f"{value_gb:.0f}GB"
"""
        

         



"""
if field in ["ram", "storage"] and not valid_capacity(value):
                    continue
                if field == "storage_type":
                    value = clean_storage_type(value)
    do something with this in pipeline

"""


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



def normalize_model(value): # reuse this in pipeline
    """Normalize model strings for comparison."""
    if not value:
        return ""
    value = value.upper().strip()
    # Remove brand words
    value = re.sub(r'\bLENOVO\b', '', value)
    value = re.sub(r'\bTHINKPAD\b', '', value)
    # Normalize generation wording: "5TH GEN" -> "GEN 5"
    value = re.sub(r'\b(\d+)(ST|ND|RD|TH)\s+GEN\b', r'GEN \1', value)
    # Collapse spaces
    value = re.sub(r'\s+', ' ', value).strip()
    return value

def normalize_compact(value): # reuse this in pipeline
    """Lowercase, remove spaces for compact matching."""
    return re.sub(r"\s+", "", value.lower())

def classify_model_priority(model): # reuse this in pipeline. It might be too strict though
    """
    Priority tiers:
      1 = letters + numbers + extra word(s)   e.g. X1 Carbon, T14 Gen 2, Yoga 11e
      2 = letters + numbers only              e.g. X1, T480, E14
      3 = numbers only                        e.g. 25, 300, 390
      4 = everything else / fallback
    """
    norm = normalize_model(model)
    has_letters = bool(re.search(r'[A-Z]', norm))
    has_digits = bool(re.search(r'\d', norm))
    tokens = norm.split()

    if re.fullmatch(r'\d+', norm):
        return 3
    if has_letters and has_digits and len(tokens) >= 2:
        return 1
    if has_letters and has_digits:
        return 2
    return 4

def build_model_index(canon_models): # reuse this in pipeline
    """Build priority groups for canonical models."""
    groups = {1: [], 2: [], 3: [], 4: []}
    for model in canon_models:
        norm = normalize_model(model)
        compact = normalize_compact(model)
        priority = classify_model_priority(model)
        groups[priority].append((compact, norm, model))
    # longest first within each tier
    for priority in groups:
        groups[priority].sort(key=lambda x: len(x[0]), reverse=True)
    return groups

def find_best_model_match(text, model_groups): # resuse this in pipeline. It might be too strict
    """Return the best canonical model match for a text string."""
    if not text:
        return None
    text_norm = normalize_model(text)
    text_compact = normalize_compact(text)

    # -------------------------
    # Tier 1: letters+digits+words
    # -------------------------
    for model_compact, _norm, canonical_model in model_groups[1]:
        if model_compact in text_compact:
            return canonical_model

    # -------------------------
    # Tier 2: letters+digits
    # -------------------------
    for model_compact, _norm, canonical_model in model_groups[2]:
        if model_compact in text_compact:
            return canonical_model

    # -------------------------
    # Tier 3: numeric-only
    # Only match if "ThinkPad <number>" appears
    # -------------------------
    for _compact, model_norm, canonical_model in model_groups[3]:
        pattern = rf'\b{re.escape(model_norm)}\b'
        if re.search(pattern, text_norm):
            return canonical_model

    # -------------------------
    # Tier 4: fallback
    # -------------------------
    for model_compact, _norm, canonical_model in model_groups[4]:
        if model_compact in text_compact:
            return canonical_model

    return None

def should_prefer_title_model(aspect_model, title_model): # might reuse this. Not sure.
    """
    Decide if title-derived model should override aspect model.
    Prefer title if it is longer/more descriptive or higher priority.
    """
    aspect_priority = classify_model_priority(aspect_model) if aspect_model else 0
    title_priority = classify_model_priority(title_model) if title_model else 0

    if title_priority < aspect_priority:
        return True
    if title_priority == aspect_priority:
        return len(title_model) > len(aspect_model)
    return False



