
from django.db import models
import os

# Create your models here.

def vehicle_photo_path(instance, filename):
    # Get the file's extension
    ext = filename.split('.')[-1]
    # Rename the file to the vehicle's matricule value
    filename = f'{instance.matricule}.{ext}'
    # Return the new filename
    return os.path.join('image/', filename)




class Vehicle(models.Model):
    CAR = 'CAR'
    VAN = 'VAN'
    BICYCLE = 'BICYCLE'
    MOTORCYCLE = 'MOTORCYCLE'

    VEHICLE_TYPES = [
        (CAR, 'Car'),
        (VAN, 'Van'),
        (BICYCLE, 'Bicycle'),
        (MOTORCYCLE, 'Motorcycle'),
    ]
    
    LARGE = 'Large'
    MEDIUM = 'Medium'
    SMALL = 'Small'
    VERY_LARGE = 'Very Large'

    MAX_SIZE_CHOICES = [
        (LARGE, 'Large'),
        (MEDIUM, 'Medium'),
        (SMALL, 'Small'),
        (VERY_LARGE, 'Very Large'),
    ]

    matricule = models.IntegerField(primary_key=True)
    color = models.CharField(max_length=50)
    type = models.CharField(max_length=20, choices=VEHICLE_TYPES)
    max_weight = models.IntegerField()
    max_size = models.CharField(max_length=20, choices=MAX_SIZE_CHOICES)
    id_driving_license = models.IntegerField()
    model = models.CharField(max_length=50)
    photo = models.ImageField(upload_to=vehicle_photo_path, blank=True, null=True)  # New field

    def __str__(self):
        return f'{self.model} ({self.matricule})'
