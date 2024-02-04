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
import 'LogIn.dart';

class UserRegister extends StatefulWidget {
  @override
  State<UserRegister> createState() {
    return UserRegisterState();
  }
}

class UserRegisterState extends State<UserRegister> {
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  var _auth = FirebaseAuth.instance;
  var password = '';
  var Email = '';
  var emailLink;
  TextEditingController Name = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController state = TextEditingController();
  var _fireStore = FirebaseFirestore.instance;
  String? role;
  String? enteredName;
//Validation for mail and password
  final _formKey = GlobalKey<FormState>();
  String emailErrorText = '';
  String passwordErrorText = '';
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

  bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
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
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    textAlign: TextAlign.start,
                    onChanged: (value) {
                      setState(() {
                        enteredName = value; // Update the entered name value
                      });
                    },
                    // controller: Name,
                    decoration: InputDecoration(
                      hintText: 'Enter Your Name',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(20)),
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
          //
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)),
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
                          borderRadius:
                          BorderRadius.all(Radius.circular(20)),
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
                width: 100,
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Login As',
                      style: TextStyle(color: Colors.blue.shade900,fontSize: 15),
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
                        // Row(
                        //   children: [
                        //     Radio(
                        //       fillColor: MaterialStateColor.resolveWith(
                        //         (Set<MaterialState> states) {
                        //           if (states.contains(MaterialState.selected)) {
                        //             return Colors.blue.shade900;
                        //           }
                        //           return Colors.blue.shade900;
                        //         },
                        //       ),
                        //       value: 'User',
                        //       groupValue: role,
                        //       onChanged: (value) {
                        //         setState(() {
                        //           role = value as String?;
                        //         });
                        //       },
                        //     ),
                        //     Text(
                        //       'User',
                        //       style: TextStyle(color: Colors.blue.shade900,fontSize: 20),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 70,width: 70,),
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
                          await prefs.setString("email", _auth.currentUser!.email.toString());
                          await prefs.setString("name", enteredName ?? '');
                          print(_auth.currentUser!.email.toString() + " email");
                          print(enteredName.toString() + " name");
          
                          if (role == 'Deaf') {
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
                           } //else if (role == 'user') {
                          //   await _fireStore.collection("DataEntered").add({
                          //     "email": _auth.currentUser!.email,
                          //     "name": Name.text.toString(),
                          //     "type": 'user',
                          //     "time": DateTime.now(),
                          //   });
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context) => HomePage()),
                          //   );
                          // }
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
          
              ]
              ),
              ),
                ],
              ),
        ),));
  }
}