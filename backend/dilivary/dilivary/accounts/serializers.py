#serializer

from datetime import timezone
from rest_framework import serializers
from .models import CustomUser

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['id','username', 'email', 'password','last_seen', 'age', 'phone_number', 'id_number','id_driving_license','user_type']
        extra_kwargs = {'password': {'required': False}}

    def create(self, validated_data):
        user = CustomUser.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password'],
            age=validated_data.get('age'),
            phone_number=validated_data.get('phone_number'),
            id_number=validated_data.get('id_number'),
            id_driving_license = validated_data.get('id_driving_license'),
            user_type=validated_data.get('user_type'),
            
        )
        return user

    
    def update(self, instance, validated_data):
        # Update only if value is not None
        if validated_data.get('username') is not None:
            instance.username = validated_data['username']
        if validated_data.get('email') is not None:
            instance.email = validated_data['email']
        if validated_data.get('age') is not None:
            instance.age = validated_data['age']
        if validated_data.get('phone_number') is not None:
            instance.phone_number = validated_data['phone_number']
        if validated_data.get('id_number') is not None:
            instance.id_number = validated_data['id_number']
        if validated_data.get('id_driving_license') is not None:
            instance.id_driving_license = validated_data['id_driving_license']

        # Check if password is provided and update it
        password = validated_data.pop('password', None)
        if password:
            instance.set_password(password)

        instance.save()
        return instance


    def remove(self, instance):
        instance.delete()


