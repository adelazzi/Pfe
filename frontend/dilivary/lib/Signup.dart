// ignore_for_file: file_names, use_super_parameters, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:dilivary/Login.dart';
// Import the main page
import 'package:dilivary/Home.dart'; // Import the HomePage page
import 'package:dilivary/Signup02.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isDeliveryPerson =
      false; // State variable to track if the user is a delivery person

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
                maxHeight: 600), // Adjust the max height as needed
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        "Sign up",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      Text(
                        "Create an account, it's free",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Let's start with your information ",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      inputFile(
                          label: "Full name", hint: "Enter your full name"),
                      inputFile(label: "Email", hint: "Enter your email"),
                      inputFile(
                          label: "Phone number",
                          hint: "Enter your phone number "),
                      inputFile(label: "Password", hint: "Enter your password"),

                      inputFile(
                          label: "Confirm password",
                          hint: "Confirm your password"),

                      // Show additional fields if the user is a delivery person
                      if (isDeliveryPerson)
                        Column(
                          children: [
                            inputFile(label: "ID", hint: "Enter your ID"),
                          ],
                        ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            "Are you a delivery person? ",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Checkbox(
                            value: isDeliveryPerson,
                            onChanged: (value) {
                              setState(() {
                                isDeliveryPerson = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      MaterialButton(
                        onPressed: () {
                          if (isDeliveryPerson) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupV()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                        },
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 7),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(
                          "Already have an account? Sign in",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Vector.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget inputFile({required String label, required String hint}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
      SizedBox(
        height: 5,
      ),
      TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
          labelText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.deepOrangeAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
      ),
    ],
  );
}
