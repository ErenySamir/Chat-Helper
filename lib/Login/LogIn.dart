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

  final _formKey = GlobalKey<FormState>();
  String emailErrorText = '';
  String passwordErrorText = '';

  bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        emailErrorText = 'Email is required';
      });
    } else if (!isEmailValid(value)) {
      setState(() {
        emailErrorText = 'Enter a valid email address';
      });
    } else {
      setState(() {
        emailErrorText = '';
      });
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      setState(() {
        passwordErrorText = 'Password is required';
      });
    } else if (value.length < 6) {
      setState(() {
        passwordErrorText = 'Password must be at least 6 characters long';
      });
    } else {
      setState(() {
        passwordErrorText = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 150,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            setState(() {
                              Email = value;
                              validateEmail(value);
                            });
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Email',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue.shade900,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (emailErrorText.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          emailErrorText,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          textAlign: TextAlign.start,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                              validatePassword(value);
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter Your Password',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.blue.shade900,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (passwordErrorText.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          passwordErrorText,
                          style: TextStyle(color: Colors.red),
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
                                await prefs.getString("email", );
                                await prefs.getString("name",);
                                print(_auth.currentUser!.email.toString() + " email");
                                print(  " name");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Chat(),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}