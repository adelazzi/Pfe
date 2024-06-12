# your_app_name/utils.py
from datetime import timedelta
from django.utils import timezone
from .models import CustomUser

def is_user_online(user):
    if user.last_seen:
        now = timezone.now()
        if now - user.last_seen < timedelta(minutes=5):
            return True
    return False
