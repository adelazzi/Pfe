// ignore_for_file: prefer_const_constructors

import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Models/User.dart';

class SeeCommandYourCommand extends StatefulWidget {
  int? iddriver;
  SeeCommandYourCommand({required this.iddriver, Key? Key}) : super(key: Key);
  @override
  _SeeCommandYourCommandState createState() => _SeeCommandYourCommandState();
}

class _SeeCommandYourCommandState extends State<SeeCommandYourCommand> {
  List<dynamic> commands = []; // Renamed to lowercase 'clients'

  @override
  void initState() {
    super.initState();
    _fetchDriverCommand(); // Call the function to fetch clients
  }

  Future<void> _fetchDriverCommand() async {
    try {
      final List<dynamic> fetchedCommands =
          await fetchDriverCommand(widget.iddriver); // Fetch clients
      setState(() {
        commands =
            fetchedCommands; // Update the 'clients' list with fetched data
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
        title: Text("Command List"),
        actions: [
          IconButton(
            onPressed: () {
              _fetchDriverCommand();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Vector.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView.builder(
          itemCount: commands.length,
          itemBuilder: (context, index) {
            return CommandListItem(
              id: commands[index]['id'],
              complated: commands[index]['completed'],
              size: commands[index]['size'],
              weight: commands[index]['weight'],
              description: commands[index]['desqreption'],
              Location: '',
              idclient: commands[index]['idclient'],
            );
          },
        ),
      ),
    );
  }
}

Future<List<dynamic>> fetchDriverCommand(int? iddriver) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/command/Lists/'));
  if (response.statusCode == 200) {
    final List<dynamic> commands = jsonDecode(response.body);
    if (iddriver != null) {
      return commands
          .where((command) => command['iddriver'] == iddriver)
          .toList();
    } else {
      return commands
          .where((command) => command['iddriver'] == iddriver)
          .toList();
    }
  } else {
    throw Exception('Failed to load users');
  }
}

Future<List<dynamic>> fetchClientCommand(int? iddclient) async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/command/Lists/'));
  if (response.statusCode == 200) {
    final List<dynamic> commands = jsonDecode(response.body);
    if (iddclient != null) {
      return commands
          .where((command) => command['idclient'] == iddclient)
          .toList();
    } else {
      return commands
          .where((command) => command['idclient'] == iddclient)
          .toList();
    }
  } else {
    throw Exception('Failed to load users');
  }
}

Future<List<dynamic>> fetchVehicule() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/vehicule/'));

  if (response.statusCode == 200) {
    final List<dynamic> vehicules = jsonDecode(response.body);
    return vehicules;
  } else {
    throw Exception('Failed to load vehicules');
  }
}
class SeeCommandAvailable extends StatefulWidget {
  const SeeCommandAvailable({Key? key}) : super(key: key);

  @override
  State<SeeCommandAvailable> createState() => _SeeCommandAvailableState();
}

class _SeeCommandAvailableState extends State<SeeCommandAvailable> {
  List<dynamic> commands = []; // Renamed to lowercase 'clients'

  @override
  void initState() {
    super.initState();
    commands = [];
    _fetchDriverCommand(); // Call the function to fetch clients
  }

