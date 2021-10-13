import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soskrunewproject/credentials.dart';
import 'package:soskrunewproject/database.dart';
import 'package:soskrunewproject/home.dart';

class Details extends StatefulWidget {
  const Details({ Key? key }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

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
      
      body:
      Container(
        decoration: BoxDecoration(
         image: DecorationImage(
             image: AssetImage("assets/back2.png"),
             
        
              fit: BoxFit.fill),
       ),
       width: double.infinity,
          child: Column(
               children: [
           
                 Expanded(
             child: Container(
                 width: double.infinity,
                 decoration:  BoxDecoration(
                   
                    
                     borderRadius: const BorderRadius.horizontal(),
                       ),
                 margin: const EdgeInsets.only(top: 40),
                 child: SingleChildScrollView(
                   child: Column(
                     children: [
                       
                       
                       const SizedBox( height: 20),

                       Container(
                         
                           
                           alignment: Alignment.topLeft,
                           margin: const EdgeInsets.only(left: 2, bottom: 10),
                           

                             
                           )
                           ,
                           SizedBox(
                         height: 50),
                       
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
                                 const Icon(Icons.person_outlined),
                                 Expanded(
                                   child: Container(
                                     margin: const EdgeInsets.only(left: 5),
                                     child: TextField(
                                       controller:userName ,
                                       maxLines: 1,
                                       decoration: const InputDecoration(
                                         hintText: "Enter Full Name ",
                                         border: InputBorder.none,
                                       ),
                                     ),
                                   ),
                                 ),
                               ],
                             )
                             ),
                       
                       
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
                                         hintText:" Enter your E-mail",
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
                                 const Icon(Icons.phone_android),
                                 Expanded(
                                   child: Container(
                                     margin: const EdgeInsets.only(left: 5),
                                     child: TextField(
                                       controller: userPhone,
                                       maxLines: 1,
                                       decoration: const InputDecoration(
                                         hintText:"Phone Number ",
                                         border: InputBorder.none,
                                       ),
                                     ),
                                   ),
                                 ),
                               ],
                             )
                             ),
                       
                       const SizedBox(
                         height: 35,
                       ),
                       
                         ElevatedButton(
                           onPressed: () async {
                             Userinfo user = Userinfo(email: userEmail.text,phoneNumber: userPhone.text,FullName: userName.text);
                              DatabaseFinal().createUser(user); 
                              final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                              sharedPreferences.setString('email', userEmail.text);
                              sharedPreferences.setString('phone', userPhone.text);




                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                           },
                           style: ElevatedButton.styleFrom(
                               onPrimary: Colors.green[800],
                               shadowColor: Colors.greenAccent,
                               elevation: 18,
                               padding: EdgeInsets.zero,
                               shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.circular(20)
                                   )
                                   ),

                                   

                           child: Ink(
                             decoration: BoxDecoration(
                                 color: Colors.blue[300],
                                  
                                 borderRadius: BorderRadius.horizontal(),
                                 boxShadow: [
                                   BoxShadow(
                                    color: Colors.blueGrey,
                                 
                                 
                                 )]
                                 ),
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




  
    