import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soskrunewproject/NavBar.dart';
import 'package:soskrunewproject/details.dart';
import 'package:soskrunewproject/login.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  var _url ;
  Map? data;
  var _userName;
  var _profileUrl;
  var _email;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(

drawer: FutureBuilder(
    future: _getUserName(),
    builder: (BuildContext context,AsyncSnapshot snapshot){
      if (snapshot.hasData){
        return Drawer(
     child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("$_userName"),
            accountEmail: Text('$_email'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child:   _profileUrl != null
                            ? Image.network(
                                '$_profileUrl',



                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                )
                  : Image.asset('assets/clock.png'),


                
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('My Credentials '),
            onTap: (){
              Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context)
             => Details()),
          );
            }
          )
          ,
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Policies'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            title: Text('Exit'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => HomeScreen(),
          ),
        ],
      ),
    );
      }
      else{
        return CircularProgressIndicator();
      }
    }
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
 
   // ignore: non_constant_identifier_names
   final _Auth = FirebaseAuth.instance;
      Future _getUserName() async {
    print(
        'user id  ${_auth.currentUser!.uid}');
    var ppId = _auth.currentUser!.uid;
    print('this is ppid $ppId');
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("images/$ppId");
    _url = await ref.getDownloadURL();

    _profileUrl = _url.toString();
    print('this is url $_profileUrl');
    try {
      var doc = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      data = doc.data();
      _userName = data?['fullname'];
      
      _email = data?['email'];
      return doc.data();
    } catch (e) {
      print(e.toString());
    }
  }
}
