import 'package:flutter/material.dart';
import 'package:dilivary/main.dart';
import 'package:dilivary/Root/Signup.dart';
import 'package:dilivary/Root/Client/homa_page.dart';
import 'package:dilivary/Home_Admin.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../tools/socialmedia.dart';
import '../tools/underline.dart';

class LoginPage extends StatefulWidget {

  LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var NameAdmin = "Administrateur@app.pfe";
  var PwdAdmin = "Password123";

  String enteredEmail = "";
  String enteredPassword = "";



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
                  enteredEmail = value; // Update entered email
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              // Password input field
              TextField(
                onChanged: (value) {
                  enteredPassword = value; // Update entered password
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
                    // Check if entered email and password match admin credentials
                    if (enteredEmail == NameAdmin &&
                        enteredPassword == PwdAdmin) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeAdminPage()));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SocialMedia(img: "assets/icons/google.svg",),
                  SocialMedia(img: "assets/icons/facebook.svg",),
                  SocialMedia(img: "assets/icons/whatsapp.svg",),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
