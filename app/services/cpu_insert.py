from app import db
from app.models import CPU

from app import create_app

app = create_app()



def load_cpus(filepath="app/services/cpu_list.txt"):
    with open(filepath, "r", encoding="utf-8") as f:
        lines = [line.strip() for line in f if line.strip()]

    inserted = 0

    for name in lines:
        exists = CPU.query.filter_by(name=name).first()
        if exists:
            continue

        cpu = CPU(name=name)
        db.session.add(cpu)
        inserted += 1

    db.session.commit()
    print(f"Inserted {inserted} CPUs")

if __name__ == "__main__":
    with app.app_context():    
        load_cpus()