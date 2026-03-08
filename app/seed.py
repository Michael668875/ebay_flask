# THIS FILE IS TO RE INSERT MODEL NUMBERS, CPUS, STORAGE, MARKETS AS REFERENCE TABLES IN THE DB

from app.extensions import db
from app.models import CPU, ThinkPadModel, RAM, Storage, Marketplace
import json
from app import create_app

app = create_app()


def seed_cpus():
    with open("app/seed_data/cpu_backup.json") as f:
        data = json.load(f)

    for row in data:
        if not CPU.query.filter_by(name=row["name"]).first():
            db.session.add(CPU(name=row["name"]))

    db.session.commit()

def seed_models():
    with open("app/seed_data/model_backup.json") as f:
        data = json.load(f)

    for row in data:
        if not ThinkPadModel.query.filter_by(name=row["name"]).first():
            db.session.add(ThinkPadModel(name=row["name"]))

    db.session.commit()

def seed_ram():
    with open("app/seed_data/ram_backup.json") as f:
        data = json.load(f)

    for row in data:
        if not RAM.query.filter_by(size=row["size"]).first():
            db.session.add(RAM(size=row["size"]))

    db.session.commit()

def seed_storage():
    with open("app/seed_data/storage_backup.json") as f:
        data = json.load(f)

    for row in data:
        if not Storage.query.filter_by(size=row["size"]).first():
            db.session.add(Storage(size=row["size"]))

    db.session.commit()

def seed_markets():
    with open("app/seed_data/market_backup.json") as f:
        data = json.load(f)

    for row in data:
        if not Marketplace.query.filter_by(marketplace_id=row["marketplace_id"]).first():
            db.session.add(Marketplace(country_code=row["country_code"], marketplace_id=row["marketplace_id"], enabled=row["enabled"]))

    db.session.commit()




with app.app_context():
    seed_cpus()
    seed_models()
    seed_ram()
    seed_storage()
    seed_markets()