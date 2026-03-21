import re
from app.models import db, Specs, Model, ThinkPadModel, Listing, Parse
from difflib import SequenceMatcher


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
        

         
# possible query logic
"""rows = (
    db.session.query(Model.raw_model)
    .filter(Model.raw_model.isnot(None))
    .filter(Model.raw_model != "")
    .all()
)

for row in rows:
    raw_model = row.raw_model
    print(raw_model)"""


# Model parsing

def normalize_text(value: str) -> str | None:
    if not value:
        return None

    value = str(value).strip()
    if not value:
        return None

    value = value.replace("’", "'").replace("–", "-").replace("—", "-")
    value = re.sub(r"\s+", " ", value)

    return value.strip()

NON_THINKPAD_PATTERNS = [
    r"\bideapad\b",
    r"\bthinkbook\b",
    r"\bchromebook\b",
    r"\bflex\b",
    r"\blegion\b",
    r"\bmiix\b",
    r"\btab\b",
    r"\byoga\b(?!.*\bx1\s+yoga\b)",  # reject Yoga unless X1 Yoga
]

def is_obviously_not_thinkpad(value: str) -> bool:
    value = normalize_text(value)
    if not value:
        return False

    for pattern in NON_THINKPAD_PATTERNS:
        if re.search(pattern, value, flags=re.I):
            return True

    return False

def clean_thinkpad_candidate(value: str) -> str | None:
    value = normalize_text(value)
    if not value:
        return None

    value = re.sub(r"\b(lenovo|ibm)\b", "", value, flags=re.I)
    value = re.sub(r"\bthinkpad\b", "", value, flags=re.I)

    value = re.sub(
        r"\b(laptop|notebook|ultrabook|touchscreen|touch|tablet|computer|pc|fhd|uhd|wuxga|ips)\b",
        "",
        value,
        flags=re.I,
    )

    # CPU noise
    value = re.sub(r"\bi[3579]-?\d{4,5}[a-z]{0,3}\b", "", value, flags=re.I)
    value = re.sub(r"\b(?:intel\s+)?core\s+i[3579]\b", "", value, flags=re.I)
    value = re.sub(r"\bryzen\s*[3579]\b", "", value, flags=re.I)

    # RAM / storage noise
    value = re.sub(r"\b\d{1,3}\s?gb\b", "", value, flags=re.I)
    value = re.sub(r"\b\d{1,2}\s?tb\b", "", value, flags=re.I)
    value = re.sub(r"\b(ssd|nvme|hdd|emmc)\b", "", value, flags=re.I)

    # screen size noise
    value = re.sub(r'\b\d{1,2}(?:\.\d)?\s?(?:["”]|inch|in)\b', "", value, flags=re.I)

    # punctuation cleanup
    value = re.sub(r"[^\w\s\-]", " ", value)
    value = re.sub(r"\s+", " ", value).strip()

    return value or None

# Match canonical names
#"ThinkPad X1 Carbon 6th Gen" should match X1 Carbon Gen 6
#"T14 Gen1" should match T14 Gen 1
def canonicalize_model_text(value: str) -> str:
    value = normalize_text(value) or ""
    value = value.lower()

    # remove brand words
    value = re.sub(r"\b(lenovo|ibm|thinkpad)\b", "", value)

    # normalize generation formats
    value = re.sub(r"\b(\d+)(st|nd|rd|th)\s+gen\b", r"gen \1", value)   # 6th Gen -> gen 6
    value = re.sub(r"\bgen\s*([0-9]+)\b", r"gen \1", value)             # Gen6 -> gen 6
    value = re.sub(r"\bg\s*([0-9]+)\b", r"gen \1", value)               # G1 -> gen 1 (careful but useful for aliases)

    # normalize common series names
    value = re.sub(r"\bx1\s*carbon\b", "x1 carbon", value)
    value = re.sub(r"\bx1\s*yoga\b", "x1 yoga", value)

    # compact spaced suffixes: T480 S -> T480s
    value = re.sub(r"\b([txple])\s?(\d{2,3})\s+s\b", r"\1\2s", value)

    # compact spaced family+number: T 480 -> T480
    value = re.sub(r"\b([txple])\s+(\d{2,3})\b", r"\1\2", value)

    # compact "T14 S" -> "T14s"
    value = re.sub(r"\b([txple]\d{2})\s+s\b", r"\1s", value)

    value = re.sub(r"[^\w\s]", " ", value)
    value = re.sub(r"\s+", " ", value).strip()

    return value

