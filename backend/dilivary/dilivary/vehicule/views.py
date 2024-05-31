# views.py

from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import Vehicle
from .serializers import VehicleSerializer
from rest_framework.decorators import api_view, parser_classes  # Add this import
from rest_framework.parsers import MultiPartParser, FormParser

@api_view(['GET'])
def vehicle_list(request):
    """
    List all vehicles.
    """
    vehicles = Vehicle.objects.all()
    serializer = VehicleSerializer(vehicles, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def vehicle_detail(request, matricule):
    """
    Retrieve a single vehicle by matricule.
    """
    try:
        vehicle = Vehicle.objects.get(matricule=matricule)
    except Vehicle.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = VehicleSerializer(vehicle)
    return Response(serializer.data)

@api_view(['GET'])
def vehicle_detail_license(request, id_driving_license):
    """
    Retrieve a single vehicle by matricule.
    """
    try:
        vehicle = Vehicle.objects.get(id_driving_license=id_driving_license)
    except Vehicle.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = VehicleSerializer(vehicle)
    return Response(serializer.data)


@api_view(['POST'])
@parser_classes([MultiPartParser, FormParser])
def create_vehicle(request):
    serializer = VehicleSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['PUT'])
def update_vehicle(request, matricule):
    """
    Update an existing vehicle.
    """
    try:
        vehicle = Vehicle.objects.get(matricule=matricule)
    except Vehicle.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = VehicleSerializer(vehicle, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE'])
def delete_vehicle(request, matricule):
    """
    Delete a vehicle.
    """
    try:
        vehicle = Vehicle.objects.get(matricule=matricule)
    except Vehicle.DoesNotExist:
        return Response({"message": "Vehicle not found"}, status=status.HTTP_404_NOT_FOUND)

    vehicle.delete()
    return Response({"message": "Vehicle deleted successfully"}, status=status.HTTP_204_NO_CONTENT)

@api_view(['PUT'])
def update_vehicle_lic(request, id_driving_license):
    """
    Update an existing vehicle.
    """
    try:
        vehicle = Vehicle.objects.get(id_driving_license=id_driving_license)
    except Vehicle.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = VehicleSerializer(vehicle, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['DELETE'])
def delete_vehicle_lic(request, id_driving_license):
    """
    Delete a vehicle.
    """
    try:
        vehicle = Vehicle.objects.get(id_driving_license=id_driving_license)
    except Vehicle.DoesNotExist:
        return Response(status=status.HTTP_404_NOT_FOUND)

    vehicle.delete()
    return Response(status=status.HTTP_204_NO_CONTENT)


from rest_framework.decorators import api_view
from rest_framework.response import Response
# id_driving_license from user 
@api_view(['GET'])
def vehicles_by_id_driving_license(request, id_driving_license):
    try:
        vehicles = Vehicle.objects.filter(id_driving_license=id_driving_license)
        serializer = VehicleSerializer(vehicles, many=True)
        return Response(serializer.data)
    except Vehicle.DoesNotExist:
        return Response({"message": "No vehicles found for the given id_driving_license"}, status=404)