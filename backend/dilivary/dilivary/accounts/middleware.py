# your_app_name/middleware.py
from django.utils.deprecation import MiddlewareMixin
from django.utils import timezone

class UpdateLastSeenMiddleware(MiddlewareMixin):
    def process_view(self, request, view_func, view_args, view_kwargs):
        if request.user.is_authenticated:
            request.user.last_seen = timezone.now()
            request.user.save()
