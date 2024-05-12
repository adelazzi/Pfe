from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Command
from .serializers import *
@api_view(['GET'])
def list_commands(request):
    """
    List all commands.
    """
    commands = Command.objects.all()
    serializer = CommandsSerializer(commands, many=True)
    return Response(serializer.data)

@api_view(['POST'])
def create_command(request):
    """
    Create a new command.
    """
    serializer = CommandSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
def get_command(request, pk):
    """
    Retrieve a specific command.
    """
    try:
        command = Command.objects.get(pk=pk)
    except Command.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = CommandsSerializer(command)
    return Response(serializer.data)

@api_view(['PUT'])
def update_command(request, pk):
    """
    Update a specific command.
    """
    try:
        command = Command.objects.get(pk=pk)
    except Command.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = CommandSerializer(command, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE'])
def delete_command(request, pk):
    """
    Delete a specific command.
    """
    try:
        command = Command.objects.get(pk=pk)
    except Command.DoesNotExist:
        return Response("Not existe pk",status=status.HTTP_404_NOT_FOUND)

    command.delete()
    return Response("deleted",status=status.HTTP_204_NO_CONTENT)

@api_view(['POST'])
def complete_command(request, pk):
    """
    Complete a specific command.
    """
    try:
        command = Command.objects.get(pk=pk)
    except Command.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    # Perform completion logic here
    command.completed = True
    command.save()

    return Response( "Completed",status=status.HTTP_200_OK)

@api_view(['GET'])
def get_location(request, pk):
    """
    Retrieve a specific command.
    """
    try:
        command = Command.objects.get(pk=pk)
    except Command.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = CommandlocationSerializer(command)
    return Response(serializer.data)
