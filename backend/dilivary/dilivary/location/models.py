from django.db import models
from .utils import get_address_from_coordinates

class UserLocation(models.Model):
    ids = models.IntegerField(unique=True, blank=True, null=True)
    latitude = models.FloatField()
    longitude = models.FloatField()
    geolocation = models.TextField(default="")
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'{self.ids} - {self.latitude}, {self.longitude}'

    def save(self, *args, **kwargs):
        if self.latitude and self.longitude:
            address = get_address_from_coordinates(self.latitude, self.longitude)
            if address:
                self.geolocation = address
        super().save(*args, **kwargs)

