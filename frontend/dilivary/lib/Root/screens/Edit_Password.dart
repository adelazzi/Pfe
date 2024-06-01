// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart'; // Add this dependency for generating random strings
import 'package:shared_preferences/shared_preferences.dart';
import '../Driver/HomeD.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? newPassword;
  String? oldPassword;

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
        body: json.encode({"password": newPassword}),
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
      } else {
        // Failed to update user
        String errorMessage;
        try {
          final errorResponse = json.decode(response.body);
          errorMessage = errorResponse['error'] ?? 'Failed to update user';
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
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/Vector.jpg"), fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _oldPasswordController,
              decoration: InputDecoration(
                labelText: 'Old Password',
              ),
              obscureText: true,
            ),
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_newPasswordController.text ==
                    _confirmPasswordController.text) {
                  setState(() {
                    newPassword = _newPasswordController.text;
                    oldPassword = _oldPasswordController.text;
                  });
                  updateUser();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords do not match')));
                }
              },
              child: Text(
                'Change',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                backgroundColor: Colors.deepOrange,
                side: BorderSide(color: Colors.transparent),
                shadowColor: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                _showForgotPasswordDialog(context);
              },
              child: Text('Forgot Password?',
                  style: TextStyle(
                      color: Colors.cyan,
                      fontSize: 17,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ForgotPasswordDialog();
      },
    );
  }
}

class ForgotPasswordDialog extends StatefulWidget {
  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  String? verificationCode;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Forgot Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          TextField(
            controller: _codeController,
            decoration: InputDecoration(
              labelText: 'Verification Code',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            verificationCode = randomAlphaNumeric(6);
            // Send the verification code to the user's email
            // Implement your email sending logic here
            print(
                'Verification code sent to ${_emailController.text}: $verificationCode');
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Verification code sent to your email')));
          },
          child: Text(
            'Send Code',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_codeController.text == verificationCode) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ResetPasswordScreen(email: _emailController.text)),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Invalid verification code')));
            }
          },
          child: Text(
            'Next',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            side: BorderSide(color: Colors.transparent),
            shadowColor: Colors.black,
          ),
        ),
      ],
    );
  }
}

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  ResetPasswordScreen({required this.email});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? newPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _newPasswordController,
              decoration: InputDecoration(
                labelText: 'New Password',
              ),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_newPasswordController.text ==
                    _confirmPasswordController.text) {
                  setState(() {
                    newPassword = _newPasswordController.text;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password updated successfully')));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeDeliveryPage()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Passwords do not match')));
                }
              },
              child: Text(
                'Update',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
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
