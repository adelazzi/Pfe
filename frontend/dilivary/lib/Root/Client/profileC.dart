// ignore_for_file: file_names, use_key_in_widget_constructors, camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../Models/User.dart';
import '../screens/Edit_Password.dart';
import '../screens/contactus.dart';
import '../screens/edit_Profile.dart';
import '../screens/helpand seport.dart';
import '../screens/notification.dart';


class ProfileScreen_c extends StatefulWidget {
  @override
  State<ProfileScreen_c> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen_c> {
  User? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    User? fetchedUser = await User.getUserFromPreferences();
    setState(() {
      user = fetchedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80),
            Card(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      child: ClipOval(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/Avatar.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (user != null)
                      Text(
                        user!.username,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      )
                    else
                      Text('No user data found.'),
                    
                    if (user != null)
                      Text(
                        "${user!.email} | +213 ${user!.phone_number}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),
            ),
             const SizedBox(height: 20),
          Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfileScreen()), // Navigate to EditProfileScreen
                      );
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Edit Profile Information",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // Add functionality for showing notifications
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationScreen()));
                    },
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Notification",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _showLanguageDialog(context);
                      // Add functionality for changing language
                    },
                    icon: const Icon(
                      Icons.language_outlined,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Language",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => EditPasswordScreen() ),);
                      },
                    icon: const Icon(
                      Icons.security,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Security",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HelpSupportScreen()),
                       );
                    },
                    icon: const Icon(
                      Icons.help,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Help & Support",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUsScreen() ),);

                    },
                    icon: const Icon(
                      Icons.contact_support,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "Contact us",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
        ),
      ),
    );
  }
}


void _showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Arabic'),
              onTap: () {
                // Handle language selection
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('French'),
              onTap: () {
                // Handle language selection
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('English'),
              onTap: () {
                // Handle language selection
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}


