import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:soskrunewproject/database.dart';
import 'package:soskrunewproject/details.dart';
import 'package:soskrunewproject/home.dart';
import 'package:soskrunewproject/credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  // late String pinAuth;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String uid = '';
  String finalEmail = '';

  late String verificationId;
  late UserCredential authCredential;

  bool showLoading = false;
  // OurUser _user = OurUser();
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    setState(() {
      finalEmail = obtainedEmail.toString();
    });
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      uid = (_auth.currentUser)!.uid;

      setState(() {
        showLoading = false;
      });
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final uisp = sharedPreferences.getString('uid');

      print('uid is $uisp');
      if (authCredential.user != null &&
          _auth.currentUser!.uid.toString() == uisp) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (authCredential.user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Details()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      setState(() {
        showLoading = false;
      });

      // _scaffoldKey.currentState!
      // .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<String> signUpUser(
      String email, String password, String fullName) async {
    String retVal = "error";
    Userinfo _user = Userinfo();
    try {
      _user.uid = uid;
      _user.email = authCredential.user!.uid;
      _user.FullName = fullName;
      String _returnString = await DatabaseFinal().createUser(_user);
      if (_returnString == "success") retVal = "success";
    } on PlatformException catch (e) {
      retVal = e.message.toString();
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  getMobileFormWidget(context) {
    return Column(
      children: [
        SizedBox(height: 160),
        Container(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.phone_android),
            Expanded(
              child: Container(
                child: TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: const InputDecoration(
                    hintText: "Enter your Phone Number ",
                  ),
                ),
              ),
            ),
          ],
        )),
        SizedBox(height: 30),
        TextButton(
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: phoneController.text,
              verificationCompleted: (phoneAuthCredential) async {
                setState(() {
                  showLoading = false;
                });
                signInWithPhoneAuthCredential(phoneAuthCredential);
              },
              verificationFailed: (verificationFailed) async {
                setState(() {
                  showLoading = false;
                });
                // _scaffoldKey.currentState.showSnackBar(
                // SnackBar(content: Text(verificationFailed.message)));
              },
              codeSent: (verificationId, resendingToken) async {
                setState(() {
                  showLoading = false;
                  currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
                  this.verificationId = verificationId;
                });
              },
              codeAutoRetrievalTimeout: (verificationId) async {},
            );
          },
          child: Ink(
            decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: 150,
              height: 40,
              alignment: Alignment.center,
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        Spacer(
          flex: 2,
        ),
        TextField(
          controller: otpController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: " Enter OTP ",
          ),
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text);

            signInWithPhoneAuthCredential(phoneAuthCredential);
          },
          child: Ink(
            decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: 150,
              height: 40,
              alignment: Alignment.center,
              child: const Text(
                'Verify',
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Registeration',
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.greenAccent[400],
          centerTitle: true,
        ),
        key: _scaffoldKey,
        body: Container(
         
          child: showLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                  ? getMobileFormWidget(context)
                  : getOtpFormWidget(context),
          padding: const EdgeInsets.all(12),
        ));
  }
}
