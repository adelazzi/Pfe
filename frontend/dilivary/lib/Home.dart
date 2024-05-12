import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart'; // Import InAppWebView




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MapScreen(),
    MessageScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/Vector.jpg",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          _screens[_selectedIndex],
          Positioned(
            left: 5,
            right: 5,
            bottom: MediaQuery.of(context).size.height * 0.02,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  selectedItemColor: Colors.deepOrangeAccent,
                  unselectedItemColor: Colors.black,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  iconSize: 20,
                  selectedFontSize: 12,
                  unselectedFontSize: 12,
                  selectedLabelStyle: const TextStyle(fontSize: 15),
                  unselectedLabelStyle: const TextStyle(fontSize: 15),
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.home_sharp),
                      label: "Home",
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.map_sharp),
                      label: "Map",
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.messenger),
                      label: "Message",
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.person_3_sharp),
                      label: "Profile",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 80,
          ),
          Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: ClipOval(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/Avatar.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Elaidat Mohamed Redha",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    "ridaelaidate7@gmail.com | +213663235148",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // Add functionality for editing profile information
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Edit Profile Information",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Add functionality for showing notifications
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Notification",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Add functionality for changing language
                    },
                    icon: const Icon(
                      Icons.language_outlined,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Language",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      // Add functionality for managing security settings
                    },
                    icon: const Icon(
                      Icons.security,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Security",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Add functionality for accessing help & support
                    },
                    icon: const Icon(
                      Icons.help,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Help & Support",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Add functionality for contacting support
                    },
                    icon: const Icon(
                      Icons.contact_support,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Contact us",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> livreurs = [
    {"name": "John Doe", "status": "Online"},
    {"name": "Jane Smith", "status": "Offline"},
    // Add more delivery persons as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/Vector.jpg')),
        ),
        child: SingleChildScrollView(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40),
              // Avatar and Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 25,),
                        CircleAvatar(

                          backgroundImage: AssetImage('assets/Avatar.jpg'),
                          radius: 20,
                          // Add onPressed for avatar if needed
                        ),
                        SizedBox(width: 10,),
                        Text(
                          "Username",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.notifications),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NotificationScreen(),));
                            // Add onPressed for notifications button
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {
                            // Add onPressed for three dots button
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Add Command Card
               Card(
                color: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "So you want to post a command?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Add Command Button
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to Command Screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CommandScreen()),
                          );
                        },
                        icon: Icon(Icons.add),
                        label: Text("Add Command"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Transaction History Card
              Card(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Transaction history",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      // Add Transaction History Widgets here
                      // Replace below ListTile with your transaction history items
                      ListTile(
                        title: Text("Transaction 1"),
                        subtitle: Text("Description of transaction 1"),
                      ),
                      ListTile(
                        title: Text("Transaction 2"),
                        subtitle: Text("Description of transaction 2"),
                      ),
                      // Add more transaction history items as needed
                      SizedBox(height: 10),
                      // Delete All History Button
                      ElevatedButton(
                        onPressed: () {
                          // Add onPressed for delete all history button
                        },
                        child: Text("Delete All History"),
                      ),
                    ],
                  ),
                ),
              ),

              // Adjust as needed
              SizedBox(height: 20),
              // Delivery Persons Card
              Card(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Available Delivery Persons",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Search Bar
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Delivery Persons',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          // Implement search functionality here
                        },
                      ),
                      SizedBox(height: 10),
                      // List of Delivery Persons
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: livreurs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(livreurs[index]["name"]),
                            subtitle: Text(livreurs[index]["status"]),
                            // Add onTap functionality if needed
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  // Dummy data for delivery persons (livreurs) with their online/offline status
  List<Map<String, dynamic>> livreurs = [
    {"name": "John Doe", "status": "Online"},
    {"name": "Jane Smith", "status": "Offline"},
    // Add more delivery persons as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Vector.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40,),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),

              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
            ),
            // List of Delivery Persons
            Expanded(
              child: ListView.builder(
                itemCount: livreurs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      // Icon showing online/offline status
                      backgroundColor: livreurs[index]["status"] == "Online"
                          ? Colors.green
                          : Colors.red,
                      backgroundImage: AssetImage('assets/Avatar.jpg'),
                      // You can replace this with the actual profile image

                    ),
                    title: Text(livreurs[index]["name"]),
                    onTap: () {
                      // Navigate to chat screen when tapping on a delivery person
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = []; // List to store sent messages
  TextEditingController messageController = TextEditingController(); // Controller for text field

  // Function to send a message
  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add(messageController.text);
        // Clear the text field after sending the message
        messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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

class CommandScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Command Screen'),
      ),
      body: Center(
        child: Text('This is the Command Screen'),
      ),
    );
  }
}
class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add functionality for navigating back to the home screen
            Navigator.pop(context);
          },
          child: Text('Back to Home'),
        ),
      ),
    );
  }
}