// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/Home/HomePage.dart';
import 'package:graduation_project/Pages/Deaf/Deaf.dart';
import 'package:graduation_project/Pages/Helper/Helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Pages/Chats/Chat.dart';
import '../Pages/Chats/ZegoChat.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() {
    return LogInState();
  }
}

//
class LogInState extends State<LogIn> {
  var _auth = FirebaseAuth.instance;
  var password = '';
  var Email = '';
  var emailLink;
  TextEditingController Name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController state = TextEditingController();
  var _fireStore = FirebaseFirestore.instance;
  String? role;

//
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/loginpage.jpg",
                width: 250,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              width: 300,
              child: Text(
                  'We are so happy to Have you here. We hope you Have enjoyable time away.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 150,
            ),
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    Email = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Your Email',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue.shade900, width: 1))),
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter Your Password',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue.shade900, width: 1))),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: SizedBox(
                width: 300,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade900,
                      ),
                      onPressed: () async {
                        await _auth.signInWithEmailAndPassword(
                            email: Email, password: password);
                        if (_auth.currentUser != null) {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Chat()));
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
