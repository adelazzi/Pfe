from rest_framework import serializers
from .models import Vehicle

class VehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vehicle
        fields = ['matricule', 'color', 'type', 'max_weight', 'max_size', 'id_driving_license', 'model', 'photo']
        extra_kwargs = {
            'photo': {'required': False}  # Mark 'photo' as not required
        }

    def create(self, validated_data):
        photo = validated_data.get('photo', None)
        vehicle = Vehicle.objects.create(
            matricule=validated_data['matricule'],
            color=validated_data['color'],
            type=validated_data['type'],
            max_weight=validated_data['max_weight'],
            max_size=validated_data['max_size'],
            id_driving_license=validated_data['id_driving_license'],
            model=validated_data['model'],
            photo=photo,
        )
        return vehicle
    
    def update(self, instance, validated_data):
        for attr, value in validated_data.items():
            if value is not None:
                setattr(instance, attr, value)
        instance.save()
        return instance
