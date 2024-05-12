from django.db import models

class Command(models.Model):
    id = models.IntegerField(primary_key=True)
    iddriver = models.IntegerField()
    fromlat = models.FloatField()
    fromlon = models.FloatField() 
    tolat = models.FloatField()
    tolon = models.FloatField()
    size = models.CharField(max_length=100)  
    weight = models.FloatField() 
    completed = models.BooleanField(default=False)
    
    def __str__(self):
        return f"Command {self.id}"  # Using pk instead of idd
