import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/signupscreen.dart';
// import 'login_screen.dart';
import 'loginscreen.dart';
import 'main.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

// import 'signup_screen.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLoggedIn = false;

  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void signup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  void logout() {
    setState(() {
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    if (isLoggedIn) {
      screen = MainAppScreen();
    } else {
      screen = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              depth: 10,
              intensity: 1,
              lightSource: LightSource.topLeft,
            ),
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(16),
                    backgroundColor: Colors.lightBlue),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.concave,
              depth: 10,
              intensity: 1,
              lightSource: LightSource.topLeft,
            ),
            child: SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: signup,
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(16),
                    backgroundColor: Colors.lightBlue),
                child: Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
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
      body: Center(
        child: screen,
      ),
    );
  }
}
