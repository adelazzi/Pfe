from django.db import models

class Message(models.Model):
    id = models.IntegerField(primary_key=True)
    iddriver = models.IntegerField(blank=True,null=True)
    idclient = models.IntegerField(blank=True,null=True)
    textmessage = models.TextField(max_length=100,default="")
    timestamp = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"Command {self.id}"  # Using pk instead of idd
