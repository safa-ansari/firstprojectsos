import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soskrunewproject/firstpage.dart';





class HomeScreen extends StatefulWidget {
 
 
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   final _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:() async => false,child: Scaffold(
        appBar: AppBar(title: Text('App Title'),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[200],),
        
        body: Container(
          
  
          child: Center(
            
            child: Text("Home Screen"),
            
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()async{
            await _auth.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
          },
          child: Icon(Icons.logout),
        ),
      ),
    );
  }
}
    