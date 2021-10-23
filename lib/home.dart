import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soskrunewproject/NavBar.dart';
import 'package:soskrunewproject/login.dart';


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
                MaterialPageRoute(builder: (context) => LoginScreen()
                
                )
                
                
                );
                 final SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.remove('uid');
          },
          child: Icon(Icons.logout),
        ),



        
      ),
    );

  } @override
  void initState() {
    super.initState();
    _getUserName();
  }
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map? data;
  var _userName;
   // ignore: non_constant_identifier_names
   final _Auth = FirebaseAuth.instance;
        Future<void> _getUserName() async {
          print('user id  ${_auth.currentUser!.uid}');
        _firestore
            .collection('users')
            .doc( _Auth.currentUser!.uid)
            .get()
            .then((value) {
          setState(() {
           
             var data = value.data();
             
             _userName = data?['phone'].toString();

            print('username is $_userName');
          });
        }).catchError((e){
           print(e.toString());
        });
      }
}
