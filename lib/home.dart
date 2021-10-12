import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soskrunewproject/NavBar.dart';
import 'package:soskrunewproject/firstpage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(

        drawer: NavBar(
          





        ),

        appBar: AppBar(
          title: Text('HOME SCREEN'),
          centerTitle: true,
          backgroundColor: Colors.lightBlue[900],
        ),

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/back4.jpg"),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.9), BlendMode.dstATop),
                fit: BoxFit.cover),
          ),
        ),


        floatingActionButton: FloatingActionButton(
          focusColor: Colors.lightGreen,
          onPressed: () async {
            await _auth.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()));
          },
          child: Icon(Icons.logout),
        ),
      ),
    );
  }
}
