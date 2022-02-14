# from rest_framework import serializers
# from . models import student

from rest_framework.serializers import ModelSerializer
from .models import student

class studentSerilizer(ModelSerializer):
    class Meta:
        model =student
        fields= '__all__'
    # model = student   