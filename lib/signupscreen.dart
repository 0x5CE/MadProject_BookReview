import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'main.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorMessage;
  bool _obscurePassword = true;

  Future<void> _signUp() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text;

    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Signup success, do something with the user
      User user = userCredential.user;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MainAppScreen(isLoggedIn: true)),
      );

      if (user != null) {
        // Navigate to main app screen or perform other actions
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'ChapterChats',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(82, 137, 147, 1.0),
                Color.fromRGBO(173, 216, 230, 1.0),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        elevation: 8,
        toolbarHeight: 80,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.6, // Set width to 60% of screen width
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 200), // Add spacing above the text field
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Add spacing below the heading
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      style: TextStyle(
                        fontSize: 16,
                      ), // Adjust the text field font size
                    ),
                  ),
                  SizedBox(
                      height:
                          16), // Add spacing between the text field and password field
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword =
                                  !_obscurePassword; // Toggle password visibility
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      obscureText:
                          _obscurePassword, // Use the obscured password based on visibility
                      style: TextStyle(
                        fontSize: 16,
                      ), // Adjust the text field font size
                    ),
                  ),
                  SizedBox(height: 32), // Add spacing below the password field
                  ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      primary:
                          Colors.blue, // Change the button background color
                      onPrimary: Colors.white, // Change the button text color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Add border radius
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 16), // Adjust the button padding
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.6,
                          0), // Set the button width to 60% of screen width
                      elevation: 5, // Add elevation for a neumorphic effect
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
