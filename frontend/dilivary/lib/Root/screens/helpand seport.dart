

import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help & Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'How the app works',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'This app was created in 2024 by Elaidat Mohamed Redha & Azzi Adel. It allows you to manage your profile, change your password, and get help & support.',
              ),
              SizedBox(height: 20),
              Text(
                'Functions of buttons',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Edit Profile Information: Edit your profile details\n'
                    'Notification: View notifications\n'
                    'Language: Change the app language\n'
                    'Security: Change your password\n'
                    'Help & Support: View help and support information\n'
                    'Contact us: Get in touch with support',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
