
// ignore_for_file: unused_element, must_be_immutable

import 'package:flutter/material.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart'; // Import InAppWebView


import 'package:geolocator/geolocator.dart';

import '../../Models/User.dart';
import '../screens/message.dart';
import '../screens/notification.dart';
import 'homescreenD.dart';
import 'mapD.dart';
import 'profileD.dart';
class HomeDeliveryPage extends StatefulWidget {
  const HomeDeliveryPage({Key? key}) : super(key: key);

  @override
  _HomeDeliveryPageState createState() => _HomeDeliveryPageState();
}

class _HomeDeliveryPageState extends State<HomeDeliveryPage> {

    User? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    User? fetchedUser = await User.getUserFromPreferences();
    setState(() {
      user = fetchedUser;
    });
  }






  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    MapScreen(),
    MessageScreen(),
    ProfileScreenD(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/Avatar.jpg'),
                      radius: 20,
                      // Add onPressed for avatar if needed
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (user != null)
                      Text(
                        user!.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    else
                      Text('No user data found.'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NotificationScreen(),
                            ));
                        // Add onPressed for notifications button
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.logout , color: Colors.red,),
                      onPressed: () {
                        
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

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





class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

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






































/*
// v screen
class VehicleListScreen extends StatefulWidget {
  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  List<dynamic> _vehicles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchVehicles();
  }

  Future<void> _fetchVehicles() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/vehicule/'));

    if (response.statusCode == 200) {
      setState(() {
        _vehicles = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to load vehicles'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle List'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = _vehicles[index];
                return ListTile(
                  title: Text(vehicle['model']),
                  subtitle: Text(
                      'Type: ${vehicle['type']}, Color: ${vehicle['color']}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VehicleDetailScreen(vehicle: vehicle),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class VehicleDetailScreen extends StatelessWidget {
  final Map<String, dynamic> vehicle;

  VehicleDetailScreen({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vehicle Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Type: ${vehicle['type']}'),
            Text('Color: ${vehicle['color']}'),
            Text('Max Weight: ${vehicle['max_weight']}'),
            Text('Model: ${vehicle['model']}'),
            Text('Matricule: ${vehicle['matricule']}'),
            Text('ID License: ${vehicle['id_driving_license']}'),
            Text('Max Size: ${vehicle['max_size']}'),
            if (vehicle['photo'] != null)
              Image.network(
                "$server/media/image/Screenshot_from_2024-02-18_07-13-13.png",
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100,
                  ); // Display a placeholder or fallback image
                },
              ),
          ],
        ),
      ),
    );
  }
}

var server = "http://127.0.0.1:8000";
*/