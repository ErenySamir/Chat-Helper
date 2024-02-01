import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Pages/Chats/ZegoChat.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Deaf extends StatefulWidget {
  @override
  State<Deaf> createState() {
    return DeafState();
  }
}

class DeafState extends State<Deaf> {
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  List<String> documentIds = [];
  List<Map<String, dynamic>> userDataList = [];
  String nameshared = "";

  @override
  void initState() {
    super.initState();
    getResponse();
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameshared = prefs.getString("name") ?? "";
    });
  }

  getResponse() async {
    var response = await fireStore.collection("State").get();

    response.docs.forEach((doc) {
      setState(() {
        documentIds.add(doc.id);
        userDataList.add(doc.data() as Map<String, dynamic>);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SafeArea(
        child: ListView.builder(
          itemCount: documentIds.length,
          itemBuilder: (context, index) {
            String documentId = documentIds[index];
            Map<String, dynamic> userData = userDataList[index];
            String helperName = userData['helperName']; // Replace 'helperName' with the key for the helper's name in your data structure

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 4.0,
                  ),
                ),
                child: ListTile(
                  title: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    // Print the helper's name
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      'Helper Name: $helperName',
                    ),
                  ),
                  subtitle: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ZegoChat()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('Data: ${userData.toString()}'),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}