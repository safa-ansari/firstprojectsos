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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Scaffold(
        
        body: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey[200],
       
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: FutureBuilder(
              future: _firebaseApp,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator(
                    
                  );
                return isLoggedIn
                    ? Details()
                    : otpSent
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: TextField(
                                    keyboardType: TextInputType.number, 
                                    maxLength: 6,
                                    controller: _otp,
                                    decoration: InputDecoration(
                                      hintText: "  Enter your OTP   ",
                                      hintStyle:
                                          TextStyle(color: Colors.black54),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      onSurface: Colors.white10,
                                      shadowColor: Colors.cyan[300],
                                      primary: Colors.cyan[900],
                                      padding:
                                          EdgeInsets.fromLTRB(70, 20, 70, 20)),
                                  onPressed: _verifyOTP,
                                  child: Text(" Sign In",
                                  style: TextStyle(
                                    fontSize: 17
                                  )),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: TextField(
                                      keyboardType: TextInputType.phone, 
                                      maxLength: 14,
                                      controller: _phoneNumber,
                                      decoration: InputDecoration(
                                        
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 2),
                                        hintText: " Enter your phone number",
                                        hintStyle:
                                            TextStyle(color: Colors.black54),
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        onSurface: Colors.white10,
                                        shadowColor: Colors.cyan[700],
                                        primary: Colors.cyan[900],
                                        padding: EdgeInsets.fromLTRB(
                                            70, 20, 70, 20)),
                                    onPressed: _sendOTP,
                                    child: Text("Send OTP",
                                    style: TextStyle(
                                      fontSize: 17,
                                    )

                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
              },
            ),
          ),
        ),
      ),
    );
  }
}
