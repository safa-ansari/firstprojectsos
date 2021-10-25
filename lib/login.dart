import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
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
  String? phoneNumber;
  PhoneNumber number = PhoneNumber(isoCode: 'IND');
  late String verificationId;
  late UserCredential authCredential;
  var otp;
  bool userIsLoggedIn = false;
  bool showLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
       try {
       await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get().then((value) {
            if (value.exists){
                userIsLoggedIn = true;
            }
            });

      
    } catch (e) {
      print(e.toString());
    }
  
        
      
      print('this is ssssssssssssssssssssssssssssssssss user is logged in $userIsLoggedIn');
   
      if (authCredential.user != null &&
          userIsLoggedIn) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } else if (authCredential.user != null  ) {
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
              width: double.infinity,
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.green,
                        blurRadius: 10,
                        offset: Offset(1, 1)),
                  ],
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 1),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    phoneNumber = number.phoneNumber;
                    print(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                  ),
                  ignoreBlank: false,
                  searchBoxDecoration: InputDecoration(
                    fillColor: Colors.white,
                  ),
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  initialValue: number,
                  selectorTextStyle: TextStyle(color: Colors.black),
                  textFieldController: phoneController,
                  formatInput: false,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: OutlineInputBorder(),
                  onSaved: (PhoneNumber number) {
                    print('On Saved: $number');
                  },
                ),
              ),
            ),
        
        TextButton(
          onPressed: () async {
            setState(() {
              showLoading = true;
            });

            await _auth.verifyPhoneNumber(
              phoneNumber: phoneNumber.toString(),
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
        Spacer(flex: 1,),
        Text('Enter Otp',style: TextStyle(fontSize: 40),),
        Spacer(
          flex: 1,
        ),
        OTPTextField(
          length: 6,
          width: MediaQuery.of(context).size.width,
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldWidth: 55,
          style: TextStyle(color: Colors.black),
          fieldStyle: FieldStyle.box,
          outlineBorderRadius: 15,
          otpFieldStyle:OtpFieldStyle(
            backgroundColor: Colors.white,
            borderColor: Colors.black
          ) ,
          onChanged: (pin) {
            print("Changed: " + pin);
          },
          onCompleted: (pin) {
            print("Completed: " + pin);
            otp = pin;
          },
        ),
        SizedBox(
          height: 16,
        ),
        TextButton(
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otp);

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
