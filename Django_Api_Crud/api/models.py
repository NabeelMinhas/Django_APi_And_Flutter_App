from django.db import models

# Create your models here.

class student(models.Model):
    name=models.TextField(max_length=200)
    rollnumber=models.TextField(max_length=100)
    message=models.TextField()


    def __str__(self):
        return self.name

    
    