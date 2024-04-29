from rest_framework import serializers
from .models import Vehicle

class VehicleSerializer(serializers.ModelSerializer):
    class Meta:
        model = Vehicle
        fields = ['matricule', 'color', 'type', 'max_weight', 'max_size', 'id_driving_license', 'model']

    def create(self, validated_data):
        vehicle = Vehicle.objects.create(
            matricule=validated_data['matricule'],
            color=validated_data['color'],
            type=validated_data['type'],
            max_weight=validated_data['max_weight'],
            max_size=validated_data['max_size'],
            id_driving_license=validated_data['id_driving_license'],
            model=validated_data['model']
        )
        return vehicle

    def update(self, instance, validated_data):
        instance.color = validated_data.get('color', instance.color)
        instance.type = validated_data.get('type', instance.type)
        instance.max_weight = validated_data.get('max_weight', instance.max_weight)
        instance.max_size = validated_data.get('max_size', instance.max_size)
        instance.id_driving_license = validated_data.get('id_driving_license', instance.id_driving_license)
        instance.model = validated_data.get('model', instance.model)
        instance.save()
        return instance

    def remove(self, instance):
        instance.delete()