  Future<void> _fetchDriverCommand() async {
    try {
      final List<dynamic> fetchedCommands =
          await fetchDriverCommand(null); // Fetch clients
      setState(() {
        commands =
            fetchedCommands; // Update the 'clients' list with fetched data
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
        title: Text("Command List"),
        actions: [
          IconButton(
            onPressed: () {
              _fetchDriverCommand();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Vector.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView.builder(
          itemCount: commands.length,
          itemBuilder: (context, index) {
            return CommandListItemAvailable(
              id: commands[index]['id'],
              complated: commands[index]['completed'],
              size: commands[index]['size'],
              weight: commands[index]['weight'],
              description: commands[index]['desqreption'],
              Location: '',
              idclient: commands[index]['idclient'],
            );
          },
        ),
      ),
    );
  }
}

class SeeCommandYourCommandC extends StatefulWidget {
  int? idClient;
  SeeCommandYourCommandC({required this.idClient, Key? Key}) : super(key: Key);
  @override
  _SeeCommandYourCommandCState createState() => _SeeCommandYourCommandCState();
}

class _SeeCommandYourCommandCState extends State<SeeCommandYourCommandC> {
  List<dynamic> commands = []; // Renamed to lowercase 'clients'

  @override
  void initState() {
    super.initState();
    _fetchDriverCommand(); // Call the function to fetch clients
  }

  Future<void> _fetchDriverCommand() async {
    try {
      final List<dynamic> fetchedCommands =
          await fetchClientCommand(widget.idClient); // Fetch clients
      setState(() {
        commands =
            fetchedCommands; // Update the 'clients' list with fetched data
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
        title: Text("Command List"),
        actions: [
          IconButton(
            onPressed: () {
              int? id = widget.idClient;
              print('{$id}');
              _fetchDriverCommand();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Vector.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView.builder(
          itemCount: commands.length,
          itemBuilder: (context, index) {
            return CommandListClient(
              id: commands[index]['id'],
              complated: commands[index]['completed'],
              size: commands[index]['size'],
              weight: commands[index]['weight'],
              description: commands[index]['desqreption'],
              Location: 'from XXX to YYY',
              idclient: commands[index]['idclient'],
            );
          },
        ),
      ),
    );
  }
}

class SeeAllVehicule extends StatefulWidget {
  @override
  _SeeAllVehiculeState createState() => _SeeAllVehiculeState();
}

class _SeeAllVehiculeState extends State<SeeAllVehicule> {
  List<dynamic> vehicules = []; // Renamed to lowercase 'clients'

  @override
  void initState() {
    super.initState();
    _fetchVehicule(); // Call the function to fetch clients
  }

  Future<void> _fetchVehicule() async {
    try {
      final List<dynamic> fetchedvehicules =
          await fetchVehicule(); // Fetch clients
      setState(() {
        vehicules =
            fetchedvehicules; // Update the 'clients' list with fetched data
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
        title: Text("Command List"),
        actions: [
          IconButton(
            onPressed: () {
              _fetchVehicule();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Vector.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView.builder(
          itemCount: vehicules.length,
          itemBuilder: (context, index) {
            return VehiculesLists(
              iddriverlic :  vehicules[index]['id_driving_license'],
              Location: 'from XXX to YYY',
              matricule: vehicules[index]['matricule'],
              maxSize:vehicules[index]['max_size'],
              color: vehicules[index]['color'],
              maxweight: vehicules[index]['max_weight'],
              type: vehicules[index]['type'],
              model: vehicules[index]['model'],
            );
          },
        ),
      ),
    );
  }
}

Future<void> completeCommand(int? commandId) async {
  final url = Uri.parse('http://127.0.0.1:8000/command/$commandId/complete/');

  final response = await http.post(url);

  if (response.statusCode == 200) {
    // Handle success
    print('Command completed successfully');
  } else {
    // Handle failure
    print(
        'Failed to complete the command. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}


class CommandListItem extends StatefulWidget {
  final int id;
  final String size;
  final double weight;
  final String? description;
  final String Location;
  final int? idclient;
  final bool complated;

  CommandListItem({
    Key? key,
    required this.complated,
    required this.id,
    required this.size,
    required this.weight,
    required this.description,
    required this.Location,
    this.idclient,
  }) : super(key: key);

  @override
  _CommandListItemState createState() => _CommandListItemState();
}

class _CommandListItemState extends State<CommandListItem> {
  String? username;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    if (widget.idclient != null) {
      fetchUserData(widget.idclient!);
    }
  }

  Future<void> fetchUserData(int id) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/get/$id/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> user = jsonDecode(response.body);
      setState(() {
        username = user['username'];
        phoneNumber = user['phone_number'];
      });
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<void> updateCommand(int idcommand, String size, double weight, BuildContext context) async {
    String apiUrl = 'http://127.0.0.1:8000/command/$idcommand/update/';
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        body: json.encode({
          "iddriver": null,
          "size": size,
          "weight": weight,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
       
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('You let the command go. I hope you can find your best one.')),
        );
      } else {
        String errorMessage;
        try {
          final errorResponse = json.decode(response.body);
          errorMessage = errorResponse['message'] ?? 'Failed to update command';
        } catch (e) {
          errorMessage = 'Failed to update the command';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (error) {
      print('Error: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.complated ? Colors.green : Colors.deepOrangeAccent,
          width: 0.9,
          style: BorderStyle.solid,
        ),
        color: Colors.white54,
        borderRadius: BorderRadius.all(Radius.elliptical(25, 50)),
        shape: BoxShape.rectangle,
      ),
      child: ListTile(
        title: Text(
          "Command Details:\n" +
              "ID: ${widget.id}\n" +
              "Size: ${widget.size}\n" +
              "Weight: ${widget.weight} Kg\n" +
              "Description: ${widget.description ?? 'No description available'}\n" +
              "Location: ${widget.Location}\n" +
              "Client ID: ${widget.idclient?.toString() ?? 'N/A'}\n" +
              "Username: ${username ?? 'Loading...'}\n" +
              "Phone Number: ${phoneNumber ?? 'Loading...'}",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                completeCommand(widget.id);
              },
              icon: Icon(
                Icons.add_task,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                updateCommand(widget.id, widget.size, widget.weight, context);
              },
              icon: Icon(
                Icons.block,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommandListItemAvailable extends StatelessWidget {
  final int id;
  final String size;
  final double weight;
  final String? description;
  final String Location;
  final int? idclient;
  final bool complated;

  CommandListItemAvailable({
    Key? key,
    required this.complated,
    required this.id,
    required this.size,
    required this.weight,
    required this.description,
    required this.Location,
    this.idclient,
  }) : super(key: key);

  Future<void> updateCommand(
      int idcommand, String size, double weight, BuildContext context) async {
    int? id = DataId().data;

    String apiUrl =
        'http://127.0.0.1:8000/command/$idcommand/update/'; // Replace with your API URL
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        body: json.encode({
          "iddriver": id,
          "size": size,
          "weight": weight,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("{$id}");
        // User updated successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('U get your command Drive safe and follow the path ')),
        );
      } else {
        // Failed to update user
        String errorMessage;
        try {
          final errorResponse = json.decode(response.body);
          errorMessage = errorResponse['message'] ?? 'Failed to get command';
        } catch (e) {
          errorMessage = 'Failed to get the  commande';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: complated ? Colors.green : Colors.deepOrangeAccent,
          width: 0.9,
          style: BorderStyle.solid,
        ),
        color: Colors.white54,
        borderRadius: BorderRadius.all(Radius.elliptical(25, 50)),
        shape: BoxShape.rectangle,
      ),
      child: ListTile(
        title: Text(
          "Command  Details : \n " +
              id.toString() +
              "size : $size \n" +
              "weight : " +
              weight.toString() +
              " Kg \n" +
              "Description: ${description ?? 'No description available'} \n" +
              Location +
              "\n " +
              "" +
              idclient.toString(),
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                updateCommand(id, size, weight, context);
              },
              icon: Icon(
                Icons.add_location,
                color: Colors.deepOrangeAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommandListClient extends StatelessWidget {
  final int id;
  final String size;
  final double weight;
  final String? description;
  final String Location;
  final int? idclient;
  final bool complated;

  CommandListClient({
    Key? key,
    required this.complated,
    required this.id,
    required this.size,
    required this.weight,
    required this.description,
    required this.Location,
    this.idclient,
  }) : super(key: key);

  Future<void> updateCommand(
      int idcommand, String size, double weight, BuildContext context) async {
    String apiUrl =
        'http://127.0.0.1:8000/command/$idcommand/update/'; // Replace with your API URL
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        body: json.encode({
          "idclient": null,
          "size": size,
          "weight": weight,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("{$id}");
        // User updated successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'you let the command Go i hope u can find your best one ')),
        );
      } else {
        // Failed to update user
        String errorMessage;
        try {
          final errorResponse = json.decode(response.body);
          errorMessage = errorResponse['message'] ?? 'Failed to get command';
        } catch (e) {
          errorMessage = 'Failed to get the  commande';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: complated ? Colors.green : Colors.deepOrangeAccent,
          width: 0.9,
          style: BorderStyle.solid,
        ),
        color: Colors.white54,
        borderRadius: BorderRadius.all(Radius.elliptical(25, 50)),
        shape: BoxShape.rectangle,
      ),
      child: ListTile(
        title: Text(
          "Command  Details : \n " +
              id.toString() +
              "size : $size \n" +
              "weight : " +
              weight.toString() +
              " Kg \n" +
              "Description: ${description ?? 'No description available'} \n" +
              Location +
              "\n " +
              "" +
              idclient.toString(),
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.block,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CommandListAdmin extends StatefulWidget {
  final int id;
  final String size;
  final double weight;
  final String? description;
  final String Location;
  final int? idclient;
  final bool complated;

  CommandListAdmin({
    Key? key,
    required this.complated,
    required this.id,
    required this.size,
    required this.weight,
    required this.description,
    required this.Location,
    this.idclient,
  }) : super(key: key);

  @override
  _CommandListAdminState createState() => _CommandListAdminState();
}

class _CommandListAdminState extends State<CommandListAdmin> {
  String? username;
  String? phoneNumber;

  @override
  void initState() {
    super.initState();
    if (widget.idclient != null) {
      fetchUserData(widget.idclient!);
    }
  }

  Future<void> fetchUserData(int id) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/get/$id/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> user = jsonDecode(response.body);
      setState(() {
        username = user['username'];
        phoneNumber = user['phone_number'];
      });
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.complated ? Colors.green : Colors.deepOrangeAccent,
          width: 0.9,
          style: BorderStyle.solid,
        ),
        color: Colors.white54,
        borderRadius: BorderRadius.all(Radius.elliptical(25, 50)),
        shape: BoxShape.rectangle,
      ),
      child: ListTile(
        title: Text(
          "Command Details:\n" +
              "ID: ${widget.id}\n" +
              "Size: ${widget.size}\n" +
              "Weight: ${widget.weight} Kg\n" +
              "Description: ${widget.description ?? 'No description available'}\n" +
              "Location: ${widget.Location}\n" +
              "Client ID: ${widget.idclient?.toString() ?? 'N/A'}\n" +
              "Username: ${username ?? 'Loading...'}\n" +
              "Phone Number: ${phoneNumber ?? 'Loading...'}",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

Future<List<dynamic>> fetchDriverCommandAdmin() async {
  final response =
      await http.get(Uri.parse('http://127.0.0.1:8000/command/Lists/'));
  if (response.statusCode == 200) {
    final List<dynamic> commands = jsonDecode(response.body);
    return commands.toList();
  } else {
    throw Exception('Failed to load users');
  }
}

class SeeCommandAvailableAdmin extends StatefulWidget {
  const SeeCommandAvailableAdmin({Key? key}) : super(key: key);

  @override
  State<SeeCommandAvailableAdmin> createState() =>
      _SeeCommandAvailableAdminState();
}

class _SeeCommandAvailableAdminState extends State<SeeCommandAvailableAdmin> {
  List<dynamic> commands = []; // Renamed to lowercase 'clients'

  @override
  void initState() {
    super.initState();
    commands = [];
    _fetchDriverCommand(); // Call the function to fetch clients
  }

  Future<void> _fetchDriverCommand() async {
    try {
      final List<dynamic> fetchedCommands =
          await fetchDriverCommandAdmin(); // Fetch clients
      setState(() {
        commands =
            fetchedCommands; // Update the 'clients' list with fetched data
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
        title: Text("Command List"),
        actions: [
          IconButton(
            onPressed: () {
              _fetchDriverCommand();
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Vector.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: ListView.builder(
          itemCount: commands.length,
          itemBuilder: (context, index) {
            return CommandListAdmin(
              id: commands[index]['id'],
              complated: commands[index]['completed'],
              size: commands[index]['size'],
              weight: commands[index]['weight'],
              description: commands[index]['desqreption'],
              Location: '',
              idclient: commands[index]['idclient'],
            );
          },
        ),
      ),
    );
  }
}

class VehiculesLists extends StatelessWidget {
  final int matricule;
  final String maxSize;
  final String color;
  final int maxweight;
  final String type;
  final String model;
  final String Location;
  final int? iddriverlic;

  VehiculesLists({
    Key? key,
    this.iddriverlic,
    required this.Location,
    required this.matricule,
    required this.maxSize,
    required this.color,
    required this.maxweight,
    required this.type,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green,
          width: 0.9,
          style: BorderStyle.solid,
        ),
        color: Colors.white54,
        borderRadius: BorderRadius.all(Radius.elliptical(25, 50)),
        shape: BoxShape.rectangle,
      ),
      child: ListTile(
        title: Text(
          "Command  Details : \n " +"Matricule :"+
              matricule.toString() +
              "\n Max size : $maxSize \n" +
              "weight : " +
              maxweight.toString() +
              " Kg \n" +
              "Description: ${model} \n" +
              "Coleur : $color" +
              "\n " +
              "id driving license :" +
              iddriverlic.toString(), 
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}




Future<Map<String, String>> fetchUserPhoneAndUsername(int id) async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/get/$id/'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> user = jsonDecode(response.body);
    final String username = user['username'];
    final String phoneNumber = user['phone_number'];
    return {'username': username, 'phone_number': phoneNumber};
  } else {
    throw Exception('Failed to load user');
  }
}