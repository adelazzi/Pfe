from django.db import models

class Command(models.Model):
    
    LARGE = 'Large'
    MEDIUM = 'Medium'
    SMALL = 'Small'
    VERY_LARGE = 'Very Large'

    SIZE_CHOICES = [
        (LARGE, 'Large'),
        (MEDIUM, 'Medium'),
        (SMALL, 'Small'),
        (VERY_LARGE, 'Very Large'),
    ]
    
    
    id = models.IntegerField(primary_key=True)
    iddriver = models.IntegerField(blank=True,null=True)
    idclient = models.IntegerField(blank=True,null=True)
    desqreption = models.CharField(max_length=100,blank=True,null=True)
    fromlat = models.FloatField()
    fromlon = models.FloatField() 
    tolat = models.FloatField()
    tolon = models.FloatField()
    size = models.CharField(max_length=20, choices=SIZE_CHOICES)  
    weight = models.FloatField() 
    completed = models.BooleanField(default=False)
    
    def __str__(self):
        return f"Command {self.id}"  # Using pk instead of idd