def extract_model_family(value: str) -> str | None:
    value = canonicalize_model_text(value)
    if not value:
        return None

    if re.search(r"\bx1 carbon\b", value):
        return "x1 carbon"

    if re.search(r"\bx1 yoga\b", value):
        return "x1 yoga"

    if re.search(r"\bx13 yoga\b", value):
        return "x13 yoga"

    m = re.search(r"\b([txple])\d{2,3}s?\b", value)
    if m:
        return m.group(1)

    m = re.search(r"\b(x)\d{2,3}s?\b", value)
    if m:
        return m.group(1)

    return None

THINKPAD_MODEL_PATTERNS = [
    # X1 Carbon / X1 Yoga with generation
    r"\bX1\s+Carbon\s+(?:Gen\s*\d+|\d+(?:st|nd|rd|th)\s+Gen)\b",
    r"\bX1\s+Yoga\s+(?:Gen\s*\d+|\d+(?:st|nd|rd|th)\s+Gen)\b",

    # compact X1C6 / X1Y4 shorthand
    r"\bX1C\s*\d+\b",
    r"\bX1Y\s*\d+\b",

    # Gen-series families
    r"\b(?:X13\s+Yoga|X13|T14s|T14|T16|P14s|P15s|P16s|L13|L14|L15|E14|E15)\s*(?:Gen\s*\d+|G\d+)\b",

    # classic families
    r"\bX\d{3}s?\b",
    r"\bT\d{3}s?\b",
    r"\bP\d{2,3}s?\b",
    r"\bL\d{3}s?\b",
    r"\bE\d{3}s?\b",
]

def extract_thinkpad_candidate(value: str) -> str | None:
    value = normalize_text(value)
    if not value:
        return None

    if is_obviously_not_thinkpad(value):
        return None

    for pattern in THINKPAD_MODEL_PATTERNS:
        m = re.search(pattern, value, flags=re.I)
        if m:
            return m.group(0).strip()

    return clean_thinkpad_candidate(value)


# Alias generation. This is the main upgrade
# This auto-generates likely seller shorthand from ThinkPadModel.name.
def generate_model_aliases(model_name: str) -> set[str]:
    """
    Auto-generate common seller aliases from ThinkPadModel.name.
    Returns canonicalized alias strings.
    """
    aliases = set()

    raw = normalize_text(model_name)
    canon = canonicalize_model_text(model_name)

    if not raw or not canon:
        return aliases

    aliases.add(canon)

    # -----------------------------
    # X1 Carbon Gen N
    # -----------------------------
    m = re.fullmatch(r"x1 carbon gen (\d+)", canon)
    if m:
        gen = m.group(1)
        aliases.update({
            f"x1 carbon gen {gen}",
            f"x1 carbon {gen}",
            f"x1c {gen}",
            f"x1c gen {gen}",
            f"x1c{gen}",
        })

    # -----------------------------
    # X1 Yoga Gen N
    # -----------------------------
    m = re.fullmatch(r"x1 yoga gen (\d+)", canon)
    if m:
        gen = m.group(1)
        aliases.update({
            f"x1 yoga gen {gen}",
            f"x1 yoga {gen}",
            f"x1y {gen}",
            f"x1y gen {gen}",
            f"x1y{gen}",
        })

    # -----------------------------
    # X13 Yoga Gen N
    # -----------------------------
    m = re.fullmatch(r"x13 yoga gen (\d+)", canon)
    if m:
        gen = m.group(1)
        aliases.update({
            f"x13 yoga gen {gen}",
            f"x13 yoga {gen}",
            f"x13y gen {gen}",
            f"x13y{gen}",
        })

    # -----------------------------
    # Generic Gen models: T14 Gen 1, P14s Gen 3, L13 Gen 2, etc.
    # -----------------------------
    m = re.fullmatch(r"([txple]\d{2,3}s?) gen (\d+)", canon)
    if m:
        base = m.group(1)
        gen = m.group(2)
        aliases.update({
            f"{base} gen {gen}",
            f"{base}{'g'}{gen}",
            f"{base} {gen}",   # risky, but useful for seller shorthand
        })

    # -----------------------------
    # Classic models: T480, T480s, X280, P52s
    # -----------------------------
    m = re.fullmatch(r"([txple]\d{2,3}s?)", canon)
    if m:
        base = m.group(1)
        aliases.add(base)

        # spaced variant e.g. T480 S -> t480s
        m2 = re.fullmatch(r"([txple]\d{2,3})s", base)
        if m2:
            aliases.add(f"{m2.group(1)} s")

    # normalize all aliases
    normalized_aliases = {canonicalize_model_text(a) for a in aliases if a}
    normalized_aliases = {a for a in normalized_aliases if a}

    return normalized_aliases

