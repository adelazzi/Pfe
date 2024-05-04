from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status



# Create your views here.
# views.py
from rest_framework import generics
from .models import UserLocation
from .serializers import UserLocationSerializer
from rest_framework.response import Response

@api_view(['GET'])
def get_location(request, ids):
    """
    Retrieve a single vehicle by matricule.
    """
    try:
        userlocation = UserLocation.objects.get(ids=ids)
    except UserLocation.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = UserLocationSerializer(userlocation)
    return Response(serializer.data)

@api_view(['GET'])
def all_location(request):

    
    userLocation = UserLocation.objects.all()
    serializer = UserLocationSerializer(userLocation, many=True)
    return Response(serializer.data)


@api_view(['POST'])
def create_location(request):
    serializer = UserLocationSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def update_location(request, ids):
    try:
        userlocation = UserLocation.objects.get(ids=ids)
    except UserLocation.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = UserLocationSerializer(userlocation, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)






#IA



