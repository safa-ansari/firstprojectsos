import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:soskrunewproject/details.dart';
import 'package:soskrunewproject/home.dart';

class NavBar extends StatefulWidget {

 @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  void initState() {
    super.initState();
    _getUserName();
  }


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map? data;
  var _userName;
  var _profileUrl;
  var _url;
  var _email;
  final _auth = FirebaseAuth.instance;
  Future<void> _getUserName() async {
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
    } catch (e) {
      print(e.toString());
    }
  }









  Widget build(BuildContext context) 
  {
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

  State<StatefulWidget> createState() {
    // ignore: todo
    // TODO: implement createState
    throw UnimplementedError();
  }
}
