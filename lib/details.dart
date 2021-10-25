import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soskrunewproject/credentials.dart';
import 'package:soskrunewproject/database.dart';
import 'package:soskrunewproject/home.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';


class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late String url;
  bool isUploading = true;
  var ppId;
  String? profileUrl;
  final picker = ImagePicker();

  final imagePicker = ImagePicker();
  XFile? file;
  File? upfile;

  Future<String> uploadImageToFirebase(imageFile) async {
    String url = "";
    var uid= _auth.currentUser!.uid;
    FirebaseStorage storage = FirebaseStorage.instance;
    ppId = Uuid().v4();
    Reference ref = storage.ref().child("images/$uid");
    UploadTask uploadTask = ref.putFile(upfile!);
    await uploadTask.whenComplete(() async {
      url = await ref.getDownloadURL();
    });
    print('this picture  $url');
    return url;
  }

  uploadImage(userId) async {
    setState(() {
      isUploading = true;
    });
    String imageUrl = await uploadImageToFirebase(file);
    setState(() {
      isUploading = false;
      profileUrl = imageUrl.toString();
      print(
          'this issssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss $profileUrl');
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Image Uploaded!"),
      ),
    );
  }

  final userName = TextEditingController();
  final userEmail = TextEditingController();
  final userPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(" Details ")),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/back2.png"), fit: BoxFit.fill),
        ),
        width: double.infinity,
        child: Column(
          children: [
             Container(
              margin: const EdgeInsets.only(top: 50),
              child:
                CircleAvatar(
                  radius: 50,
                  child: ClipOval(
                    child: profileUrl != null ?Image.network(
                      '$profileUrl',
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ): Image.asset('assets/clock.png'),
                  ),
                ),
              
            ),
            Expanded(
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.horizontal(),
                  ),
                  margin: const EdgeInsets.only(top: 40),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 2, bottom: 8),
                        ),
                        SizedBox(height: 10),
                        Container(
                            width: double.infinity,
                            height: 60,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green.shade800, width: 1),
                                color: Colors.white,
                                borderRadius: const BorderRadius.horizontal()),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.person_outlined),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: TextField(
                                      controller: userName,
                                      maxLines: 1,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Full Name ",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            width: double.infinity,
                            height: 70,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.green.shade800, width: 1),
                                color: Colors.white,
                                borderRadius: const BorderRadius.horizontal()),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.email_outlined),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 14),
                                    child: TextFormField(
                                      controller: userEmail,
                                      maxLines: 1,
                                      decoration: const InputDecoration(
                                        hintText: " Enter your E-mail",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          // color: Colors.red,
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 22),
                          
                            child: Text(
                              "  Select profile picture",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white60,
                                letterSpacing: 1,
                              ),
                            ),
                          
                        ),
                        Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                                child: Row(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    50.0, 0.0, 0.0, 0.0),
                                child: FloatingActionButton(
                                  onPressed: () async {
                                    file = await imagePicker.pickImage(
                                        source: ImageSource.camera);
                                    setState(() {
                                      upfile = File(file!.path);
                                    });

                                    print(
                                        'this iss $file');
                                  },
                                  child: Icon(
                                      Icons.camera_outlined), //camera image
                                  backgroundColor: Colors.blueGrey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    40.0, 0.0, 0.0, 0.0),
                                child: FloatingActionButton(
                                  onPressed: () {},
                                  child: Icon(Icons
                                      .add_photo_alternate_outlined), //gallery image
                                  backgroundColor: Colors.blueGrey,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    40.0, 0.0, 0.0, 0.0),
                                child: FloatingActionButton(
                                    child: Icon(Icons.upload_file),
                                    backgroundColor: Colors.blueGrey,
                                    onPressed: () {
                                      setState(() {
                                        uploadImage(_auth.currentUser!.uid);
                                      });
                                    }),
                              ),
                            ])))
                            
                            
                            
                            
                            ,
                    const SizedBox(
                          height: 30,
                        ),

                        ElevatedButton(
                          onPressed: () async {
                            Userinfo user = Userinfo(
                              uid: _auth.currentUser!.uid.toString(),
                              email: userEmail.text,
                              phoneNumber: userPhone.text,
                              FullName: userName.text,
                            );
                            DatabaseFinal().createUser(user);
                            final uIdSP = _auth.currentUser!.uid.toString();
                            final SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString('uid', uIdSP);
                            sharedPreferences.setString(
                                'userName', userName.toString());
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                              onPrimary: Colors.green[800],
                              shadowColor: Colors.greenAccent,
                              elevation: 18,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.horizontal(),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blueGrey,
                                  )
                                ]),
                            child: Container(
                              width: 200,
                              height: 50,
                              alignment: Alignment.center,
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
