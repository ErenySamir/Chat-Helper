import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation_project/Pages/Profile/ProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Pages/Call/Calls.dart';
import '../Pages/Chats/Chat.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  //shared prefrence to sheck if user loged in before or not
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  List<String> dropDown = ["User", "Helper"];
  String selectedState = "User";
  var auth = FirebaseAuth.instance;
  var password = '';
  var email = '';
  String emailErrorText = '';
  String passwordErrorText = '';
  final _formKey = GlobalKey<FormState>();

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
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Image.asset(
                'assets/images/login.jpg',
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            setState(() {
                              email = value;
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
                                color: Colors.brown,
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
                          textAlign: TextAlign.center,
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
                                color: Colors.brown,
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
                    //******************************************
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Please select login as:',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: DropdownButtonFormField<String>(
                        value: selectedState,
                        items: dropDown.map((String educationLevel) {
                          return DropdownMenuItem<String>(
                            value: educationLevel,
                            child: Text(educationLevel),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedState = newValue;
                            });
                          }
                        },
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (emailErrorText.isEmpty &&
                                passwordErrorText.isEmpty) {
                              try {
                                await auth.createUserWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                if (auth.currentUser != null) {
                                  //shared prefrence to sheck if user loged with same email  before or not
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  await prefs.setString('email',
                                      auth.currentUser!.email.toString());

                                  print("current User ${auth.currentUser}");
                                }
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => CallPage(),
                                //   ),
                                // );
                              } catch (e) {
                                print("Error: $e");
                              }
                            }
                          },
                          child: Text("Log In"),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (emailErrorText.isEmpty &&
                                passwordErrorText.isEmpty) {
                              try {
                                await auth.signInWithEmailAndPassword(
                                  email: email,
                                  password: password,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(),
                                  ),
                                );
                              } catch (errorinput) {
                                print("Error: $errorinput");
                              }
                            }
                          },
                          child: Text("Sign Up"),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            //ببيفتح الايميل بس
                            final GoogleSignInAccount? googleUser =
                                await GoogleSignIn().signIn();
                            //
                            final GoogleSignInAuthentication? googleAuth =
                                await googleUser?.authentication;
                            // Create a new credential
                            final credential = GoogleAuthProvider.credential(
                              accessToken: googleAuth?.accessToken,
                              idToken: googleAuth?.idToken,
                            );
                            await FirebaseAuth.instance
                                .signInWithCredential(credential);
                          },
                          child: Text("Sign In with goole"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
