# utils.py

from geopy.geocoders import Nominatim

def get_address_from_coordinates(latitude, longitude):
    """
    Convert latitude and longitude coordinates to a human-readable address.
    """
    geolocator = Nominatim(user_agent="your_app_name_here")
    location = f"{latitude}, {longitude}"
    try:
        location_data = geolocator.reverse(location)
        return location_data.address
    except Exception as e:
        print(f"Error: {e}")
        return None
