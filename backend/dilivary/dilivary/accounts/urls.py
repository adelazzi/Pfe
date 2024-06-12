from django.urls import path
from .views import *

urlpatterns = [
    path('register/', register_user, name='register'),
    path('get/<int:id>/', get_users, name='get'),
    path('login/', user_login, name='login'),
    path('logout/', user_logout, name='logout'),
    path('update/', user_update, name='update'),
    path('remove/', user_remove, name='remove'),
    path('users/', get_all_users, name='get_all_users'),
    path('<int:pk>/delete/', delete_user_withid, name='delete_user_withid'),
    path('online_users/', get_online_users, name='get_online_users'),
    path('check_user_online/<int:user_id>/', check_user_online, name='check_user_online'),


]