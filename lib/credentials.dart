import 'package:cloud_firestore/cloud_firestore.dart';

class Userinfo{
  String? uid;
  String? email;
  String? phoneNumber;
  // ignore: non_constant_identifier_names
  String? FullName;
  Timestamp? timestamp;
 // ignore: non_constant_identifier_names
 Userinfo({this.uid,this.email,this.phoneNumber,this.FullName,this.timestamp});

}