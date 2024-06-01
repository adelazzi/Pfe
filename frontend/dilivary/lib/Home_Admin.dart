// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, file_names

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomeAdminPage extends StatefulWidget {
  const HomeAdminPage({Key? key}) : super(key: key);
  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();
}

class _HomeAdminPageState extends State<HomeAdminPage> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/Vector.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
    ClientScreen(),
    DeliveryPersonScreen(),
    Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/Vector.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Vector.jpg"),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 1.0),
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
                      icon: Icon(Icons.account_circle_outlined),
                      label: "Client",
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.delivery_dining_rounded),
                      label: "Delivery Person",
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.markunread_mailbox),
                      label: "Mailbox",
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





class Homeadmin extends StatefulWidget {
  const Homeadmin({Key? key}) : super(key: key);

  @override
  State<Homeadmin> createState() => _HomeadminState();
}

class _HomeadminState extends State<Homeadmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}















class ClientScreen extends StatefulWidget {
  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  List<dynamic> clients = []; // Renamed to lowercase 'clients'

  @override
  void initState() {
    super.initState();
    _fetchClients(); // Call the function to fetch clients
  }

  Future<void> _fetchClients() async {
    try {
      final List<dynamic> fetchedClients =
          await fetchUsers('Client'); // Fetch clients
      setState(() {
        clients = fetchedClients; // Update the 'clients' list with fetched data
      });
    } catch (e) {
      // Handle error
      print("Error fetching clients: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add your search functionality here
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/Vector.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: clients.length,
          itemBuilder: (context, index) {
            return ClientListItem(
              userid: clients[index]['id'],
              id: clients[index]['id_number'],
              name: clients[index]['username'],
              email: clients[index]['email'],
              phonenumber: clients[index]['phone_number'],
              age: clients[index]['age'],
            );
          },
        ),
      ),
    );
  }
}

class ClientListItem extends StatelessWidget {
  final int? userid;
  final String id;
  final String name;
  final String email;
  final String phonenumber;
  final int? age;

  const ClientListItem({
    Key? key,
    required this.id,
    required this.name,
    required this.email,
    required this.phonenumber,
    this.age,
    this.userid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              showDeleteDialog(context, name, userid);
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              showUserDetailsDialog(
                  context, userid, name, email, age, id, phonenumber);
            },
          ),
        ],
      ),
    );
  }
}

void showDeleteDialog(BuildContext context, String name, int? userid) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Delete User'),
        content: Text('Do you want to delete the user $name?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No'),
          ),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(' User deleted successfully')),
              );
              deleteUser(userid);
              Navigator.of(context).pop();
            },
            child: Text('Yes, Delete Now'),
          ),
        ],
      );
    },
  );
}

void showUserDetailsDialog(BuildContext context, int? userid, String name,
    String email, int? age, String idnumber, String phonenumber) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('User ${userid ?? "N/A"}'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Name: $name'),
              Text('Email: $email'),
              Text('Age: ${age ?? "N/A"}'),
              Text('ID Number: $idnumber'),
              Text('Phone number: $phonenumber'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

class DeliveryPersonScreen extends StatefulWidget {
  const DeliveryPersonScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryPersonScreen> createState() => _DeliveryPersonScreenState();
}

class _DeliveryPersonScreenState extends State<DeliveryPersonScreen> {
  List<dynamic> drivers = []; // Renamed to lowercase 'clients'

  @override
  void initState() {
    super.initState();
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
      
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add your search functionality here
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/Vector.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: drivers.length,
          itemBuilder: (context, index) {
            return DriverListItem(
              userid: drivers[index]['id'],
              id: drivers[index]['id_number'],
              name: drivers[index]['username'],
              email: drivers[index]['email'],
              phonenumber: drivers[index]['phone_number'],
              age: drivers[index]['age'],
            );
          },
        ),
      ),
    );
  }
}

class DriverListItem extends StatelessWidget {
  final int? userid;
  final String id;
  final String name;
  final String email;
  final String phonenumber;
  final int? idlicense;
  final int? age;

  const DriverListItem({
    Key? key,
    required this.id,
    required this.name,
    required this.email,
    required this.phonenumber,
    this.age,
    this.idlicense,
    this.userid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(email),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              showDeleteDialog(context, name, userid);
            },
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              showUserDetailsDialog(
                  context, userid, name, email, age, id, phonenumber);
            },
          ),
        ],
      ),
    );
  }
}

void showDriverDetailsDialog(
    BuildContext context,
    int? userid,
    String name,
    String email,
    int? age,
    String idnumber,
    String phonenumber,
    int? idlicense) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Driver ${userid ?? "N/A"}'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Name: $name'),
              Text('Email: $email'),
              Text('Age: ${age ?? "N/A"}'),
              Text('Id license: ${idlicense ?? "N/A"}'),
              Text('ID Number: $idnumber'),
              Text('Phone number: $phonenumber'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
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

Future<void> deleteUser(int? userId) async {
  final response = await http.delete(
    Uri.parse('http://127.0.0.1:8000/api/$userId/delete/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // Add any additional headers if needed
    },
  );

  if (response.statusCode == 204) {
    print('User deleted successfully');
  } else {
    print('Failed to delete user: ${response.statusCode}');
    // Handle other status codes if needed
  }
}
