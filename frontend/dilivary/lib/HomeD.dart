import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeDeliveryPage extends StatefulWidget {
  const HomeDeliveryPage({Key? key}) : super(key: key);

  @override
  _HomeDeliveryPageState createState() => _HomeDeliveryPageState();
}

class _HomeDeliveryPageState extends State<HomeDeliveryPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Container(color: Colors.lightGreen),
    MapScreen(),
    Container(color: Colors.orange),
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
class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09), // Initial map center
          zoom: 13.0, // Initial zoom level
        ),
        children: [
          TileLayer(

            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],

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
