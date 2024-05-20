import 'package:flutter/material.dart';
import 'package:dilivary/Root/Login.dart';
// Import the main page
import 'package:dilivary/Root/Signup02.dart';

import 'Client/homa_page.dart';

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
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      "Sign up",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
                      label: "Full Name",
                      hint: "Enter your full name",
                    ),
                    inputFile(
                      label: "Email",
                      hint: "Enter your email",
                    ),
                    inputFile(
                      label: "Phone Number",
                      hint: "Enter your phone number",
                    ),
                    inputFile(
                      label: "Age",
                      hint: "Enter your age",
                    ),
                    inputFile(
                      label: "Password",
                      hint: "Enter your password",
                      obscureText: true, // Password field should be obscured
                    ),
                    inputFile(
                      label: "Confirm Password",
                      hint: "Confirm your password",
                      obscureText:
                          true, // Confirm password field should be obscured
                    ),
                    // Show additional fields if the user is a delivery person
                    if (isDeliveryPerson)
                      Column(
                        children: [
                          inputFile(
                            label: "ID",
                            hint: "Enter your ID",
                          ),
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
                        // Perform form validation
                        bool isValid = _validateFormFields();
                        if (isValid) {
                          // Navigate to appropriate page based on conditions
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
    );
  }
}

Widget inputFile({
  required String label,
  required String hint,
  TextEditingController? controller,
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
        SizedBox(
          height: 5,
        ),
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
                  int.parse(value) < 18 ||
                  int.parse(value) > 70) {
                return 'Age must be between 18 and 70';
              }
            } else if (label == 'Password') {
              if (value == null ||
                  value.isEmpty ||
                  value.length < 8 ||
                  !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                      .hasMatch(value)) {
                return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number, and one special character';
              }
            } else if (label == 'Confirm Password') {
              if (value != controller!.text) {
                return 'Passwords do not match';
              }
            } else if (label == 'ID') {
              if (value == null ||
                  value.isEmpty ||
                  value.length != 9 ||
                  int.tryParse(value) == null) {
                return 'ID must be 9 digits';
              }
            }
            return null;
          },
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
                color: Colors.deepPurple,
                width: 2,
              ),
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

bool _validateFormFields() {
  print('Validating form fields...');
  // Implement your validation logic here
  // For demonstration purposes, returning true
  return true;
}
