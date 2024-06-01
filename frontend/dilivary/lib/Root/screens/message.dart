// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../Models/User.dart';
import 'chats.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MessageScreen extends StatefulWidget {
  
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<dynamic> drivers = []; // Renamed to lowercase 'clients'

   User? user;



  Future<void> loadUser() async {
    User? fetchedUser = await User.getUserFromPreferences();
    setState(() {
      user = fetchedUser;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
    _fetchClients(); // Call the function to fetch clients
  }

  Future<void> _fetchClients() async {
    try {
      final List<dynamic> fetchedClients =
          await fetchUsers('Driver'); // Fetch clients
      setState(() {
        drivers = fetchedClients; // Update the 'clients' list with fetched data
      });
    } catch (e) {
      // Handle error
      print("Error fetching clients: $e");
    }
  }

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
            SizedBox(
              height: 40,
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
                itemCount: drivers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          ),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/Avatar.jpg'),
                        // You can replace this with the actual profile image
                      ),
                    ),
                    title: Text(drivers[index]["username"]),
                    onTap: () {
                      // Navigate to chat screen when tapping on a delivery person
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChatScreen(id2:drivers[index]["id"],id1: user!.id,)),
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

Future<List<dynamic>> fetchUsers(String? typeUser) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/api/users/'));
  if (response.statusCode == 200) {
    final List<dynamic> users = jsonDecode(response.body);
    if (typeUser != null) {
      return users.where((user) => user['user_type'] == typeUser).toList();
    } else {
      return users;
    }
  } else {
    throw Exception('Failed to load users');
  }
}

































/*

                      width: 3,
                          color: drivers[index]["status"] == "Online"
                            ? Colors.green
                            : Colors.red,
                        )


 */