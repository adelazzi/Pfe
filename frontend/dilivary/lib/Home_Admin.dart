import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
class HomeAdminPage extends StatefulWidget{
  const HomeAdminPage({Key? key}):super(key: key);
  @override
  _HomeAdminPageState createState() => _HomeAdminPageState();
}
class _HomeAdminPageState extends State<HomeAdminPage>{
  int _selectedIndex=0;
  final List<Widget> _screens=[
    Container(decoration: BoxDecoration(
                   image: DecorationImage(
                    image: AssetImage("assets/Vector.jpg"),
                    fit: BoxFit.cover,
                  ),
                  ),),
    ClientScreen(),
    DeliveryPersonScreen(),
    Container(decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage("assets/Vector.jpg"),
        fit: BoxFit.cover,
      ),
    ),),

  ];
  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
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
            bottom: MediaQuery.of(context).size.height*0.02,
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
                    const BottomNavigationBarItem(icon: Icon(Icons.home_sharp),
                    label: "Home",
                    ),
                    const BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),
                    label: "Client",
                    ),
                    const BottomNavigationBarItem(icon: Icon(Icons.delivery_dining_rounded),
                    label: "Delivery Person",
                    ),
                    const BottomNavigationBarItem(icon: Icon(Icons.markunread_mailbox),
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




class ClientScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Client List"),
        // Add a search bar
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
        child: ListView(
          children: [
            // Client List Items
            ClientListItem(
              name: "Client 1",
              details: "Client details 1",
            ),
            ClientListItem(
              name: "Client 2",
              details: "Client details 2",
            ),
            // Add more ClientListItem widgets for each client
          ],
        ),
      ),
    );
  }
}

class ClientListItem extends StatelessWidget {
  final String name;
  final String details;

  const ClientListItem({
    Key? key,
    required this.name,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(details),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Add delete functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.block),
            onPressed: () {
              // Add block functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.ad_units),
            onPressed: () {
              // Add advertisement functionality
            },
          ),
        ],
      ),
    );
  }
}




class DeliveryPersonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivery Person List"),
        // Add a search bar
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
        child: ListView(
          children: [
            // Delivery Person List Items
            DeliveryPersonListItem(
              name: "Delivery Person 1",
              details: "Delivery person details 1",
            ),
            DeliveryPersonListItem(
              name: "Delivery Person 2",
              details: "Delivery person details 2",
            ),
            // Add more DeliveryPersonListItem widgets for each delivery person
          ],
        ),
      ),
    );
  }
}

class DeliveryPersonListItem extends StatelessWidget {
  final String name;
  final String details;

  const DeliveryPersonListItem({
    Key? key,
    required this.name,
    required this.details,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(details),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // Add delete functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.block),
            onPressed: () {
              // Add block functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.ad_units),
            onPressed: () {
              // Add advertisement functionality
            },
          ),
        ],
      ),
    );
  }
}
