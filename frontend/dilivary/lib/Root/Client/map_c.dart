import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart'; // Import InAppWebView


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Options'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: InAppWebView(
          initialData: InAppWebViewInitialData(
              data: """
             <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE-brave">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <title>Geolocation</title>
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.8.0/dist/leaflet.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@latest/dist/leaflet-routing-machine.css" />
    <link rel="stylesheet" href="https://unpkg.com/leaflet-control-geocoder@1.13.0/dist/Control.Geocoder.css" />

    <style>
        body {
            margin: 0;
            padding: 0;
        }

        .popup-content {
            text-align: center;
        }

        .route-summary {
            background-color: rgba(255, 140, 0, 0.5);
            padding: 5px;
            border-radius: 5px;
        }
        
        /* Style for the search bar */
        #search-container {
            position: absolute;
            top: 3%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 900;
            background-color: white;
            padding: 2px 4px;
            border-radius: 2.5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
        }

        /* Style for the route and hide buttons */
        #route-buttons {
            position: absolute;
            top: 10%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1000;
            background-color: white;
            padding: 5px 5px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: none;
        }

        /* Style for buttons next to the search bar */
        #search-container button {
            margin-left: 3px;
        }

        /* Set map size */
        #map {
            width: 1200px;
            height: 600px;
        }
        
        /* Style for Hide Points button */
        #hide-points-button {
            margin-left: 5px; /* Adjust this value as needed */
        }
        
        /* Style for Hide Route button */
        #hide-route-button {
            margin-left: 5px; /* Adjust this value as needed */
        }
    </style>

</head>

<body>
    <div id="map"></div>
    <!-- Search container -->
    <div id="search-container">
        <input type="text" id="search-input" placeholder="Enter latitude,longitude or place name">
        <button onclick="searchLocation()">Search</button>
        <button onclick="getCurrentLocation()" style="width:130px;">Current Location</button>
    </div>
    <!-- Route and hide buttons -->
    <div id="route-buttons">
        <button id="hide-route-button" onclick="hideRoute()" style="background-color:red;">Hide Route</button>
        <button id="hide-points-button" onclick="hidePoints()" style="background-color:green;">Hide Points</button>
    </div>
    
    <script src="https://unpkg.com/leaflet@1.8.0/dist/leaflet.js"></script>
    <script src="https://unpkg.com/leaflet-routing-machine@latest/dist/leaflet-routing-machine.js"></script>
    <script src="https://unpkg.com/leaflet-control-geocoder@1.13.0/dist/Control.Geocoder.js"></script>

    <script>
        var map = L.map('map').setView([36.7362, 3.1830], 11);
        mapLink = "<a href='http://openstreetmap.org'>OpenStreetMap</a>";
        L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
            attribution: 'Leaflet &copy; ' + mapLink + ', contribution',
            maxZoom: 18
        }).addTo(map);

        var markers = {}; // Object to store markers with unique identifiers
        var routingControl = null;
        var firstPoint = null;
        var secondPoint = null;

        map.on('click', function (e) {
            console.log(e)
            if (firstPoint === null) {
                firstPoint = e.latlng;
                addMarker('firstPoint', firstPoint);
            } else if (secondPoint === null) {
                secondPoint = e.latlng;
                addMarker('secondPoint', secondPoint);
                showRouteConfirmation();
            }
        });

        // Function to add a marker with a unique identifier
        function addMarker(id, latlng) {
            markers[id] = L.marker(latlng).addTo(map);
            if (Object.keys(markers).length > 1) {
                document.getElementById('hide-route-button').style.display = 'block';
                document.getElementById('hide-points-button').style.display = 'block';
            }
        }

        // Function to search location
        function searchLocation() {
            var searchText = document.getElementById('search-input').value;
            var geocoder = L.Control.Geocoder.nominatim();
            geocoder.geocode(searchText, function(results) {
                if (results && results.length > 0) {
                    var latLng = [results[0].center.lat, results[0].center.lng];
                    map.setView(latLng, 13);
                } else {
                    alert('Location not found!');
                }
            });
        }
        
        // Function to get current location
        function getCurrentLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(function(position) {
                    var latLng = [position.coords.latitude, position.coords.longitude];
                    map.setView(latLng, 13);
                }, function(error) {
                    alert('Error getting current location: ' + error.message);
                });
            } else {
                alert('Geolocation is not supported by this browser.');
            }
        }

        // Function to show route confirmation dialog
        function showRouteConfirmation() {
            var confirmMessage = "Do you want to show the route between these points?";
            if (confirm(confirmMessage)) {
                showRoute();
            }
        }

        // Function to show the route
        function showRoute() {
            var waypoints = [firstPoint, secondPoint];
            routingControl = L.Routing.control({
                waypoints: waypoints,
                routeWhileDragging: true, // Update route while dragging markers
                lineOptions: {
                    styles: [{color: 'orange', opacity: 1, weight: 5}]
                },
                show: false // Hide the route by default
            }).addTo(map);
            routingControl.show();

            // Show the route buttons
            document.getElementById('route-buttons').style.display = 'block';
        }

        // Function to hide the route
        function hideRoute() {
            if (routingControl !== null) {
                map.removeControl(routingControl);
                document.getElementById('route-buttons').style.display = 'none';
            }
        }

        // Function to hide all points except the first point and current point
        function hidePoints() {
            Object.keys(markers).forEach(function(id) {
                if (id !== 'firstPoint') {
                    map.removeLayer(markers[id]);
                }
            });
            document.getElementById('hide-points-button').style.display = 'none';
            document.getElementById('show-points-button').style.display = 'block';
        }
        
        // Function to show all points
        function showPoints() {
            Object.keys(markers).forEach(function(id) {
                map.addLayer(markers[id]);
            });
            document.getElementById('show-points-button').style.display = 'none';
            document.getElementById('hide-points-button').style.display = 'block';
        }
    </script>

</body>

</html>
            """
          ),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(

            ),
          ),
          onWebViewCreated: (InAppWebViewController controller) {},
        ),
      ),
    );
  }
}
