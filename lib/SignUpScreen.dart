import 'package:flutter/material.dart';
import 'package:soskrunewproject/already.dart';
import 'package:soskrunewproject/LoginScreen.dart';





class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
           
            TextField(
              decoration: InputDecoration(
              hintText: "Your Number"),
              onChanged: (value) {},
            ),

            TextField(
              decoration: InputDecoration(
                hintText: "Password"
              )
            ,
              onChanged: (value) {},
            ),


            ElevatedButton(

              child:Text("LOGIN"),
              onPressed: () {},
            ),

            SizedBox(height: size.height * 0.03),

            AlreadyHaveAnAccountCheck(
              press: () {
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
    );
  }
}