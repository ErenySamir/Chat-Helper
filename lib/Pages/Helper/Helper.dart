import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Helper extends StatefulWidget {
  @override
  State<Helper> createState() {
    return HelperState();
  }
}

class HelperState extends State<Helper> {
  bool isInstructionAvailable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Select your State"
            ,  style: TextStyle(  color: Colors.black,
                decorationStyle: TextDecorationStyle.wavy,),

            ),
            SizedBox(height: 20),
            ToggleSwitch(
              minWidth: 120.0,
              initialLabelIndex: isInstructionAvailable ? 0 : 1,
              cornerRadius: 60.0,
              activeFgColor: Colors.greenAccent.shade700,
              inactiveBgColor: Colors.white60,
              inactiveFgColor: Colors.white60,
              totalSwitches: 2,
              labels: ['Available', 'Not Available'],
              activeBgColors: [[Colors.white], [Colors.white]],
              onToggle: (index) {
                setState(() {
                  isInstructionAvailable = index == 0;
                  print('Switched to: ${isInstructionAvailable ? "Available" : "Not Available"}');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}