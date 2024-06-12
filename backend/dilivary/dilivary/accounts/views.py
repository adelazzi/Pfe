from django.shortcuts import render

# Create your views here.



from rest_framework import status
from rest_framework.response import Response
from rest_framework.decorators import api_view
from .serializers import UserSerializer

@api_view(['POST'])
def register_user(request):
    if request.method == 'POST':
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth import authenticate
from django.core.exceptions import ObjectDoesNotExist
from rest_framework.authtoken.models import Token
from .models import CustomUser  # Adjust the import based on your actual models

@api_view(['POST'])
def user_login(request):
    username = request.data.get('username')
    password = request.data.get('password')

    user = None
    if '@' in username:
        try:
            user = CustomUser.objects.get(email=username)
            # Verify the password for the user found by email
            if not user.check_password(password):
                return Response({'error': 'Erreur password'}, status=status.HTTP_401_UNAUTHORIZED)
        except ObjectDoesNotExist:
            return Response({'error': 'User does not exist'}, status=status.HTTP_404_NOT_FOUND)
    else:
        user = authenticate(username=username, password=password)

    if user:
        token, _ = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user_type': user.user_type,
            'id': user.id
        }, status=status.HTTP_200_OK)

    return Response({'error': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)


from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework import status

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def user_update(request):
    """
    Update user information.
    """
    user = request.user
    if not user.is_authenticated:
        return Response({'error': 'User is not authenticated'}, status=status.HTTP_401_UNAUTHORIZED)
    
    serializer = UserSerializer(user, data=request.data, partial=True)  # Allow partial updates
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)




@api_view(['POST'])
def user_remove(request):

    if request.method == 'POST':
        user = request.user
        try:
            user.delete()
            return Response({'message': 'User deleted successfully'}, status=status.HTTP_204_NO_CONTENT)
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)




from rest_framework.authtoken.models import Token
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def user_logout(request):
    if request.method == 'POST':
        try:
            # Delete the user's token to logout
            request.user.auth_token.delete()
            return Response({'message': 'Successfully logged out.'}, status=status.HTTP_200_OK)
        except Exception as e:
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
        
    
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import CustomUser
from .serializers import UserSerializer

@api_view(['GET'])
def get_all_users(request):
    """
    Retrieve all users.
    """
    users = CustomUser.objects.all()
    serializer = UserSerializer(users, many=True)
    return Response(serializer.data)




@api_view(['GET'])
def get_users(request,id):
    """
    Retrieve all users.
    """
    users = CustomUser.objects.get(id =id)
    serializer = UserSerializer(users)
    return Response(serializer.data)









@api_view(['DELETE'])
def delete_user_withid(request, pk):
    """
    Delete a specific command.
    """
    try:
        userselect = CustomUser.objects.get(pk=pk)
    except CustomUser.DoesNotExist:
        return Response("Not existe pk",status=status.HTTP_404_NOT_FOUND)

    userselect.delete()
    return Response("deleted",status=status.HTTP_204_NO_CONTENT)


# your_app_name/views.py
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from django.utils import timezone
from datetime import timedelta
from .models import CustomUser
from .serializers import UserSerializer
from .utils import is_user_online  # Import the utility function

@api_view(['GET'])
def get_online_users(request):
    now = timezone.now()
    five_minutes_ago = now - timedelta(minutes=5)
    online_users = CustomUser.objects.filter(last_seen__gte=five_minutes_ago)
    serializer = UserSerializer(online_users, many=True)
    return Response(serializer.data)

@api_view(['GET'])
def check_user_online(request, user_id):
    try:
        user = CustomUser.objects.get(id=user_id)
    except CustomUser.DoesNotExist:
        return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)

    if is_user_online(user):
        return Response({"status": "online"})
    else:
        return Response({"status": "offline"})
