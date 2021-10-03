import 'package:flutter/material.dart';
import 'package:soskrunewproject/SignUpScreen.dart';
import 'package:soskrunewproject/already.dart';

class SignUpScreen extends StatelessWidget {
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
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            TextField(
              decoration: InputDecoration(hintText: "Your Number"),
              onChanged: (value) {},
            ),
            TextField(
              decoration: InputDecoration(hintText: "Password"),
              onChanged: (value) {},
            ),
            ElevatedButton(
              child: Text("SIGNUP"),
              onPressed: () {},
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            )
          ]
          )
          
          ),
        )
        );
  }
}
