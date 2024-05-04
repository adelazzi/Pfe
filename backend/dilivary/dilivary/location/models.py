from django.db import models

# Create your models here.


class UserLocation(models.Model):
    ids = models.IntegerField( unique=True, blank=True, null=True)
    latitude = models.FloatField()
    longitude = models.FloatField()
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f'{self.ids} - {self.latitude}, {self.longitude}'
