import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart'; // Import InAppWebView


import 'package:geolocator/geolocator.dart';



class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  InAppWebViewController? webViewController;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });

    if (webViewController != null) {
      webViewController!.evaluateJavascript(
          source: "setStartingPoint(${position.latitude}, ${position.longitude})");
    }
  }

  void _onWebViewCreated(InAppWebViewController controller) {
    webViewController = controller;
    if (_currentPosition != null) {
      controller.evaluateJavascript(source: "setStartingPoint(${_currentPosition!.latitude}, ${_currentPosition!.longitude})");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Options'),
      ),
      body: Container(
        child: InAppWebView(
          initialData: InAppWebViewInitialData(
              data: """
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width,initial-scale=1.0">
  <title>Geolocation</title>
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.8.0/dist/leaflet.css" />
  <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@latest/dist/leaflet-routing-machine.css" />
  <link rel="stylesheet" href="https://unpkg.com/leaflet-control-geocoder@1.13.0/dist/Control.Geocoder.css" />

  <style>
    body,
    html {
      margin: 0;
      padding: 0;
      height: 100%;
      overflow: hidden;
    }

    .popup-content {
      text-align: center;
    }

    .route-summary {
      background-color: rgba(255, 140, 0, 0.5);
      padding: 5px;
      border-radius: 5px;
    }

    #search-container {
      position: absolute;
      top: 3%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: 1000;
      background-color: white;
      padding: 5px 10px;
      border-radius: 5px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      display: flex;
      align-items: center;
    }

    #map {
      width: 100vw;
      height: 100vh;
    }

    #menu-button {
      position: absolute;
      top: 10%;
      left: 3%;
      z-index: 1000;
      background-color: white;
      padding: 5px;
      border-radius: 5px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    #menu-buttons {
      display: none;
      flex-direction: column;
      position: absolute;
      top: 10%;
      left: 3%;
      z-index: 1000;
      background-color: white;
      padding: 5px;
      border-radius: 5px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    #route-summary-container {
      display: none;
      background-color: rgba(255, 255, 255, 0.8);
      padding: 10px;
      border-radius: 5px;
      position: absolute;
      bottom: 10%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: 1000;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .leaflet-top.leaflet-right {
      display: none;
      width: 150px;
      top: 50px;
      right: 10px;
    }
  </style>

</head>

<body>
  <div id="map"></div>
  <div id="search-container">
    <input type="text" id="search-input" placeholder="Enter latitude, longitude, or place name">
    <button onclick="searchLocation()">Search</button>
  </div>
  <div id="menu-button" onclick="toggleMenu()">...</div>
  <div id="menu-buttons">
    <button onclick="hideRoute()">Hide Route</button>
    <button onclick="hidePoints()">Hide Points</button>
    <button onclick="calculateShortestPath()">Show Shortest Path</button>
    <button onclick="toggleRouteSummary()">Toggle Route Summary</button>
  </div>
  <div id="route-summary-container"></div>

  <script src="https://unpkg.com/leaflet@1.8.0/dist/leaflet.js"></script>
  <script src="https://unpkg.com/leaflet-routing-machine@latest/dist/leaflet-routing-machine.js"></script>
  <script src="https://unpkg.com/leaflet-control-geocoder@1.13.0/dist/Control.Geocoder.js"></script>
 <script>
  var menuButtons = document.getElementById('menu-buttons');
  var menuButton = document.getElementById('menu-button');

  document.addEventListener('click', function(event) {
    var isClickInsideMenu = menuButtons.contains(event.target) || menuButton.contains(event.target);
    if (!isClickInsideMenu) {
      menuButtons.style.display = 'none';
    }
  });

  var map = L.map('map').setView([36.7362, 3.1830], 11);
  var mapLink = "<a href='http://openstreetmap.org'>OpenStreetMap</a>";
  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: 'Leaflet &copy; ' + mapLink + ', contribution',
    maxZoom: 18
  }).addTo(map);

  var markers = [];
  var routingControl = null;
  var startPoint = null;

  map.on('click', function (e) {
    var marker = createNumberedMarker(e.latlng, markers.length + 1);
    markers.push(marker);
    showRoute();
  });

  function createNumberedMarker(latlng, markerNumber) {
    var markerHtml = '<div style="background-color: red; color: white; border-radius: 50%; width: 30px; height: 30px; text-align: center; line-height: 30px;">' + markerNumber + '</div>';
    var markerIcon = L.divIcon({
      html: markerHtml,
      className: 'numbered-marker',
      iconSize: [30, 30]
    });
    return L.marker(latlng, { icon: markerIcon }).addTo(map);
  }

  function updateMarkerNumbers() {
    for (let i = 1; i < markers.length; i++) {
      let newMarker = createNumberedMarker(markers[i].getLatLng(), i + 1);
      map.removeLayer(markers[i]);
      markers[i] = newMarker;
    }
  }

  function searchLocation() {
    var searchText = document.getElementById('search-input').value;
    var geocoder = L.Control.Geocoder.nominatim();
    geocoder.geocode(searchText, function (results) {
      if (results && results.length > 0) {
        var latLng = [results[0].center.lat, results[0].center.lng];
        var marker = createNumberedMarker(latLng, markers.length + 1);
        markers.push(marker);
        showRoute();
        map.setView(latLng, 13);
      } else {
        alert('Location not found!');
      }
    });
  }

  function setStartingPoint(lat, lng) {
    var latLng = [lat, lng];
    startPoint = createNumberedMarker(latLng, 1);
    markers.unshift(startPoint);
    showRoute();
    map.setView(latLng, 13);
  }

  function showRoute() {
    if (routingControl !== null) {
      map.removeControl(routingControl);
    }
    if (markers.length >= 2) {
      var waypoints = markers.map(function (marker) {
        return marker.getLatLng();
      });
      routingControl = L.Routing.control({
        waypoints: waypoints,
        routeWhileDragging: true,
        lineOptions: {
          styles: [{ color: 'blue', opacity: 1, weight: 5 }]
        }
      }).addTo(map);
      routingControl.on('routesfound', function (e) {
        var routes = e.routes;
        var routeSummary = routes[0].summary;
        var summaryHtml = '<div class="route-summary">Total distance: ' + (routeSummary.totalDistance / 1000).toFixed(2) + ' km<br>Total time: ' + (routeSummary.totalTime / 3600).toFixed(2) + ' hours</div>';
        document.getElementById('route-summary-container').innerHTML = summaryHtml;
      });
      document.getElementById('route-buttons').style.display = 'block';
    }
  }

  function hideRoute() {
    if (routingControl !== null) {
      map.removeControl(routingControl);
      document.getElementById('route-buttons').style.display = 'none';
      document.getElementById('route-summary-container').style.display = 'none';
    }
  }

  function hidePoints() {
    if (markers.length > 1) {
      for (let i = 1; i < markers.length; i++) {
        map.removeLayer(markers[i]);
      }
      markers = [startPoint];
      hideRoute();
    }
  }

  function calculateShortestPath() {
    if (markers.length >= 2) {
      var points = markers.map(function (marker) {
        return marker.getLatLng();
      });

      function calculateDistances(points) {
        let distances = [];
        for (let i = 1; i < points.length; i++) {
          let dist = points[0].distanceTo(points[i]);
          distances.push({ index: i, distance: dist });
        }
        return distances.sort((a, b) => a.distance - b.distance);
      }

      var distances = calculateDistances(points);
      var sortedMarkers = [markers[0]];

      distances.forEach(function (distanceObj) {
        sortedMarkers.push(markers[distanceObj.index]);
      });

      markers = sortedMarkers;
      updateMarkerNumbers();
      showRoute();
    } else {
      alert('Please select at least two points to calculate the shortest path.');
    }
  }

  function toggleRouteSummary() {
    var summaryContainer = document.getElementById('route-summary-container');
    var controlContainer = document.querySelector('.leaflet-top.leaflet-right');

    if (summaryContainer.style.display === 'none' || summaryContainer.style.display === '') {
      summaryContainer.style.display = 'block';
      controlContainer.style.display = 'block';
    } else {
      summaryContainer.style.display = 'none';
      controlContainer.style.display = 'none';
    }
  }

  function toggleControlContainer() {
    var controlContainer = document.querySelector('.leaflet-top.leaflet-right');
    if (controlContainer.style.display === 'none' || controlContainer.style.display === '') {
      controlContainer.style.display = 'block';
    } else {
      controlContainer.style.display = 'none';
    }
  }

  function toggleMenu() {
    var menuButtons = document.getElementById('menu-buttons');
    if (menuButtons.style.display === 'none' || menuButtons.style.display === '') {
      menuButtons.style.display = 'flex';
    } else {
      menuButtons.style.display = 'none';
    }
  }

  function closeMenu() {
    var menuButtons = document.getElementById('menu-buttons');
    menuButtons.style.display = 'none';
  }
</script>

</body>

</html>
            """
          ),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              // Customize options here
            ),
          ),
          onWebViewCreated: _onWebViewCreated,
        ),
      ),
    );
  }
}
