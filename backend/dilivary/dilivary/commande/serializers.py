from rest_framework import serializers
from .models import Command

class CommandSerializer(serializers.ModelSerializer):
    class Meta:
        model = Command
        fields = ['iddriver','idclient', 'fromlat', 'fromlon', 'tolat', 'tolon', 'size', 'weight', 'completed']
    
    def create(self, validated_data):
        return Command.objects.create(**validated_data)
    
    def update(self, instance, validated_data):
        instance.iddriver = validated_data.get('iddriver', instance.iddriver)
        instance.iddriver = validated_data.get('idclient', instance.idclient)
        instance.fromuser = validated_data.get('fromuser', instance.fromuser)
        instance.touser = validated_data.get('touser', instance.touser)
        instance.size = validated_data.get('size', instance.size)
        instance.weight = validated_data.get('weight', instance.weight)
        instance.save()
        return instance

    def remove(self, instance):
        instance.delete()



class CommandsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Command
        fields = ['id', 'iddriver','idclient', 'fromlat', 'fromlon', 'tolat', 'tolon', 'size', 'weight', 'completed']
    
    
    


class CommandlocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Command
        fields = ['fromlat', 'fromlon', 'tolat', 'tolon']
   