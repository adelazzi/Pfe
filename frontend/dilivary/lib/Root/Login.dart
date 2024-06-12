// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:dilivary/Root/Client/homa_page.dart';
import 'package:dilivary/Home_Admin.dart';
import '../Models/User.dart';
import '../tools/socialmedia.dart';
import '../tools/underline.dart';
import 'Driver/HomeD.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String adminuser = "admin";
  String adminpassword = "admin";
  String enteredEmail = "";
  String enteredPassword = "";

  Future<void> _login() async {
    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both email and password')),
      );
      return;
    }

    final mainUser = await User.login(enteredEmail, enteredPassword);

    if (mainUser != null) {
      await mainUser.saveToPreferences();
      DataPassword().data = enteredPassword;
      DataId().data = mainUser.id;
      print(
          'Login successful: ${mainUser.token}, ${mainUser.userType}, ${mainUser.id}, ${mainUser.phone_number}, ${mainUser.id_driving_license}');
      if (mainUser.userType == 'Client') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage_C()),
        );
      }
      if (mainUser.userType == 'Driver') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeDeliveryPage()),
        );
      }
    } else {
      print('Login failed');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed, please check your credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Vector.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Login to your account",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              // Email input field
              TextField(
                onChanged: (value) {
                  setState(() {
                    enteredEmail = value; // Update entered email
                  });
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              // Password input field
              TextField(
                onChanged: (value) {
                  setState(() {
                    enteredPassword = value; // Update entered password
                  });
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              // Verification function buttons

              // Login button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black),
                ),
                child: MaterialButton(
                  onPressed: () {
                    if (adminuser == enteredEmail &&
                        adminpassword == enteredPassword) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => HomeAdminPage()),
                      );
                    } else {
                      _login();
                    }
                  },
                  minWidth: double.infinity,
                  height: 60,
                  color: Colors.deepOrangeAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              or_(),
              // Google login button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SocialMedia(
                    img: "assets/icons/google.svg",
                  ),
                  SocialMedia(
                    img: "assets/icons/facebook.svg",
                  ),
                  SocialMedia(
                    img: "assets/icons/whatsapp.svg",
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
