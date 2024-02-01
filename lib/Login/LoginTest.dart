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

class LoginTest extends StatefulWidget {
  @override
  State<LoginTest> createState() {
    return LoginTestState();
  }
}

class LoginTestState extends State<LoginTest> {
  var _auth = FirebaseAuth.instance;
  var password = '';
  var Email = '';
  var emailLink;
  TextEditingController Name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController state = TextEditingController();
  var _fireStore = FirebaseFirestore.instance;
  String? role;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  'assets/images/login.jpg',
                  // width: 120,
                  // height: 120,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Center(
              child: SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: Name,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Name',
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black12, width: 1))),
                  ),
                ),
              ),
            ),

            Center(
              child: SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextField(
                    textAlign: TextAlign.center,
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black12, width: 1))),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
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
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black12, width: 1))),
                ),
              ),
            ),
            Center(
              child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Select Login As'),
                  RadioListTile(
                    title: Text('Deaf'),
                    value: 'deaf',
                    groupValue: role,
                    onChanged: (value) {
                      setState(() {
                        role = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Helper'),
                    value: 'helper',
                    groupValue: role,
                    onChanged: (value) {
                      setState(() {
                        role = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('User'),
                    value: 'user',
                    groupValue: role,
                    onChanged: (value) {
                      setState(() {
                        role = value as String?;
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
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
                  child: Text('Sign In')),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade100),
                  onPressed: () async {
                    final GoogleSignInAccount? googleUser =
                        await GoogleSignIn().signIn();
                    final GoogleSignInAuthentication? googleAuth =
                        await googleUser?.authentication;
                    final credential = GoogleAuthProvider.credential(
                      accessToken: googleAuth?.accessToken,
                      idToken: googleAuth?.idToken,
                    );
                    await FirebaseAuth.instance
                        .signInWithCredential(credential);

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ZegoChat()));
                  },
                  child: Text(
                    'Sign In With Gmail',
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                  ),
                  onPressed: () async {
                    await _auth.createUserWithEmailAndPassword(
                        email: Email, password: password);
                    if (_auth.currentUser != null) {
                      //shared prefrence to save login
                      SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      await prefs.setString('email', _auth.currentUser!.email.toString());
                      await prefs.setString('name', Name.text.toString(),);
                      print(_auth.currentUser!.email.toString()+" email");
                      print(Name.text.toString()+" name");

                      if (role == 'deaf') {
                        await _fireStore.collection("DataEntered").add({
                          "email": _auth.currentUser!.email,
                          "name": Name.text.toString(),
                          "type": 'deaf',
                          "time": DateTime.now(),
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Deaf()),
                        );
                      } else if (role == 'helper') {
                        await _fireStore.collection("DataEntered").add({
                          "email": _auth.currentUser!.email,
                          "name": Name.text.toString(),
                          "type":'helper' ,
                          "time": DateTime.now(),
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Helper()),
                        );
                      } else if (role == 'user') {
                        await _fireStore.collection("DataEntered").add({
                          "email": _auth.currentUser!.email,
                          "name": Name.text.toString(),
                          "type": 'user',
                          "time": DateTime.now(),
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    }
                  },
                  child: Text('Sign Up New')),
            )
          ],
        ),
      ),
    );
  }
}
