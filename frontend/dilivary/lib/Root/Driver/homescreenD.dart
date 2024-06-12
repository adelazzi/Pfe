import 'package:flutter/material.dart';

import '../../Models/User.dart';
import '../screens/SeeCommandAviable.dart';
import '../screens/notification.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> livreurs = [
    {"name": "Dahmani Mohamed", "status": "Online"},
    {"name": "Ferdjani Kouider", "status": "Offline"},
    // Add more delivery persons as needed
  ];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/Vector.jpg')),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              // Add Command Card
              Card(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "here you can see your command ! ",
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
                            MaterialPageRoute(
                              builder: (context) => SeeCommandYourCommand(
                                iddriver: user!.id,
                              ),
                            ),
                          );
                        },
                        icon: Icon(Icons.remove_red_eye_outlined),
                        label: Text("See Command"),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              //
              Card(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "So you want to see a command aviable !",
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
                            MaterialPageRoute(
                                builder: (context) => SeeCommandAvailable()),
                          );
                        },
                        icon: Icon(Icons.remove_red_eye_outlined),
                        label: Text("See Command"),
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
                            title: Text(
                              livreurs[index]["name"] + "",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                ">" + livreurs[index]["status"] + "\n",
                                style: TextStyle(fontWeight: FontWeight.w500)),
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
