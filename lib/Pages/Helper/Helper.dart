import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Helper extends StatefulWidget {
  @override
  State<Helper> createState() {
    return HelperState();
  }
}

class HelperState extends State<Helper> {
  bool state = false;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String helperName = "";

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    getRecipes();
  }

  Future<void> initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      helperName = prefs.getString("name") ?? "";
    });
  }

  // Save state in Firestore
  getRecipes() async {
    var response = await fireStore.collection("State").get();
    List<String> state = [];

    response.docs.forEach((doc) {
      setState(() {
        state.add(doc.id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text('Select Available or Not Available for Helper'),
        backgroundColor: Colors.blueGrey.shade50,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select your State ",
              style: TextStyle(
                color: Colors.black,
                decorationStyle: TextDecorationStyle.wavy,
              ),
            ),
            SizedBox(height: 20),
            ToggleSwitch(
              minWidth: 120.0,
              initialLabelIndex: state ? 0 : 1,
              cornerRadius: 60.0,
              activeFgColor: Colors.green.shade700,
              inactiveBgColor: Colors.white60,
              inactiveFgColor: Colors.white60,
              totalSwitches: 2,
              labels: ['Available', 'Not Available'],
              activeBgColors: [
                [Colors.black87],
                [Colors.black87]
              ],
              onToggle: (index) async {
                setState(() {
                  state = index == 0;
                  print('Switched to: ${state ? "Available" : "Not Available"}');
                });

                // Save the state and helper name to Firestore
                try {
                  await fireStore.collection('State').add({
                    'state': state,
                    'helperName': helperName,
                  });
                  print('State and helper name saved to Firestore!');
                } catch (e) {
                  print('Error saving state and helper name to Firestore: $e');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}