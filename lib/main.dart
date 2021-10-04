import 'package:flutter/material.dart';
import 'package:soskrunewproject/firstpage.dart';
import 'package:firebase_core/firebase_core.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(MyApp());}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}