from django.db import models
import jsonfield

# Create your models here.


class DataModel(models.Model):
    created_at = models.DateTimeField(auto_now=True)
    data = jsonfield.JSONField()
    year = models.DateField()
