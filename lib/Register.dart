import 'package:flutter/material.dart';

import 'package:soskrunewproject/home.dart';
import 'package:soskrunewproject/otp.dart';
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
  final TextEditingController _controller = TextEditingController();
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
              "REGISTER",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                
                fontStyle: FontStyle.italic,
                fontSize: 30),
                ),
          
          

            SizedBox(height: size.height * 0.10),


            Container(
              child: Center(
                child: TextField(
                  decoration: InputDecoration(
                    hintText:"Enter Your Number",
                    contentPadding: EdgeInsets.all(1),
                    prefix:
                     Padding(padding: EdgeInsets.all(0),
                       child: Text('+91 ')),
                  
                  ),
                  maxLength: 15,
                  keyboardType: TextInputType.number,
                  controller: _controller,
                  onChanged: (value) {},
                ),
              ),
            ),
            SizedBox(height: size.height * 0.10),


            ElevatedButton(
               style: ElevatedButton.styleFrom(
                  onSurface: Colors.white10,
                  shadowColor: Colors.blueGrey[300],
                  primary: Colors.teal[300],
                  padding: EdgeInsets.fromLTRB(70, 12, 70, 12)),
              child: Text("SIGNUP",
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => OTPScreen(_controller.text)));
              },
            ),


            SizedBox(height: size.height * 0.03),


            AlreadyHaveAnAccountCheck(
              login: false,
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
            )
          ])),
    ));
  }
}
