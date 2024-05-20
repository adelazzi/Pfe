import 'package:flutter/material.dart';

import 'chats.dart';


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
