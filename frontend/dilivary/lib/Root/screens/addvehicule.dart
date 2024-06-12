import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io'; // For File class
import 'package:image_picker/image_picker.dart'; // For ImagePicker class

import 'package:flutter/material.dart';

class AddVehicleInfoScreen extends StatefulWidget {
  int? id_driving_license;
  AddVehicleInfoScreen({required this.id_driving_license,Key? key}) : super(key: key);

  @override
  _SignupVState createState() => _SignupVState();
}

class _SignupVState extends State<AddVehicleInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
// Create TextEditingControllers for the form fields
  final _matriculeController = TextEditingController();
  final _idlicenseController = TextEditingController();
  final _maxwighteController = TextEditingController();
  final _vehiculemodelController = TextEditingController();
  String? _selectedVehicleType;
  String? _selectedVehicleColor;
  String? _selectedVehicleSize;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> createvehicule() async {
    if (_formKey.currentState?.validate() ?? false) {
      final data = {
        'type': _selectedVehicleType,
        'color': _selectedVehicleColor,
        'max_weight': int.tryParse(_maxwighteController.text),
        'model': _vehiculemodelController.text,
        'matricule': int.tryParse(_matriculeController.text),
        'id_driving_license': widget.id_driving_license,
        'max_size': _selectedVehicleSize,
      };

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://127.0.0.1:8000/vehicule/create/'),
      );

      request.fields
          .addAll(data.map((key, value) => MapEntry(key, value.toString())));

      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('photo', _image!.path));
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final vehicle = json.decode(responseBody);
        Navigator.pop(
          context,
        );
      } else {
        final errorResponse = await response.stream.bytesToString();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(errorResponse ?? 'An error occurred'),
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
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please fill in all required fields'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      body: 
      SafeArea(
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
                        "Add your vehicule",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 17),
                      Text(
                        "You created your Account welcome with us Add your Vehicule information captin",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      // Matricule
                      inputFile(
                        label: "Matricule",
                        hint: "Enter your Matricule",
                        controller: _matriculeController,
                      ),
                      // Max wight
                      inputFile(
                        label: "Max Wighte",
                        hint: "Enter your Max Wighte",
                        controller: _maxwighteController,
                      ),
                      // vehicule Model
                      inputFile(
                        label: "vehicule Model",
                        hint: "Enter your vehicule Model",
                        controller: _vehiculemodelController,
                      ),

                      //type
                      _buildDropdownField(
                        label: 'Vehicle Type',
                        hint: 'Select Vehicle Type',
                        value: _selectedVehicleType,
                        onChanged: (value) {
                          setState(() {
                            _selectedVehicleType = value!;
                          });
                        },
                        items: [
                          DropdownMenuItem(value: 'CAR', child: Text('CAR')),
                          DropdownMenuItem(value: 'VAN', child: Text('VAN')),
                          DropdownMenuItem(
                              value: 'BICYCLE', child: Text('BICYCLE')),
                          DropdownMenuItem(
                              value: 'MOTORCYCLE', child: Text('MOTORCYCLE')),
                        ],
                      ),
                      SizedBox(height: 15),
                      // Size
                      _buildDropdownField(
                        label: 'Vehicle Size',
                        hint: 'Select Vehicle Size',
                        value: _selectedVehicleSize,
                        onChanged: (value) {
                          setState(() {
                            _selectedVehicleSize = value!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                              value: 'Large', child: Text('Large')),
                          DropdownMenuItem(
                              value: 'Medium', child: Text('Medium')),
                          DropdownMenuItem(
                              value: 'Small', child: Text('Small')),
                          DropdownMenuItem(
                              value: 'Very Large', child: Text('Very Large')),
                        ],
                      ),
                      SizedBox(height: 15),
                      // Color
                      _buildDropdownField(
                        label: 'Vehicle Color',
                        hint: 'Select Vehicle Color',
                        value: _selectedVehicleColor,
                        onChanged: (value) {
                          setState(() {
                            _selectedVehicleColor = value!;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                              value: 'Black', child: Text('Black')),
                          DropdownMenuItem(value: 'Grey', child: Text('Grey')),
                          DropdownMenuItem(
                              value: 'White', child: Text('White')),
                        ],
                      ),
                      SizedBox(height: 15),

                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          color: Colors.grey[200],
                          height: 200,
                          width: double.infinity,
                          child: _image == null
                              ? Center(child: Text('Tap to select image'))
                              : Image.file(_image!, fit: BoxFit.cover),
                        ),
                      ),

                      MaterialButton(
                        onPressed: () {
                          if (_validateFormFields()) {
                            createvehicule();
                          }
                        },
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Text(
                          "Add vehicule",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 7),
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
      )
      ,);
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
            if (label == 'Matricule') {
              if (value == null ||
                  value.isEmpty ||
                  !RegExp(r'^[0-9]{9}$').hasMatch(value)) {
                return 'Matricule incorrect format';
              }
            } else if (label == 'Id License') {
              if (value == null ||
                  value.isEmpty ||
                  !RegExp(r'^[0-9]{9}$').hasMatch(value)) {
                return 'Id License incorrect format';
              }
            } else if (label == 'Max Wighte') {
              if (value == null ||
                  value.isEmpty ||
                  !RegExp(r'^[0-9]+$').hasMatch(value)) {
                return 'Max Wighte incorrect format';
              }
            } else if (label == 'vehicule Model') {
              if (value == null ||
                  value.isEmpty ||
                  value.contains(RegExp(r'[^\w\s]'))) {
                return 'vehicule Model incorrect format';
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
          keyboardType: label == 'Matricule' ||
                  label == 'Id License' ||
                  label == 'Max Wighte'
              ? TextInputType.number
              : TextInputType.text,
          textInputAction: TextInputAction.next,
        ),
      ],
    ),
  );
}

Widget _buildDropdownField({
  required String label,
  required String hint,
  required String? value,
  required ValueChanged<String?> onChanged,
  required List<DropdownMenuItem<String>> items,
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
        DropdownButtonFormField<String>(
          value: items.any((item) => item.value == value) ? value : null,
          onChanged: onChanged,
          items: items,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            labelText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select a $label';
            }
            return null;
          },
        ),
      ],
    ),
  );
}