# This is what you preload once per batch.
def load_thinkpad_model_map():
    """
    Requires ThinkPadModel in scope.
    Preload once, not per listing.
    """
    models = db.session.query(ThinkPadModel).all()

    model_map = []
    for m in models:
        canon = canonicalize_model_text(m.name)
        family = extract_model_family(m.name)
        aliases = generate_model_aliases(m.name)

        model_map.append({
            "name": m.name,
            "canon": canon,
            "family": family,
            "aliases": aliases,
        })

    # longest canonical first = prefer specific models
    model_map.sort(key=lambda x: len(x["canon"]), reverse=True)
    return model_map

# Alias-aware matcher
def match_thinkpad_model(cleaned_value: str, model_map: list[dict]):
    if not cleaned_value:
        return {
            "matched_model": None,
            "match_confidence": 0.0,
            "closest_model": None,
            "closest_score": 0.0,
        }

    candidate = canonicalize_model_text(cleaned_value)
    candidate_family = extract_model_family(candidate)

    # ---------------------------------
    # 1) exact canonical / exact alias
    # ---------------------------------
    for model in model_map:
        if candidate == model["canon"]:
            return {
                "matched_model": model["name"],
                "match_confidence": 0.99,
                "closest_model": model["name"],
                "closest_score": 0.99,
            }

        if candidate in model["aliases"]:
            return {
                "matched_model": model["name"],
                "match_confidence": 0.985,
                "closest_model": model["name"],
                "closest_score": 0.985,
            }

    # ---------------------------------
    # 2) containment against canon/aliases
    # ---------------------------------
    for model in model_map:
        if model["canon"] in candidate:
            return {
                "matched_model": model["name"],
                "match_confidence": 0.97,
                "closest_model": model["name"],
                "closest_score": 0.97,
            }

        for alias in model["aliases"]:
            if alias and len(alias) >= 4 and alias in candidate:
                return {
                    "matched_model": model["name"],
                    "match_confidence": 0.95,
                    "closest_model": model["name"],
                    "closest_score": 0.95,
                }

    # ---------------------------------
    # 3) family-aware fuzzy
    # ---------------------------------
    if candidate_family:
        family_pool = [m for m in model_map if m["family"] == candidate_family]
    else:
        family_pool = model_map

    best_name = None
    best_score = 0.0

    for model in family_pool:
        # compare against canon
        score = SequenceMatcher(None, candidate, model["canon"]).ratio()
        if score > best_score:
            best_score = score
            best_name = model["name"]

        # compare against aliases too
        for alias in model["aliases"]:
            score = SequenceMatcher(None, candidate, alias).ratio()
            if score > best_score:
                best_score = score
                best_name = model["name"]

    if best_score < 0.70:
        best_name = None

    return {
        "matched_model": None,
        "match_confidence": 0.0,
        "closest_model": best_name,
        "closest_score": best_score,
    }

