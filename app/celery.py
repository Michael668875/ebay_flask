from celery import Celery
import os
from celery.schedules import crontab

# read env vars for Redis URL or fallback to localhost
REDIS_URL = os.getenv("REDIS_URL", "redis://localhost:6379/0")

celery = Celery(
    "ebay_tasks",
    broker=REDIS_URL,
    backend=REDIS_URL
)

# optional: use Flask app context for tasks
celery.conf.update(
    task_serializer="json",
    accept_content=["json"],
    result_serializer="json",
    timezone="Australia/Melbourne",
    enable_utc=True,
)

#schedule the task
celery.conf.beat_schedule = {
    "sync-ebay-every-hour": {
        "task": "app.tasks.sync_ebay",
        "schedule": crontab(minute=0, hour="*"),  # every hour
    },
}