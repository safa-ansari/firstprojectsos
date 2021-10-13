import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:soskrunewproject/credentials.dart';

class DatabaseFinal {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    FirebaseAuth _auth = FirebaseAuth.instance;

  Future createUser(Userinfo user) async {
    String retVal = 'error';
    try {
      await _firestore.collection('users').doc(_auth.currentUser!.uid.toString()).set({
        'fullname': user.FullName,
        'email': user.email,
        'phone': user.phoneNumber,
        'accountcreated': user.timestamp,
        
      });
      retVal = "Success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