# standard result builder
def empty_parse_result(source, raw_value):
    return {
        "source": source,
        "raw_value": raw_value,
        "cleaned_value": None,
        "value": None,
        "matched_model": None,
        "confidence": 0.0,
        "closest_model": None,
        "closest_score": 0.0,
    }

def build_parse_result(source, raw_value, cleaned_value, model_map, base_unmatched_conf=0.50):
    if not cleaned_value:
        return empty_parse_result(source, raw_value)

    match = match_thinkpad_model(cleaned_value, model_map)

    if match["matched_model"]:
        return {
            "source": source,
            "raw_value": raw_value,
            "cleaned_value": cleaned_value,
            "value": match["matched_model"],
            "matched_model": match["matched_model"],
            "confidence": match["match_confidence"],
            "closest_model": match["matched_model"],
            "closest_score": match["match_confidence"],
        }

    return {
        "source": source,
        "raw_value": raw_value,
        "cleaned_value": cleaned_value,
        "value": cleaned_value,
        "matched_model": None,
        "confidence": base_unmatched_conf,
        "closest_model": match["closest_model"],
        "closest_score": match["closest_score"],
    }

def parse_model_from_raw_model(raw_model: str, model_map: list[dict]):
    if not raw_model:
        return empty_parse_result("raw_model", raw_model)

    if is_obviously_not_thinkpad(raw_model):
        return empty_parse_result("raw_model", raw_model)

    cleaned = extract_thinkpad_candidate(raw_model)
    result = build_parse_result("raw_model", raw_model, cleaned, model_map, base_unmatched_conf=0.65)

    if result["matched_model"]:
        result["confidence"] = max(result["confidence"], 0.98)
    elif result["cleaned_value"]:
        result["confidence"] = 0.65

    return result


THINKPAD_MODEL_RE = re.compile(
    r'\b('
    r'X1\s+(?:Carbon|Yoga|Nano|Fold)\s+Gen\s+\d+|'
    r'X1\s+(?:Carbon|Yoga|Nano|Fold)|'
    r'[A-Z]\d{2,3}(?:s|v)?(?:\s+Yoga)?\s+Gen\s+\d+|'
    r'[A-Z]\d{2,3}(?:s|v)?(?:\s+Yoga)?|'
    r'\d{3}[A-Z]?'
    r')\b',
    re.IGNORECASE
)

CPU_TOKEN_RE = re.compile(
    r'^\d{3,5}[A-Z]{1,2}$',  # 240H, 8350U, 8650U, 1255U, 7840U
    re.IGNORECASE
)

def is_probable_cpu_token(token: str) -> bool:
    if not token:
        return False
    token = token.strip().upper()
    return bool(CPU_TOKEN_RE.match(token))


def extract_after_thinkpad(title: str) -> str | None:
    """
    Prefer model-like text immediately following 'ThinkPad'.
    Examples:
      ThinkPad E16 Gen 3 -> E16 Gen 3
      ThinkPad T480s     -> T480s
      ThinkPad X1 Carbon Gen 6 -> X1 Carbon Gen 6
      ThinkPad 240X      -> 240X
    """
    if not title:
        return None

    m = re.search(r'\bthinkpad\b\s+(.+)', title, re.IGNORECASE)
    if not m:
        return None

    tail = m.group(1).strip()
    tokens = tail.split()

    if not tokens:
        return None

    # Try longer / more specific candidates first
    candidates = []

    # X1 family
    if len(tokens) >= 4:
        c = " ".join(tokens[:4])   # X1 Carbon Gen 6
        candidates.append(c)

    if len(tokens) >= 3:
        c = " ".join(tokens[:3])   # E16 Gen 3 / X1 Carbon Gen
        candidates.append(c)

    if len(tokens) >= 2:
        c = " ".join(tokens[:2])   # X1 Carbon / E16 Gen / 240X 12.1"
        candidates.append(c)

    candidates.append(tokens[0])   # E16 / T480s / 240X / 240

    # Test candidates from most specific to least specific
    for candidate in candidates:
        c = candidate.strip()

        # Strong model shapes
        if re.fullmatch(r'X1\s+(?:Carbon|Yoga|Nano|Fold)\s+Gen\s+\d+', c, re.IGNORECASE):
            return c
        if re.fullmatch(r'X1\s+(?:Carbon|Yoga|Nano|Fold)', c, re.IGNORECASE):
            return c
        if re.fullmatch(r'[A-Z]\d{2,3}(?:s|v)?(?:\s+Yoga)?\s+Gen\s+\d+', c, re.IGNORECASE):
            return c
        if re.fullmatch(r'[A-Z]\d{2,3}(?:s|v)?(?:\s+Yoga)?', c, re.IGNORECASE):
            return c
        if re.fullmatch(r'\d{3}[A-Z]?', c, re.IGNORECASE):  # 240, 240X, 240Z
            return c

    return None


