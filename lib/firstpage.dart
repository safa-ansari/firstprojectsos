import 'package:soskrunewproject/LoginScreen.dart';
import 'package:soskrunewproject/SignUpScreen.dart';

import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  " WELCOME TO THE APP",
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 30.0,
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: size.height * 0.05),
              ElevatedButton(
                child: Text("LOGIN"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
                },
              ),
              ElevatedButton(
                child: Text("REGISTER"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SignUpScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
