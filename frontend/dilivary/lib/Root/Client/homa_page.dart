// ignore_for_file: camel_case_types, library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../../Models/User.dart';
import '../Login.dart';
import '../screens/message.dart';
import '../screens/notification.dart';
import 'profileC.dart';
import 'home_c.dart';
import 'map_c.dart'; // Import InAppWebView

class HomePage_C extends StatefulWidget {
  const HomePage_C({Key? key}) : super(key: key);

  @override
  _HomePage_CState createState() => _HomePage_CState();
}
class _HomePage_CState extends State<HomePage_C> {
  int _selectedIndex = 0;
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

  final List<Widget> _screens = [
    HomeScreen(),
    MapScreen(),
    MessageScreen(),
    ProfileScreen_c(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _logout(BuildContext context) async {
    await User.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
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
                          ),
                        );
                        // Add onPressed for notifications button
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.logout, color: Colors.red),
                      onPressed: () => _logout(context),
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
              margin: EdgeInsets.symmetric(horizontal: 9),
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
