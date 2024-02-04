import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Pages/Chats/ZegoChat.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Chats/Chat.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Select Your Helper : ",
            style: TextStyle(
                color: Colors.blue.shade900, fontWeight: FontWeight.bold ,
            fontFamily: "Font_Stranger" , fontSize: 30),),
    ),


      body: SafeArea(
        child: ListView.builder(
          itemCount: documentIds.length,
          itemBuilder: (context, index) {
            String documentId = documentIds[index];
            Map<String, dynamic> userData = userDataList[index];
            String helperName = userData['helperName'];
            bool state = userData['state'];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),

                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  color: Colors.blue[900], // Set the background color of each list item

                ),
                child: ListTile(
                  title: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Chat()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Name: $helperName',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.blue[900],
                          fontFamily: "Font_Stranger",
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  subtitle: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Chat()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Available: ${state.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          backgroundColor: Colors.blue[900],
                          fontWeight: FontWeight.bold,
                          fontFamily: "Font_Stranger",
                          fontSize: 20,
                        ),
                      ),
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