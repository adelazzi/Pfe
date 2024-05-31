import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
/* 
class CommandScreen extends StatefulWidget {
  const CommandScreen({Key? key}) : super(key: key);

  @override
  _CommandScreenState createState() => _CommandScreenState();
}

class _CommandScreenState extends State<CommandScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // Location data
  String? currentLocation;
  String? futureLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Command"),
      ),
      body: SafeArea(
        child: Form(
          key: _formkey,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Vector.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Command",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 17),
                      Text(
                        "Let's make your order here!",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      inputFile(label: "Size", hint: "Enter the size"),
                      inputFile(label: "Weight", hint: "Enter the weight"),
                      inputFile(label: "Description", hint: "Enter the description"),
                      SizedBox(height: 15),
                      TextButton.icon(
                        onPressed: () async {
                          final locations = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SelectPlace()),
                          );
                          if (locations != null) {
                            setState(() {
                              currentLocation = locations[0];
                              futureLocation = locations[1];
                            });
                          }
                        },
                        icon: const Icon(Icons.location_on_outlined, color: Colors.black),
                        label: const Text("Location", style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(height: 30),
                      MaterialButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            // Perform the create action with currentLocation and futureLocation
                          }
                        },
                        minWidth: double.infinity,
                        height: 60,
                        elevation: 1,
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          "Create",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputFile({
    required String label,
    required String hint,
    TextEditingController? controller,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: (value) {
              if (label == "Size") {
                if (value == null ||
                    value.isEmpty ||
                    (value != "Extra large" && value != "Large" && value != "Medium" && value != "Small")) {
                  return "Select one of the options: Extra large, Large, Medium, or Small";
                }
              } else if (label == "Weight") {
                if (value == null || value.isEmpty || int.tryParse(value) == null) {
                  return "Enter the weight please!";
                }
              } else if (label == "Description") {
                if (value == null || value.isEmpty) {
                  return "Enter a description about your order please!";
                }
              }
              return null;
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              labelText: hint,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            keyboardType: label == "Weight" ? TextInputType.number : TextInputType.text,
            textInputAction: TextInputAction.next,
          )
        ],
      ),
    );
  }
}

class SelectPlace extends StatefulWidget {
  @override
  _SelectPlaceState createState() => _SelectPlaceState();
}

class _SelectPlaceState extends State<SelectPlace> {
  Position? currentLocation;
  TextEditingController currentLocationController = TextEditingController();
  TextEditingController futureLocationController = TextEditingController();
  late InAppWebViewController webViewController;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if (currentLocation != null) {
      currentLocationController.text = "${currentLocation!.latitude}, ${currentLocation!.longitude}";
      String mapHTML = '''
      <!DOCTYPE html>
      <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Map</title>
        <link rel="stylesheet" href="https://unpkg.com/leaflet@1.8.0/dist/leaflet.css" />
        <link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@latest/dist/leaflet-routing-machine.css" />
        <style>
          #map { height: 100vh; }
        </style>
      </head>
      <body>
        <div id="map"></div>
        <script src="https://unpkg.com/leaflet@1.8.0/dist/leaflet.js"></script>
        <script src="https://unpkg.com/leaflet-routing-machine@latest/dist/leaflet-routing-machine.js"></script>
        <script src="https://unpkg.com/leaflet-control-geocoder@1.13.0/dist/Control.Geocoder.js"></script>
        <script>
          var map = L.map('map').setView([${currentLocation!.latitude}, ${currentLocation!.longitude}], 13);
          L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
          }).addTo(map);

          var currentMarker = L.marker([${currentLocation!.latitude}, ${currentLocation!.longitude}]).addTo(map)
            .bindPopup('Current Location').openPopup();

          map.on('click', function(e) {
            if (currentMarker) {
              map.removeLayer(currentMarker);
            }
            currentMarker = L.marker(e.latlng).addTo(map)
              .bindPopup('Future Location').openPopup();
            window.flutter_inappwebview.callHandler('locationSelected', e.latlng.lat, e.latlng.lng);
          });
        </script>
      </body>
      </html>
      ''';

      webViewController.loadUrl(urlRequest: URLRequest(
          url: Uri.parse("data:text/html;base64," + base64Encode(const Utf8Encoder().convert(mapHTML)))
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Locations'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
          Expanded(
          child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse("about:blank")),
      onWebViewCreated: (controller) {
        webViewController = controller;
        webViewController.addJavaScriptHandler(
          handlerName: 'locationSelected',
          callback: (args) {
            setState(() {
              futureLocationController.text = '${args[0]}, ${args[1]}';
            });
          },
        );
      },
    ),
    ),
    SizedBox(height: 20),
    buildLocationField("Current Location", currentLocationController),
    SizedBox(height: 20),
    buildLocationField("Future Location", futureLocationController),
    SizedBox(height: 20),
    ElevatedButton(
    onPressed: () {
      // Save the locations and return to the previous screen
      // You can use Navigator.pop(context) to go back
      Navigator.pop(context, [
        currentLocationController.text,
        futureLocationController.text,
      ]);
    },
      child: Text('Done'),
    ),
              ],
          ),
      ),
    );
  }

  Widget buildLocationField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
*/