def parse_model_from_title(title: str, model_map: list[dict]):
    if not title:
        return empty_parse_result("title", title)

    if is_obviously_not_thinkpad(title):
        return empty_parse_result("title", title)

    candidate = None
    source_conf = 0.55

    # 1) Strongest signal: immediately after "ThinkPad"
    candidate = extract_after_thinkpad(title)
    if candidate:
        source_conf = 0.92

    # 2) Fallback to broader title scan
    if not candidate:
        m = THINKPAD_MODEL_RE.search(title)
        if m:
            raw_match = m.group(1).strip()
            if not is_probable_cpu_token(raw_match):
                candidate = raw_match
                source_conf = 0.75

    # 3) Last fallback to your existing extractor
    if not candidate:
        fallback = extract_thinkpad_candidate(title)
        if fallback and not is_probable_cpu_token(fallback):
            candidate = fallback
            source_conf = 0.55

    result = build_parse_result("title", title, candidate, model_map, base_unmatched_conf=source_conf)

    if result["matched_model"]:
        result["confidence"] = max(result["confidence"], source_conf)
    elif result["cleaned_value"]:
        result["confidence"] = source_conf
    else:
        result["confidence"] = 0.0

    return result

def looks_like_real_lenovo_mpn(value: str) -> bool:
    """
    Real Lenovo machine types / MPN often look like:
      20L5000MUS
      20N2S0AB00
      21AHCTO1WW
    """
    value = normalize_text(value)
    if not value:
        return False

    compact = re.sub(r"[\s\-]", "", value).upper()

    # If it contains explicit model words, do NOT treat as real MPN
    if re.search(r"\b(?:T|X|P|L|E)\d{2,3}S?\b", compact, flags=re.I):
        return False
    if "X1CARBON" in compact or "X1YOGA" in compact:
        return False

    # compact alnum 8-12 chars
    if re.fullmatch(r"[0-9A-Z]{8,12}", compact):
        return True

    # starts with 4 digits then alnum
    if re.fullmatch(r"\d{4}[A-Z0-9]{4,8}", compact):
        return True

    return False

def parse_model_from_raw_mpn(raw_mpn: str, model_map: list[dict]):
    if not raw_mpn:
        return empty_parse_result("raw_mpn", raw_mpn)

    if looks_like_real_lenovo_mpn(raw_mpn):
        return empty_parse_result("raw_mpn", raw_mpn)

    if is_obviously_not_thinkpad(raw_mpn):
        return empty_parse_result("raw_mpn", raw_mpn)

    cleaned = extract_thinkpad_candidate(raw_mpn)
    result = build_parse_result("raw_mpn", raw_mpn, cleaned, model_map, base_unmatched_conf=0.45)

    if result["matched_model"]:
        result["confidence"] = max(result["confidence"], 0.88)
    elif result["cleaned_value"]:
        result["confidence"] = 0.45

    return result

