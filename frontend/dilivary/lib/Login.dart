import 'package:flutter/material.dart';
import 'package:dilivary/main.dart';
import 'package:dilivary/Signup.dart';
import 'package:dilivary/Home.dart';
import 'package:dilivary/Home_Admin.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPage extends StatelessWidget {
  String NameAdmin = "Administrateur@app.pfe";
  String PwdAdmin = "Password123";

  @override
  Widget build(BuildContext context) {
    String enteredEmail = ""; // Variable to store entered email
    String enteredPassword = ""; // Variable to store entered password

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Vector.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => MAIN()));
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Login to your account",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              // Email input field
              TextField(
                onChanged: (value) {
                  enteredEmail = value; // Update entered email
                },
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Password input field
              TextField(
                onChanged: (value) {
                  enteredPassword = value; // Update entered password
                },
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Verification function buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Implement email verification function
                    },
                    child: Text("Verify Email"),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Implement password verification function
                    },
                    child: Text("Verify Password"),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              // Login button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Colors.black),
                ),
                child: MaterialButton(
                  onPressed: () {
                    // Check if entered email and password match admin credentials
                    if (enteredEmail == NameAdmin &&
                        enteredPassword == PwdAdmin) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeAdminPage()));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                  minWidth: double.infinity,
                  height: 60,
                  color: Colors.deepOrangeAccent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Sign up button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              // Google login button
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  // Implement Google login functionality with verification
                  // After verification, navigate to HomePage
                },
                text: "Login with Google",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
