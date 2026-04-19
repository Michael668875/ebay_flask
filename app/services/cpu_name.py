# THIS IS A HELPER FILE TO POPULATE THE CPU_NUM COLUMN IN THE CPU TABLE OF THE DB

import re
from app.models import CPU
from app import create_app, db

app = create_app()


def extract_cpu_num(cpu_name):
    if not cpu_name:
        return None

    cpu_name = cpu_name.strip().upper()

    patterns = [
        r"\b(\d{3,5}[A-Z]{1,2}\d?)\b",   # 10210U, 2630QM, 480M
        r"\b([A-Z]\d{3,5}[A-Z]?)\b",     # P7370, T9600, N450
        r"\b([A-Z]\d-\d{3,5}[A-Z]?)\b",  # A4-3300M, E2-1800
    ]

    for pattern in patterns:
        match = re.search(pattern, cpu_name)
        if match:
            return match.group(1)

    return None


def populate_cpu_nums():
    specs_list = CPU.query.all()

    for spec in specs_list:
        if spec.name:
            extracted = extract_cpu_num(spec.name)
            print(spec.name, "->", extracted)

            spec.cpu_num = extracted

    db.session.commit()

if __name__ == "__main__":
    with app.app_context():
        populate_cpu_nums()