# TRY TO PARSE ITEM DETAILS FROM THE TITLE AND SHORT DESCRIPTION

import re

def parse_product_details(title, short_description, MODEL, PROCESSOR, MEMORY, STORAGE):
    """
    Parse ThinkPad listing to extract:
    - model_name (prefer longest alphanumeric)
    - CPU
    - CPU frequency
    - RAM
    - Storage
    - Storage type
    """

    # Normalize text
    search_area = (title + " " + short_description).lower()
    search_area = re.sub(r'["/,|.-]', ' ', search_area)

    # Only search after 'thinkpad' if present
    if 'thinkpad' in search_area:
        search_area = search_area.split('thinkpad', 1)[1]

    # ----------------- MODEL -----------------
    matches = []
    for pre_model in MODEL:
        pattern = (
            rf'{re.escape(pre_model.lower())}(?:\s|$)'
            if any(c.isalpha() for c in pre_model)
            else rf'(?<!\d){re.escape(pre_model.lower())}(?:\s|$)'
        )
        if re.search(pattern, search_area):
            matches.append(pre_model)

    model = "Unknown"
    if matches:
        letter_models = [m for m in matches if any(c.isalpha() for c in m)]
        model = max(letter_models, key=len) if letter_models else max(matches, key=len)

    search_area = re.sub(re.escape(model.lower()), '', search_area, count=1)

    # ----------------- CPU -----------------
    cpu_matches = [c for c in PROCESSOR if re.search(rf'\b{re.escape(c.lower())}\b', search_area)]
    cpu = max(cpu_matches, key=len) if cpu_matches else "Unknown"
    if cpu != "Unknown":
        search_area = re.sub(re.escape(cpu.lower()), '', search_area, count=1)

    # ----------------- CPU Frequency -----------------
    cpu_freq_match = re.search(r'(\d+(\.\d+)?\s?ghz)', search_area)
    cpu_freq = cpu_freq_match.group(1) if cpu_freq_match else ""
    if cpu_freq:
        search_area = re.sub(re.escape(cpu_freq.lower()), '', search_area, count=1)

    # ----------------- RAM -----------------
    ram_matches = [r for r in MEMORY if re.search(rf'\b{re.escape(r.lower())}\b', search_area)]
    ram = max(ram_matches, key=len) if ram_matches else "Unknown"
    if ram != "Unknown":
        search_area = re.sub(re.escape(ram.lower()), '', search_area, count=1)

    # ----------------- STORAGE -----------------
    storage_matches = [s for s in STORAGE if re.search(rf'\b{re.escape(s.lower())}\b', search_area)]
    storage = max(storage_matches, key=len) if storage_matches else "Unknown"

    # ----------------- STORAGE TYPE -----------------
    search_area_lower = search_area.lower()
    if 'nvme' in search_area_lower:
        storage_type = "NVME"
    elif 'ssd' in search_area_lower:
        storage_type = "SSD"
    elif 'hdd' in search_area_lower or 'hard drive' in search_area_lower:
        storage_type = "HDD"
    else:
        storage_type = ""

    return model, cpu, cpu_freq, ram, storage, storage_type


# another title parser
RAM_REGEX = re.compile(r"(\d+)\s*GB\s*RAM", re.I)
SSD_REGEX = re.compile(r"(\d+)\s*GB\s*(SSD|NVME)", re.I)

def extract_specs(text):

    specs = {}

    ram = RAM_REGEX.search(text)
    if ram:
        specs["ram"] = f"{ram.group(1)}GB"

    storage = SSD_REGEX.search(text)
    if storage:
        specs["storage"] = f"{storage.group(1)}GB"

    return specs

# how to use
"""
title = item.get("title", "")

extra_specs = extract_specs(title)

for field, value in extra_specs.items():
    if not getattr(listing, field):
        setattr(listing, field, value)
"""

def normalize_ram(value):

    value = value.upper().replace(" ", "")

    if "MB" in value:
        mb = int(value.replace("MB",""))
        return f"{mb // 1024}GB"

    return value

# how to use
"""
if field == "ram":
    value = normalize_ram(value)
"""