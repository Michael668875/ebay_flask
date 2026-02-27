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
    title_lower = (title + " " + short_description).lower()
    search_area = re.sub(r'["/,|.-]', ' ', title_lower)

    # Only search after 'thinkpad' if present
    if 'thinkpad' in search_area:
        search_area = search_area.split('thinkpad', 1)[1]

    matches = []
    for pre_model in MODEL:
        # match model followed by space, punctuation, or end-of-string
        # numeric-only models must be followed by space or end-of-string
        # alphanumeric models can match normally
        if any(c.isalpha() for c in pre_model):
            pattern = rf'{re.escape(pre_model.lower())}(?:\s|$)'
        else:
            # numeric-only model: only match if followed by space/end or preceded by non-digit
            pattern = rf'(?<!\d){re.escape(pre_model.lower())}(?:\s|$)'

        if re.search(pattern, search_area):
            matches.append(pre_model)

    # Determine model: prefer longest alphanumeric, fallback to numeric if necessary
    model = "Unknown"
    if matches:
        letter_models = [m for m in matches if any(c.isalpha() for c in m)]
        if letter_models:
            model = max(letter_models, key=len)  # longest alphanumeric
        else:
            model = max(matches, key=len)  # fallback numeric-only

    # CPU
    cpu = next(
        (c for c in PROCESSOR if re.search(rf'\b{re.escape(c.lower())}\b', search_area)),
        "Unknown"
    )

    # CPU frequency
    cpu_freq_match = re.search(r'(\d+(\.\d+)?\s?ghz)', search_area)
    cpu_freq = cpu_freq_match.group(1) if cpu_freq_match else ""

    # RAM
    ram = next(
        (r for r in MEMORY if re.search(rf'\b{re.escape(r.lower())}\b', search_area)),
        "Unknown"
    )

    # Storage
    storage = next(
        (s for s in STORAGE if re.search(rf'\b{re.escape(s.lower().replace(" ", ""))}\b', search_area.replace(" ", ""))),
        "Unknown"
    )

    # Storage type
    if 'nvme' in search_area:
        storage_type = "NVME"
    elif 'ssd' in search_area:
        storage_type = "SSD"
    elif 'hdd' in search_area or 'hard drive' in search_area:
        storage_type = "HDD"
    else:
        storage_type = ""

    return model, cpu, cpu_freq, ram, storage, storage_type