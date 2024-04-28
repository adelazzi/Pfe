from django.urls import path
from .views import *

urlpatterns = [
    path('register/', register_user, name='register'),
    path('login/', user_login, name='login'),
    path('logout/', user_logout, name='logout'),
    path('update/', user_update, name='update'),
    path('remove/', user_remove, name='remove'),
]