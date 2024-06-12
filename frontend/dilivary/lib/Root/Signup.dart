// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:dilivary/Root/Login.dart';
import 'package:dilivary/Root/Signup02.dart';
import '../Models/User.dart';
import 'Client/homa_page.dart';
import 'Driver/HomeD.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool isDeliveryPerson = false;
  User? mainUser;
  // Create TextEditingControllers for the form fields
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _ageController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _idlicenseController = TextEditingController();
  final _idnumberController = TextEditingController();

  Future<void> _login(enteredEmail, enteredPassword) async {
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

  Future<void> signup() async {
    // Validate the form
    if (_formKey.currentState?.validate() ?? false) {
      // Check if passwords match
      if (_passwordController.text == _confirmPasswordController.text) {
        final data = {
          'username': _fullNameController.text,
          'email': _emailController.text,
          'phone_number': _phoneNumberController.text,
          'age': _ageController.text,
          'password': _passwordController.text,
          'id_driving_license':
              isDeliveryPerson ? int.tryParse(_idlicenseController.text) : null,
          'id_number': _idnumberController.text,
          'user_type': isDeliveryPerson ? 'Driver' : 'Client',
        };

        // Make the API call
        final response = await http.post(
          Uri.parse(
              'http://127.0.0.1:8000/api/register/'), // Replace with your API endpoint
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(data),
        );

        // Handle the response
        if (response.statusCode == 201) {
          _login(_emailController.text, _passwordController.text);
          DataPassword().data = _passwordController.text;
          if (isDeliveryPerson) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupV()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage_C()),
            );
          }
        } else {
          // Handle error
          final errorResponse = json.decode(response.body);
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text(errorResponse.toString() ?? 'An error occurred'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Show an error message if passwords do not match
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Passwords do not match'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                      SizedBox(height: 17),
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
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      inputFile(
                        label: "Full Name",
                        hint: "Enter your full name",
                        controller: _fullNameController,
                      ),
                      inputFile(
                        label: "Id number",
                        hint: "Enter your Id number",
                        controller: _idnumberController,
                      ),
                      inputFile(
                        label: "Email",
                        hint: "Enter your email",
                        controller: _emailController,
                      ),
                      inputFile(
                        label: "Phone Number",
                        hint: "Enter your phone number",
                        controller: _phoneNumberController,
                      ),
                      inputFile(
                        label: "Age",
                        hint: "Enter your age",
                        controller: _ageController,
                      ),
                      inputFile(
                        label: "Password",
                        hint: "Enter your password",
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      inputFile(
                        label: "Confirm Password",
                        hint: "Confirm your password",
                        controller: _confirmPasswordController,
                        obscureText: true,
                      ),
                      if (isDeliveryPerson)
                        inputFile(
                          label: "ID License",
                          hint: "Enter your ID License",
                          controller: _idlicenseController,
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
                          if (_validateFormFields()) {
                            signup();
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
                                builder: (context) => LoginPage()),
                          );
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
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Vector.jpg"),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  bool _validateFormFields() {
    return _formKey.currentState?.validate() ?? false;
  }
}

Widget inputFile({
  required String label,
  required String hint,
  required TextEditingController controller,
  bool obscureText = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.5),
    child: Column(
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
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: (value) {
            if (label == 'Full Name') {
              if (value == null ||
                  value.isEmpty ||
                  value.contains(RegExp(r'[^\w\s]'))) {
                return 'Full name incorrect format';
              }
            } else if (label == 'Email') {
              if (value == null ||
                  value.isEmpty ||
                  !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                return 'Email incorrect format';
              }
            } else if (label == 'Phone Number') {
              if (value == null ||
                  value.isEmpty ||
                  !RegExp(r'^(05|06|07)[0-9]{8}$').hasMatch(value)) {
                return 'Phone number incorrect format';
              }
            } else if (label == 'Age') {
              if (value == null ||
                  value.isEmpty ||
                  int.tryParse(value) == null ||
                  int.parse(value)! < 18 ||
                  int.parse(value)! > 70) {
                return 'Age must be between 18 and 70';
              }
            } else if (label == 'Password') {
              if (value == null || value.isEmpty || value.length < 8) {
                return 'Password must be at least 8 characters long ';
              }
            } else if (label == 'Confirm Password') {
              if (value != controller.text) {
                return 'Passwords do not match';
              }
            } else if (label == 'Id number') {
              if (value == null ||
                  value.isEmpty ||
                  value.length != 9 ||
                  int.tryParse(value) == null) {
                return 'ID must be 9 digits';
              }
            } else if (label == 'ID License') {
              if (value!.isEmpty ||
                  value.length != 9 ||
                  int.tryParse(value) == null) {
                return 'ID must be 9 digits';
              }
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            labelText: hint,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          keyboardType:
              label == 'Phone Number' || label == 'Age' || label == 'ID'
                  ? TextInputType.number
                  : TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
      ],
    ),
  );
}
