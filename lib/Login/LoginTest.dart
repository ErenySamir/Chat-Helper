import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Pages/Chats/Chat.dart';
import '../Pages/Chats/ZegoChat.dart';


class LoginTest extends StatelessWidget{

  var _auth = FirebaseAuth.instance;
  var password = '';
  var Email = '';
  var emailLink;
  TextEditingController Name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController state = TextEditingController();
  var _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/login.jpg',
                fit: BoxFit.fitHeight,
              ),
            ),
            Center(
              child: SizedBox(width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: Name,
                    // onChanged: (value){
                    //   Name!;
                    // },
                    decoration: InputDecoration(
                        hintText: 'Enter Your Name' ,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10 ,
                          horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pink , width: 1
                            )
                        )
                    ),),
                ),
              ),
            ) ,
            Center(
              child: SizedBox(width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: type,
                    // onChanged: (value){
                    //   Name!;
                    // },
                    decoration: InputDecoration(
                        hintText: 'Enter Your type Helper or deaf' ,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10 ,
                          horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pink , width: 1
                            )
                        )
                    ),),
                ),
              ),
            ) ,
            Center(
              child: SizedBox(width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: state,
                    // onChanged: (value){
                    //   Name!;
                    // },
                    decoration: InputDecoration(
                        hintText: 'Available or not' ,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10 ,
                          horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pink , width: 1
                            )
                        )
                    ),),
                ),
              ),
            ) ,
            Center(
              child: SizedBox(width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (value){
                      Email= value;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter Your Email' ,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10 ,
                          horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.pink , width: 1
                            )
                        )
                    ),),
                ),
              ),
            ) ,
            SizedBox(height: 10),
            SizedBox(width: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value){
                    password= value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Your Password' ,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10 ,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.pink , width: 1
                          )
                      )
                  ),),
              ),
            ),
            SizedBox(height:60),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent.shade100,),
                  onPressed: () async {
                    await _auth.signInWithEmailAndPassword(email: Email, password: password);
                    if(_auth.currentUser !=null){
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Chat()));
                    }}, child: Text('Sign In') ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent.shade100),
                  onPressed: () async {
                    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
                    final credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth?.accessToken,
                      idToken: googleAuth?.idToken,
                    );
                    await FirebaseAuth.instance.signInWithCredential(credential);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ZegoChat()));

                  }, child: Text('Sign In With Gmail')),
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent.shade100,),
                  onPressed: () async {
                    _fireStore.collection("DataEntered").add({
                      // "sender": _auth.currentUser!.email,
                      "name" : Name.text.toString(),
                      "state" : state.text.toString(),
                      "type" : type.text.toString(),
                    });
                    await _auth.createUserWithEmailAndPassword(email: Email, password: password);
                    // if(_auth.currentUser = Emp) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ZegoChat()));
                  } , child: Text('Sign Up New') ),
            )
          ],),
      ),
    );
  }
}