def resolve_final_model(raw_model_result, title_result, raw_mpn_result):
    results = [raw_model_result, title_result, raw_mpn_result]

    # 1) Any canonical match wins
    matched = [r for r in results if r.get("matched_model")]
    if matched:
        best = max(matched, key=lambda r: r["confidence"])
        return {
            "final_model": best["matched_model"],
            "source": best["source"],
            "confidence": best["confidence"],
            "method": "canonical_match",
            "all_results": results,
        }

    # 2) No hard match -> choose closest legit model
    closest = [
        r for r in results
        if r.get("closest_model") and r.get("closest_score", 0) >= 0.70
    ]
    if closest:
        priority = {"raw_model": 3, "title": 2, "raw_mpn": 1}
        best = max(
            closest,
            key=lambda r: (r["closest_score"], priority.get(r["source"], 0))
        )

        return {
            "final_model": best["closest_model"],
            "source": best["source"],
            "confidence": best["closest_score"],
            "method": "closest_match",
            "all_results": results,
        }

    # 3) Fallback to best cleaned raw candidate
    priority = {"raw_model": 3, "title": 2, "raw_mpn": 1}
    cleaned = [r for r in results if r.get("cleaned_value")]
    if cleaned:
        best = max(cleaned, key=lambda r: (priority.get(r["source"], 0), r["confidence"]))
        return {
            "final_model": best["cleaned_value"],
            "source": best["source"],
            "confidence": best["confidence"],
            "method": "best_cleaned_fallback",
            "all_results": results,
        }

    return {
        "final_model": None,
        "source": None,
        "confidence": 0.0,
        "method": "no_result",
        "all_results": results,
    }

def infer_thinkpad_model(raw_model, title, raw_mpn, model_map):
    raw_model_result = parse_model_from_raw_model(raw_model, model_map)
    title_result = parse_model_from_title(title, model_map)
    raw_mpn_result = parse_model_from_raw_mpn(raw_mpn, model_map)

    return resolve_final_model(raw_model_result, title_result, raw_mpn_result)

# db friendly pipeline

def build_model_resolution_payload(listing, model_row, model_map):
    raw_model = model_row.raw_model if model_row else None
    raw_mpn = model_row.raw_mpn if model_row else None
    title = listing.title if listing else None

    raw_model_result = parse_model_from_raw_model(raw_model, model_map)
    title_result = parse_model_from_title(title, model_map)
    raw_mpn_result = parse_model_from_raw_mpn(raw_mpn, model_map)

    final = resolve_final_model(raw_model_result, title_result, raw_mpn_result)

    return {
        "listing_id": listing.id if listing else None,

        "raw_model_candidate": raw_model_result["value"],
        "raw_model_confidence": raw_model_result["confidence"],
        "raw_model_matched_model": raw_model_result["matched_model"],

        "title_candidate": title_result["value"],
        "title_confidence": title_result["confidence"],
        "title_matched_model": title_result["matched_model"],

        "mpn_candidate": raw_mpn_result["value"],
        "mpn_confidence": raw_mpn_result["confidence"],
        "mpn_matched_model": raw_mpn_result["matched_model"],

        "resolved_model_name": final["final_model"],
        "resolved_model_source": final["source"],
        "resolved_model_confidence": final["confidence"],
        "resolved_model_method": final["method"],

        # optional debug
        "debug_all_results": final["all_results"],
    }


def save_parse_result(payload):
    """
    Upsert one Parse row for one listing.
    """
    if not payload or not payload.get("listing_id"):
        return None

    row = db.session.query(Parse).filter_by(listing_id=payload["listing_id"]).first()

    if not row:
        row = Parse(listing_id=payload["listing_id"])
        db.session.add(row)

    row.model_candidate_raw_model = payload.get("raw_model_candidate")
    row.model_candidate_title = payload.get("title_candidate")
    row.model_candidate_mpn = payload.get("mpn_candidate")

    row.model_match_raw_model = payload.get("raw_model_matched_model")
    row.model_match_title = payload.get("title_matched_model")
    row.model_match_mpn = payload.get("mpn_matched_model")

    row.model_confidence_raw_model = payload.get("raw_model_confidence")
    row.model_confidence_title = payload.get("title_confidence")
    row.model_confidence_mpn = payload.get("mpn_confidence")

    row.model_name_resolved = payload.get("resolved_model_name")
    row.model_confidence_resolved = payload.get("resolved_model_confidence")
    row.model_source_resolved = payload.get("resolved_model_source")
    row.model_method_resolved = payload.get("resolved_model_method")

    return row

