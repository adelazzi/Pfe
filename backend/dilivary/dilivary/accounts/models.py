from django.db import models

# Create your models here.
from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    CLIENT = 'Client'
    DRIVER = 'Driver'

    USER_TYPES = [
        (CLIENT, 'Client'),
        (DRIVER, 'Driver'),
    ]    
    
    
    email = models.EmailField(unique=True,blank=True, null=True)
    age = models.PositiveIntegerField(blank=True, null=True)
    phone_number = models.CharField(max_length=15, unique=True, blank=True, null=True)
    id_number = models.CharField(max_length=9, unique=True, blank=True, null=True)
    id_driving_license = models.IntegerField(unique=True, blank=True, null=True)
    user_type = models.CharField(max_length=10, choices=USER_TYPES, default=CLIENT)
    last_seen = models.DateTimeField(null=True, blank=True)  # Add this field

    def save(self, *args, **kwargs):
        if self.user_type == self.CLIENT:
            self.id_driving_license = None
        super().save(*args, **kwargs)

    # Add custom fields here, if needed

    def __str__(self):
        return self.username