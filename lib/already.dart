import 'package:flutter/material.dart';
import 'package:soskrunewproject/LoginScreen.dart';
import 'package:soskrunewproject/Register.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
        ),
        GestureDetector(
          onTap: () {
            login
                ? Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUpScreen();
                  }))
                : Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }));
          },
          child: Text(
            login ? " Register " : " Login ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