def backfill_parse_table_new_only(limit=None, commit_every=100):
    """
    Parse listings that do NOT already have a row in parse table.
    Uses Model.raw_model + Model.raw_mpn + Listing.title
    """
    model_map = load_thinkpad_model_map()

    query = (
        db.session.query(Listing, Model)
        .join(Model, Model.listing_id == Listing.id)
        .outerjoin(Parse, Parse.listing_id == Listing.id)
        .filter(Parse.id.is_(None))
        .order_by(Listing.id.asc())
    )

    if limit:
        query = query.limit(limit)

    rows = query.all()
    count = 0

    for listing, model_row in rows:
        payload = build_model_resolution_payload(listing, model_row, model_map)
        save_parse_result(payload)

        count += 1
        if count % commit_every == 0:
            db.session.commit()
            print(f"Committed {count} parse rows...")

    db.session.commit()
    print(f"Done. Inserted {count} new parse rows.")

# gets the final model from Parse table and fills out model.name and canon_model_id
def update_model_from_parse():

    parses = db.session.query(Parse).filter(Parse.model_name_resolved.isnot(None)).all()
    
    for p in parses:
        model_row = db.session.query(Model).filter(Model.listing_id == p.listing_id).first()
        if not model_row:
            continue

        # Map to ThinkPad canonical model if you have a mapping
        canon_model = db.session.query(ThinkPadModel).filter(
            ThinkPadModel.name == p.model_name_resolved
        ).first()

        model_row.name = p.model_name_resolved
        model_row.canon_model_id = canon_model.id if canon_model else None

        db.session.add(model_row)

    db.session.commit()



# helper funtion for testing only
"""def debug_parse_for_listing(listing_id):
    model_map = load_thinkpad_model_map()

    row = (
        db.session.query(Listing, Model)
        .join(Model, Model.listing_id == Listing.id)
        .filter(Listing.id == listing_id)
        .first()
    )

    if not row:
        print(f"Listing {listing_id} not found")
        return None

    listing, model_row = row
    payload = build_model_resolution_payload(listing, model_row, model_map)

    print(f"Listing ID: {payload['listing_id']}")
    print(f"Title: {listing.title}")
    print(f"raw_model -> {payload['raw_model_candidate']} {payload['raw_model_confidence']}")
    print(f"title     -> {payload['title_candidate']} {payload['title_confidence']}")
    print(f"raw_mpn   -> {payload['mpn_candidate']} {payload['mpn_confidence']}")
    print(
        f"FINAL     -> {payload['resolved_model_name']} "
        f"{payload['resolved_model_method']} {payload['resolved_model_confidence']}"
    )

    return payload
"""
# example usage
"""
with app.app_context():
    model_map = load_thinkpad_model_map()

    rows = (
        db.session.query(Listing, Model, Specs)
        .outerjoin(Model, Model.listing_id == Listing.id)
        .outerjoin(Specs, Specs.listing_id == Listing.id)
        .limit(20)
        .all()
    )

    for listing, model_row, specs_row in rows:
        payload = build_model_resolution_payload(listing, model_row, specs_row, model_map)

        print("=" * 80)
        print("Listing ID:", payload["listing_id"])
        print("Title:", listing.title if listing else None)
        print("raw_model ->", payload["raw_model_candidate"], payload["raw_model_confidence"])
        print("title     ->", payload["title_candidate"], payload["title_confidence"])
        print("raw_mpn   ->", payload["mpn_candidate"], payload["mpn_confidence"])
        print("FINAL     ->", payload["resolved_model_name"], payload["resolved_model_method"], payload["resolved_model_confidence"])

"""


"""
Very important bug to avoid in your current codebase

Since you’re doing lots of parsing now:

Don’t do this inside each parser:
db.session.query(ThinkPadModel).all()

That would be a killer performance bug.

Do this once:
with app.app_context():
    model_map = load_thinkpad_model_map()

Then pass model_map into every parse call.

That matters a lot once you process thousands of listings.

"""


