import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soskrunewproject/firstpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:soskrunewproject/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth',
        theme: ThemeData(),
        home: InitializerWidget());
  }
}

class InitializerWidget extends StatefulWidget {
  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  late FirebaseAuth _auth;

  // ignore: unused_field
  late User _user;

  bool isLoading = true;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    _auth = FirebaseAuth.instance;

    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _auth.currentUser != null
            ? HomeScreen()
            : WelcomeScreen();
  }
}
