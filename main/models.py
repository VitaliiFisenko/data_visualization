from django.db import models


class DataModel(models.Model):
    created_at = models.DateTimeField(auto_now=True)
    data = models.TextField()
    year = models.DateField()
