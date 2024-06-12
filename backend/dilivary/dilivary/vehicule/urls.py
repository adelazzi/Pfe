# urls.py

from django.urls import path
from . import views

urlpatterns = [
    path('', views.vehicle_list, name='vehicle_list'),
    path('<int:matricule>/', views.vehicle_detail, name='vehicle_detail'),
    path('license/<int:id_driving_license>/', views.vehicle_detail_license, name='vehicle_detail_license'),
    path('create/', views.create_vehicle, name='create_vehicle'),
    path('<int:matricule>/update/', views.update_vehicle, name='update_vehicle'),
    path('<int:matricule>/delete/', views.delete_vehicle, name='delete_vehicle'),
    path('lic/<int:id_driving_license>/update/', views.update_vehicle_lic, name='update_vehicle_lic'),
    path('lic/<int:id_driving_license>/delete/', views.delete_vehicle_lic, name='delete_vehicle_lic'),
    path('lic/<int:id_driving_license>/', views.vehicles_by_id_driving_license),

]
