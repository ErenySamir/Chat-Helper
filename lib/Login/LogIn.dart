import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduation_project/Controller/ControllerGetx.dart';
import 'package:graduation_project/Pages/Settiing/Setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../Pages/Chats/Chat.dart';
import '../main.dart';

class LogIn extends StatelessWidget {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  var auth = FirebaseAuth.instance;
 // auth.createUserWithEmailAndPassword(email: "email", password: password)
  var email='';
  var  password='';

  List<String> dropDown = ["User", "Helper"];
  String selectedState = "User";
  bool isMale = true;
  bool isFemale = true;
  bool termsAccepted = false;

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String emailErrorText = '';
  String passwordErrorText = '';

  bool isEmailValid(String email) {
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
  ControllerGetx controller = Get.put(ControllerGetx());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade50,
        title: Text("Log In"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        Expanded(
        child: Image.asset(
          'assets/images/login.jpg',
          fit: BoxFit.fitHeight,
        ),
      ),
      // SizedBox(height: 2),
      Padding(
        padding: const EdgeInsets.all(1.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: TextFormField(
                  onChanged: (value) {
                      email = value;
                  },
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    } else if (!isEmailValid(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
              ),
              if (emailErrorText.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    emailErrorText,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(

                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      labelText: 'Password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
              ),
              if (passwordErrorText.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    passwordErrorText,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
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

                    // if (newValue != null) {
                    //   setState(() {
                    //     selectedState = newValue;
                    //   });
                    // }
                  },
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Please select gender:',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: isMale,
                          onChanged: (bool? value) {
                            // if (value != null) {
                            //   setState(() {
                            //     isMale = value;
                            //     isFemale = !value;
                            //   });
                            // }
                          },
                        ),
                        Text("Male"),
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  // Adjust the spacing between radio buttons
                  Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: isFemale,
                        onChanged: (bool? value) {
                          // if (value != null) {
                          //   setState(() {
                          //     isMale = !value;
                          //     isFemale = value;
                          //   });
                          // }
                        },
                      ),
                      Text("Female"),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Checkbox(
                      value: termsAccepted,
                      onChanged: (bool? value) {
                        // if (value != null) {
                        //   setState(() {
                        //     termsAccepted = value;
                        //   });
                        // }
                      },
                    ),
                  ),
                  Text("Accept Terms"),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      Obx(()=>Text(controller.change.value));

                      if (emailErrorText.isEmpty && passwordErrorText.isEmpty) {
                        try {
                          await auth.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          if (auth.currentUser != null) {
                            //shared prefrence to sheck if user loged with same email  before or not
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setString('email', auth.currentUser!.email.toString());

                            print("current User ${auth.currentUser}");
                          }
                        } catch (e) {
                          print("Error: $e");
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
                      if (emailErrorText.isEmpty && passwordErrorText.isEmpty) {
                        try {
                          await auth.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          //move to other page
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => Setting(),
                          //   ),
                          // );

                        } catch (errorinput) {
                          print("Error: $errorinput");
                        }
                      }
                    },
                    child: Text("Sign In"),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      //ببيفتح الايميل بس
                      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                      //
                      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
                      // Create a new credential
                      final credential = GoogleAuthProvider.credential(
                        accessToken: googleAuth?.accessToken,
                        idToken: googleAuth?.idToken,
                      );
                      await FirebaseAuth.instance.signInWithCredential(credential);
                    },
                    child: Text("Sign In with goole"),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    ]
    ),
    )
    );
  }
}
