import 'package:flutter/material.dart';

class LogIn extends StatefulWidget {
  @override
  State<LogIn> createState() {
    return LogInState();
  }
}

class LogInState extends State<LogIn> {
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                    if (newValue != null) {
                      setState(() {
                        selectedState = newValue;
                      });
                    }
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
                            if (value != null) {
                              setState(() {
                                isMale = value;
                                isFemale = !value;
                              });
                            }
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
                          if (value != null) {
                            setState(() {
                              isMale = !value;
                              isFemale = value;
                            });
                          }
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
                        if (value != null) {
                          setState(() {
                            termsAccepted = value;
                          });
                        }
                      },
                    ),
                  ),
                  Text("Accept Terms"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: ElevatedButton(
                  onPressed: termsAccepted
                      ? () {
                    if (_formKey.currentState!.validate()) {
                      String email = _emailController.text;
                      String password = _passwordController.text;

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => HomeScreen(
                      //       firstName: email,
                      //       Password: password,
                      //     ),
                      //   ),
                      // );
                    }
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade50,
                    padding: EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  child: Text("Log In"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: ElevatedButton(
                      onPressed: termsAccepted
                          ? () {
                        if (_formKey.currentState!.validate()) {
                          String email = _emailController.text;
                          String password = _passwordController.text;

                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HomeScreen(
                          //       firstName: email,
                          //       Password: password,
                          //     ),
                          //   ),
                          // );
                        }
                      }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade50,
                        padding: EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      child: Text("Log Out"),
                    ),
                  )
                ],

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
