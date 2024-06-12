from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Message
from .serializers import *
@api_view(['GET'])
def list_Messages(request):
    """
    List all Messageds.
    """
    messages = Message.objects.all()
    serializer = MessagesSerializer(messages, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def create_message(request):
    """
    Create a new command.
    """
    serializer = MessageSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)



@api_view(['GET'])
def get_command(request, fromuser , touser):
    """
    Retrieve a specific command.
    """
    try:
        messages = Message.objects.filter(fromuser=fromuser, touser=touser).order_by('timestamp')
    except Message.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = MessagesSerializer(messages, many=True)
    return Response(serializer.data)
