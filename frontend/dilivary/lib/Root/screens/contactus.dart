



import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _descriptionController = TextEditingController();
  String _contactType = 'Report';
  List<Map<String, String>> contactSubmissions = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Contact Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: const Text('Report'),
              leading: Radio<String>(
                value: 'Report',
                groupValue: _contactType,
                onChanged: (value) {
                  setState(() {
                    _contactType = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Problem'),
              leading: Radio<String>(
                value: 'Problem',
                groupValue: _contactType,
                onChanged: (value) {
                  setState(() {
                    _contactType = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Other'),
              leading: Radio<String>(
                value: 'Other',
                groupValue: _contactType,
                onChanged: (value) {
                  setState(() {
                    _contactType = value!;
                  });
                },
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Describe your issue',
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                contactSubmissions.add({
                  'type': _contactType,
                  'description': _descriptionController.text,
                });
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Contact submission sent')));
                _descriptionController.clear();
              },
              child: Text('Submit',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),),

              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
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
