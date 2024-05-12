from django.urls import path
from . import views

urlpatterns = [
    path('Lists/', views.list_commands, name='list_commands'),
    path('Create/', views.create_command, name='create_command'),
    path('<int:pk>/get/', views.get_command, name='get_command'),
    path('<int:pk>/update/', views.update_command, name='update_command'),
    path('<int:pk>/delete/', views.delete_command, name='delete_command'),
    path('<int:pk>/complete/', views.complete_command, name='complete_command'),
]
