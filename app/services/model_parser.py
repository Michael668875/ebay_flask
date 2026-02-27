import re

    
def is_storage_match(text, model):
    pattern = rf"\b{model}gb\b"
    return re.search(pattern, text) is not None


def parse_product_details(title, short_description, MODEL, PROCESSOR, MEMORY, STORAGE):
    title_lower = f"{title} {short_description}".lower()

    # Model
    matches = []

    search_area = title_lower

    # If ThinkPad exists, only search after it
    if "thinkpad" in title_lower:
        search_area = title_lower.split("thinkpad", 1)[1]

    for pre_model in MODEL:
        if (
            pre_model.lower() in search_area
            and not is_storage_match(title_lower, pre_model)
        ):
            matches.append(pre_model)

    model = "Unknown"

    if matches:
        # Prefer models containing letters (avoid pure numeric like 320)
        letter_models = [m for m in matches if any(c.isalpha() for c in m)]
        if letter_models:
            # choose the longest match (X131e > X1)
            model = max(letter_models, key=len)
        else:
            # fallback to numeric matches if nothing else
            model = max(matches, key=len)

    # CPU
    cpu = next((c for c in PROCESSOR if c.lower() in title_lower), "Unknown")

    # Detect CPU frequency (e.g., 2.6GHz, 2.60 GHz)
    cpu_freq_match = re.search(r'(\d+(\.\d+)?\s?ghz)', title_lower)
    cpu_freq = cpu_freq_match.group(1) if cpu_freq_match else ""

    # RAM
    ram = next((r for r in MEMORY if r.lower() in title_lower), "Unknown")

    # Storage
    storage = next((s for s in STORAGE if s.lower().replace(" ", "") in title_lower.replace(" ", "")), "Unknown")

    # Detect storage type
    if "nvme" in title_lower:
        storage_type = "NVME"
    elif "ssd" in title_lower:
        storage_type = "SSD"
    elif "hdd" in title_lower or "hard drive" in title_lower:
        storage_type = "HDD"
    else:
        storage_type = ""

    return model, cpu, cpu_freq, ram, storage, storage_type







