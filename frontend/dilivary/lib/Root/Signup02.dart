import 'package:dilivary/Root/Signup.dart';
import 'package:flutter/material.dart';
import 'package:dilivary/HomeD.dart';

class SignupV extends StatefulWidget {
  const SignupV({Key? key}) : super(key: key);

  @override
  _SignupVState createState() => _SignupVState();
}

class _SignupVState extends State<SignupV> {
  String? _selectedVehicleType;
  String? _vehicleModel;
  String? _vehicleColor;
  String? _vehicleLicensePlate;
  String? _vehicleRegistration;
  String? _vehicleInsurance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Vector.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    iconSize: 24.0,
                    color: Colors.black,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: EdgeInsets.all(0),
                    constraints: BoxConstraints(),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "let's know your vehicle information",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(height: 20.0),
                      inputFile(
                        label: 'Vehicle Type',
                        hint: 'Select Vehicle Type',
                        onChanged: (value) {
                          setState(() {
                            _selectedVehicleType = value;
                          });
                        },
                        items: [
                          DropdownMenuItem<String>(
                            value: 'Car',
                            child: Text('Car',
                                style: TextStyle(color: Colors.black)),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Motorcycle',
                            child: Text('Motorcycle',
                                style: TextStyle(color: Colors.black)),
                          ),
                          DropdownMenuItem<String>(
                            value: 'Other',
                            child: Text('Other',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      inputFile(
                        label: 'Vehicle Model',
                        hint: 'Enter Vehicle Model',
                        onChanged: (value) {
                          setState(() {
                            _vehicleModel = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      inputFile(
                        label: 'Vehicle Color',
                        hint: 'Enter Vehicle Color',
                        onChanged: (value) {
                          setState(() {
                            _vehicleColor = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      inputFile(
                        label: 'License Plate Number',
                        hint: 'Enter License Plate Number',
                        onChanged: (value) {
                          setState(() {
                            _vehicleLicensePlate = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      inputFile(
                        label: 'Vehicle Registration',
                        hint: 'Enter Vehicle Registration',
                        onChanged: (value) {
                          setState(() {
                            _vehicleRegistration = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      inputFile(
                        label: 'Vehicle Insurance Number',
                        hint: 'Enter Vehicle Insurance Number',
                        onChanged: (value) {
                          setState(() {
                            _vehicleInsurance = value;
                          });
                        },
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          // Handle uploading vehicle picture
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(double.infinity, 40),
                        ),
                        child: Text('Upload Vehicle Picture',
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          // Handle uploading license plate picture
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(double.infinity, 40),
                        ),
                        child: Text('Upload License Plate Picture',
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          // Handle uploading registration document picture
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          minimumSize: Size(double.infinity, 40),
                        ),
                        child: Text('Upload Registration Document Picture',
                            style: TextStyle(color: Colors.black)),
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          // Perform signup process with vehicle information
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeDeliveryPage()));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0),
                          ),
                          minimumSize: Size(double.infinity, 65),
                          backgroundColor:
                              const Color.fromARGB(255, 253, 104, 58),
                        ),
                        child: Text('Sign up',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      ),
                      SizedBox(height: 40.0),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class inputFile extends StatelessWidget {
  final String label;
  final String hint;
  final ValueChanged<String>? onChanged;
  final List<DropdownMenuItem<String>>? items;

  const inputFile({
    Key? key,
    required this.label,
    required this.hint,
    this.onChanged,
    this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        DropdownButtonFormField<String>(
          value: null,
          onChanged: (value) {
            onChanged?.call(value!);
          },
          items: items,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            labelText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
