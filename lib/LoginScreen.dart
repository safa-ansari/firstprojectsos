import 'package:flutter/material.dart';
import 'package:soskrunewproject/already.dart';

import 'package:soskrunewproject/home.dart';






class LoginScreen extends StatelessWidget {


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
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 30),
              ),
              SizedBox(height: size.height * 0.10),
             
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                hintText: "Your Number"),
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.05),
              TextField(
                decoration: InputDecoration(hintText: "Password",
                
                contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.15),
              


              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onSurface: Colors.white10,
                  shadowColor: Colors.blueGrey[300],
                  primary: Colors.teal[300],
                  padding: EdgeInsets.fromLTRB(70, 12, 70, 12)),
                child:Text("LOGIN"),
                onPressed: () {
                 },
              ),

              SizedBox(height: size.height * 0.03),

              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Home();
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