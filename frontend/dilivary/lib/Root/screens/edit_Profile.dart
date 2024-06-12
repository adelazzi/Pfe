import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? name; // Default name
  String? email; 
  String? phoneNumber; // Default phone number
  int? age;
  String? idnumber;

  Future<void> saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name!);
    await prefs.setString('email', email!);
    await prefs.setInt('age', age!);
    await prefs.setString('phone_number', phoneNumber!);
    await prefs.setString('id_number', idnumber!);
  }

  Future<void> updateUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null) {
      // Handle the case where the token is not found
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication token not found')),
      );
      return;
    }

    String apiUrl =
        'http://127.0.0.1:8000/api/update/'; // Replace with your API URL
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode({
          "username": name,
          "email": email,
          "age": age,
          "phone_number": phoneNumber,
          "id_number": idnumber,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        // User updated successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User updated successfully')),
        );
        await saveToPreferences();
      } else {
        // Failed to update user
        String errorMessage;
        try {
          final errorResponse = json.decode(response.body);
          errorMessage = errorResponse['message'] ?? 'Failed to update user';
        } catch (e) {
          errorMessage = 'Failed to update user';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('u didnt update all the value the value u add updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Vector.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
              onChanged: (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'idnumber',
              ),
              onChanged: (value) {
                setState(() {
                  idnumber = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Age',
              ),
              onChanged: (value) {
                setState(() {
                  // Parse the input value to an int
                  age = value.isNotEmpty ? int.tryParse(value) : null;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                updateUser();
              },
              child: Text(
                'Save',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                backgroundColor: Colors.deepOrange,
                side: BorderSide(color: Colors.transparent),
                shadowColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
