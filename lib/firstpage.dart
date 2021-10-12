import 'package:flutter/material.dart';
import 'package:soskrunewproject/otp.dart';

class WelcomeScreen extends StatelessWidget {
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
    // This size provide us total height and width of our screen
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[800],
          title: Center(child: Text("Welcome Page")),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/back3.jpg"),
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.8), BlendMode.dstATop),
                    fit: BoxFit.cover),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              " WELCOME TO THE APP",
                              style: TextStyle(
                                
                                  fontStyle: FontStyle.italic,
                                  fontSize: 35.0,
                                  color: Colors.orange[700],
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: size.height * 0.30),
                          
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                onSurface: Colors.white10,
                                shadowColor: Colors.blueGrey[300],
                                primary: Colors.teal[300],
                                padding: EdgeInsets.fromLTRB(70, 20, 70, 20)),
                            child: Text(
                              "REGISTER  ",
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OTPScreen(_controller.text),
                                ),
                              );
                            },
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
