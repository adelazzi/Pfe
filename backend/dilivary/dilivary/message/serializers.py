from rest_framework import serializers
from .models import Message

class MessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = ['iddriver', 'idclient', 'textmessage', 'timestamp']
    
    def create(self, validated_data):
        return Message.objects.create(**validated_data)
    
    def update(self, instance, validated_data):
        instance.iddriver = validated_data.get('iddriver', instance.iddriver)
        instance.idclient = validated_data.get('idclient', instance.idclient)
        instance.textmessage = validated_data.get('textmessage', instance.textmessage)
        instance.timestamp = validated_data.get('timestamp', instance.timestamp)
        instance.save()
        return instance

    def remove(self, instance):
        instance.delete()



class MessagesSerializer(serializers.ModelSerializer):
    class Meta:
        model = Message
        fields = ['id', 'iddriver', 'idclient', 'textmessage', 'timestamp']
