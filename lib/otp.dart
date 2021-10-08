import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soskrunewproject/details.dart';

class OTPScreen extends StatelessWidget {
  late final String phone;
  OTPScreen(this.phone);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<FirebaseApp> _firebaseApp;
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _otp = TextEditingController();

  bool isLoggedIn = false;
  bool otpSent = false;
  late String uid;
  late String _verificationId;

  void _verifyOTP() async {
    // we know that _verificationId is not empty
    final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: _otp.text);

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser != null) {
        setState(() {
          isLoggedIn = true;
          uid = FirebaseAuth.instance.currentUser!.uid;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void _sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: _phoneNumber.text,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    setState(() {
      otpSent = true;
    });
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    setState(() {
      _verificationId = verificationId;
      otpSent = true;
    });
  }

  void codeSent(String verificationId, [int? a]) {
    setState(() {
      _verificationId = verificationId;
      otpSent = true;
    });
  }

  void verificationFailed(FirebaseAuthException exception) {
    print(exception.message);
    setState(() {
      isLoggedIn = false;
      otpSent = false;
    });
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
    if (FirebaseAuth.instance.currentUser != null) {
      setState(() {
        isLoggedIn = true;
        uid = FirebaseAuth.instance.currentUser!.uid;
      });
    } else {
      print("Failed to Sign In");
    }
  }

  @override
  void initState() {
    super.initState();
    _firebaseApp = Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: FutureBuilder(
          future: _firebaseApp,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator();
            return isLoggedIn
                ? Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            onSurface: Colors.white10,
                            shadowColor: Colors.blueGrey[300],
                            primary: Colors.teal[300],
                            padding: EdgeInsets.fromLTRB(60, 10, 60, 10)),
                        child: Text(
                          "Successful Login , Click Here ",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Details()));
                        }))
                : otpSent
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _otp,
                            decoration: InputDecoration(
                              hintText: "Enter your OTP",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                onSurface: Colors.white10,
                                shadowColor: Colors.blueGrey[300],
                                primary: Colors.teal[300],
                                padding: EdgeInsets.fromLTRB(60, 10, 60, 10)),
                            onPressed: _verifyOTP,
                            child: Text("Sign In"),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextField(
                            controller: _phoneNumber,
                            decoration: InputDecoration(
                              hintText: "Enter your phone number",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                onSurface: Colors.white10,
                                shadowColor: Colors.blueGrey[300],
                                primary: Colors.teal[300],
                                padding: EdgeInsets.fromLTRB(60, 10, 60, 10)),
                            onPressed: _sendOTP,
                            child: Text("Send OTP"),
                          ),
                        ],
                      );
          },
        ),
      ),
    );
  }
}
