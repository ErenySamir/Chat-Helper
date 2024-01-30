import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    getResipes();
  }

  getResipes() async {
    var response = await fireStore.collection("DataEntered").get();

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
      backgroundColor: Colors.pink.shade100,
      body: SafeArea(
        child: ListView.builder(
          itemCount: documentIds.length,
          itemBuilder: (context, index) {
            String documentId = documentIds[index];
            Map<String, dynamic> userData = userDataList[index];

            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 3.0,
                ),
              ),
              child: ListTile(
                title: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(bottom: 1.0),
                  child: Text(
                    'Document ID: $documentId',
                  ),
                ),
                subtitle: Container(
                  padding: EdgeInsets.only(top: 1.0),
                  child: Text('Data: ${userData.toString()}'),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}