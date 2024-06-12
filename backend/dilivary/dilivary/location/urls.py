# urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('create_location/', views.create_location, name='create_location'),
    path('user-locations/<int:ids>/', views.get_location, name='user-location-detail'),
    path('all-locations/', views.all_location, name='all_location'),
    path('update-locations/<int:ids>/', views.update_location, name='update-locations'),
]
