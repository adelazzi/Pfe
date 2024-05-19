
from django.urls import path
from . import views

urlpatterns = [
    path('Lists/', views.list_Messages, name='list_commands'),
    path('Create/', views.create_message, name='create_command'),
    path('getmassage/<int:pkclient>/<int:pkdriver>/', views.get_command, name='get_message'),
]