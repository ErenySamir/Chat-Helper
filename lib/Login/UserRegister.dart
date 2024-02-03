// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation_project/Home/HomePage.dart';
import 'package:graduation_project/Pages/Deaf/Deaf.dart';
import 'package:graduation_project/Pages/Helper/Helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../Pages/Chats/Chat.dart';
import '../Pages/Chats/ZegoChat.dart';
import 'LogIn.dart';

class UserRegister extends StatefulWidget {
  @override
  State<UserRegister> createState() {
    return UserRegisterState();
  }
}

//
class UserRegisterState extends State<UserRegister> {
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(),
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LogIn()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.blue[900]),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Image.asset(
                "assets/images/loginpage.jpg",
                width: 390,
                height: 300,
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8, top: 10),
                child: TextField(
                  textAlign: TextAlign.start,
                  // controller: Name,
                  decoration: InputDecoration(
                      hintText: 'Enter Your Name',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      border: new OutlineInputBorder(
                          borderRadius:
                              new BorderRadius.all(Radius.circular(30))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue.shade900, width: 1))),
                ),
              ),
            ),
//
            SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8, top: 10),
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
              width: 400,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8, top: 10),
                child: TextField(
                  // obscureText: textAlignrue,
                  textAlign: TextAlign.start,
                  // onChanged: (value) {
                  //   password = value;
//                   },
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
              width: 400,
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 8, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Login As',
                    style: TextStyle(color: Colors.blue.shade900,fontSize: 30),
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                            fillColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.blue.shade900;
                                }
                                return Colors.blue.shade900;
                              },
                            ),
                            value: 'Deaf',
                            groupValue: role,
                            onChanged: (value) {
                              setState(() {
                                role = value as String?;
                              });
                            },
                          ),
                          Text(
                            'Deaf',
                            style: TextStyle(color: Colors.blue.shade900,fontSize: 20),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                      ),
                      Row(
                        children: [
                          Radio(
                            fillColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.blue.shade900;
                                }
                                return Colors.blue.shade900;
                              },
                            ),
                            value: 'helper',
                            groupValue: role,
                            onChanged: (value) {
                              setState(() {
                                role = value as String?;
                              });
                            },
                          ),
                          Text(
                            'Helper',
                            style: TextStyle(color: Colors.blue.shade900,fontSize: 20),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: [
                          Radio(
                            fillColor: MaterialStateColor.resolveWith(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.blue.shade900;
                                }
                                return Colors.blue.shade900;
                              },
                            ),
                            value: 'User',
                            groupValue: role,
                            onChanged: (value) {
                              setState(() {
                                role = value as String?;
                              });
                            },
                          ),
                          Text(
                            'User',
                            style: TextStyle(color: Colors.blue.shade900,fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 40,width: 40,),
            SizedBox(width: 400,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                    ),
                    onPressed: () async {
                      await _auth.createUserWithEmailAndPassword(
                          email: Email, password: password);
                      if (_auth.currentUser != null) {
                        // shared prefrence to save login
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.setString(
                            'email', _auth.currentUser!.email.toString());
                        await prefs.setString(
                          'name',
                          Name.text.toString(),
                        );
                        print(_auth.currentUser!.email.toString() + " email");
                        print(Name.text.toString() + " name");

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
                            "type": 'helper',
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
                    child: Text('Sign Up', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,width: 30,),
            // SizedBox(width: 300,
            //   child: Center(
            //     child: Padding(
            //       padding: const EdgeInsets.all(20.0),
            //       child: ElevatedButton(
            //           style: ElevatedButton.styleFrom(
            //               backgroundColor: Colors.blue.shade900),
            //           onPressed: () async {
            //             final GoogleSignInAccount? googleUser =
            //             await GoogleSignIn().signIn();
            //             final GoogleSignInAuthentication? googleAuth =
            //             await googleUser?.authentication;
            //             final credential = GoogleAuthProvider.credential(
            //               accessToken: googleAuth?.accessToken,
            //               idToken: googleAuth?.idToken,
            //             );
            //             await FirebaseAuth.instance
            //                 .signInWithCredential(credential);
            //
            //             Navigator.push(context,
            //                 MaterialPageRoute(builder: (context) => ZegoChat()));
            //           },
            //           child: Text(
            //             'Sign up With Gmail',
            //             style: TextStyle(color: Colors.white),
            //           )),
            //     ),
            //   ),
            // ),

          ],
        ),
      ),
    );
  }
}
