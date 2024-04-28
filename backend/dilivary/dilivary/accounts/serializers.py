from rest_framework import serializers
from .models import CustomUser

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = CustomUser
        fields = ['username', 'email', 'password', 'age', 'phone_number', 'id_number']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = CustomUser.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password'],
            age=validated_data.get('age'),
            phone_number=validated_data.get('phone_number'),
            id_number=validated_data.get('id_number')
        )
        return user

    def update(self, instance, validated_data):
        instance.username = validated_data.get('username', instance.username)
        instance.email = validated_data.get('email', instance.email)
        instance.age = validated_data.get('age', instance.age)
        instance.phone_number = validated_data.get('phone_number', instance.phone_number)
        instance.id_number = validated_data.get('id_number', instance.id_number)
        
        # Check if password is provided and update it
        password = validated_data.get('password')
        if password:
            instance.set_password(password)
        
        instance.save()
        return instance

    def remove(self, instance):
        instance.delete()
