import 'package:soskrunewproject/LoginScreen.dart';
import 'package:soskrunewproject/Register.dart';

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
              SizedBox(height: size.height * 0.20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onSurface: Colors.white10,
                    shadowColor: Colors.blueGrey[300],
                    primary: Colors.teal[300],
                    padding: EdgeInsets.fromLTRB(80, 10, 70, 10)),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
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
              SizedBox(height: size.height * 0.05),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    onSurface: Colors.white10,
                    shadowColor: Colors.blueGrey[300],
                    primary: Colors.teal[300],
                    padding: EdgeInsets.fromLTRB(60, 10, 60, 10)),
                child: Text(
                  "REGISTER",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
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
              
            ]
            ),
      ),
    )
    );
  }
}
