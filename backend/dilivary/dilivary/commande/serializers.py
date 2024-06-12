from rest_framework import serializers
from .models import Command

class CommandSerializer(serializers.ModelSerializer):
    class Meta:
        model = Command
        fields = ['iddriver','idclient', 'desqreption','fromlat', 'fromlon', 'tolat', 'tolon', 'size', 'weight', 'completed']
    
    def create(self, validated_data):
        return Command.objects.create(**validated_data)
    
    def update(self, instance, validated_data):
        instance.iddriver = validated_data['iddriver']
        if 'idclient' in validated_data and validated_data['idclient'] is not None:
            instance.idclient = validated_data['idclient']
        if 'fromuser' in validated_data and validated_data['fromuser'] is not None:
            instance.fromuser = validated_data['fromuser']
        if 'touser' in validated_data and validated_data['touser'] is not None:
            instance.touser = validated_data['touser']
        if 'size' in validated_data and validated_data['size'] is not None:
            instance.size = validated_data['size']
        if 'weight' in validated_data and validated_data['weight'] is not None:
            instance.weight = validated_data['weight']

        instance.save()
        return instance


    def remove(self, instance):
        instance.delete()



class CommandsSerializer(serializers.ModelSerializer):
    class Meta:
        model = Command
        fields = ['id', 'iddriver','idclient','desqreption' ,'fromlat', 'fromlon', 'tolat', 'tolon', 'size', 'weight', 'completed']
    
    
    


class CommandlocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Command
        fields = ['fromlat', 'fromlon', 'tolat', 'tolon']
   