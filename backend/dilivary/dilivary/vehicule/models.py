
from django.db import models

# Create your models here.
from django.db import models

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
    id_driving_license = models.IntegerField(unique=True)
    model = models.CharField(max_length=50)

    def __str__(self):
        return f'{self.model} ({self.matricule})'
