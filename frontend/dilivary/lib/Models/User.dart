// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int id;
  final String username;
  final String email;
  final String userType;
  final String token;
  final int? age;
  final int? id_driving_license;
  final String phone_number;
  final String id_number;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.userType,
    required this.token,
    required this.age,
    required this.id_driving_license,
    required this.phone_number,
    required this.id_number,
  });

  // Factory constructor to create a User from JSON
  factory User.fromJson(Map<String, dynamic> json, String token, int userId) {
    return User(
      id: userId,
      username: json['username'],
      email: json['email'],
      userType: json['user_type'],
      token: token,
      age: json['age'] ?? 0,
      id_driving_license: json['id_driving_license'],
      phone_number: json['phone_number'],
      id_number: json['id_number'],
    );
  }

  // Method to login and get User information
  static Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:8000/api/login/'), // Replace with your backend URL
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final userId = data['id'];

      final userResponse = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/api/get/$userId/'), // Replace with your user info endpoint
        headers: {
          'Authorization': 'Token $token',
        },
      );

      if (userResponse.statusCode == 200) {
        final userData = jsonDecode(userResponse.body);
        return User.fromJson(userData, token, userId);
      } else {
        // Handle error
        return null;
      }
    } else {
      // Handle error
      return null;
    }
  }

  // Save user info locally
  Future<void> saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('userType', userType);
  if (age != null) {
    await prefs.setInt('age', age!);
  }
  if (id_driving_license != null) {
    await prefs.setInt('id_driving_license', id_driving_license!);
  }
    await prefs.setString('phone_number', phone_number);
    await prefs.setString('id_number', id_number);
  }

  // Retrieve user info from local storage
  static Future<User?> getUserFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authToken');
    final id = prefs.getInt('userId');
    final username = prefs.getString('username');
    final email = prefs.getString('email');
    final userType = prefs.getString('userType');
    final age = prefs.getInt('age') ?? 0;
    final id_driving_license = prefs.getInt('id_driving_license');
    final phone_number = prefs.getString('phone_number');
    final id_number = prefs.getString('id_number');

    if (token != null &&
        id != null &&
        username != null &&
        email != null &&
        phone_number != null &&
        id_number != null &&
        userType != null) {
      return User(
        token: token,
        id: id,
        username: username,
        email: email,
        userType: userType,
        age: age,
        id_driving_license: id_driving_license,
        phone_number: phone_number,
        id_number: id_number,
      );
    }
    return null;
  }

  // Logout method to clear local storage
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<User?> getUserInfo(String token, int userId) async {
    final userResponse = await http.get(
      Uri.parse(
          'http://127.0.0.1:8000/api/get/$userId/'), // Replace with your user info endpoint
      headers: {
        'Authorization': 'Token $token',
      },
    );

    if (userResponse.statusCode == 200) {
      final userData = jsonDecode(userResponse.body);
      return User.fromJson(userData, token, userId);
    } else {
      // Handle error
      return null;
    }
  }
}

var token = "";
var userId = 0;

