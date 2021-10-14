import 'package:flutter/material.dart';
import 'package:soskrunewproject/details.dart';

import 'package:soskrunewproject/home.dart';

class NavBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    

    
    
    return Drawer(



      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("_userName"),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
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
}
