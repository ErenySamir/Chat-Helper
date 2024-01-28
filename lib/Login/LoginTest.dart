import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:flutterfirebase/auth_controller.dart';
import 'package:get/get.dart';

import '../Controller/AuthController.dart';

class LoginTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var EmailController = TextEditingController();
    var PasswordController = TextEditingController();

    AuthController controller = Get.put(AuthController());

    List<String> dropDown = ["User", "Helper"];
    String selectedState = "User";
    var password = '';
    var email = '';
    String emailErrorText = '';
    String passwordErrorText = '';
    final _formKey = GlobalKey<FormState>();
    bool isEmailValid(String email) {
      return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
    }

    void validateEmail(String value) {
      if (value.isEmpty) {
        Get.put(emailErrorText = 'Email is required');
      } else if (!isEmailValid(value)) {
        Get.put(emailErrorText = 'Enter a valid email address');
      } else {
        Get.put(emailErrorText = '');
      }
    }

    void validatePassword(String value) {
      if (value.isEmpty) {
        Get.put(passwordErrorText = 'Password is required');
      } else if (value.length < 6) {
        Get.put(
            passwordErrorText = 'Password must be at least 6 characters long');
      } else {
        Get.put(passwordErrorText = '');
      }
    }

    print('object');

    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
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
                  children: [
                    TextField(
                        controller: EmailController,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Email',
                        )),
                    TextField(
                        controller: PasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Enter Your password',
                        )),
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
                            Get.put(selectedState = newValue);
                          }
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          controller.register(EmailController.text.trim(),
                              PasswordController.text.trim());
                        },
                        child: Text("Sign Up"))
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
