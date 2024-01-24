import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

import 'Message.dart';

class Chat extends StatefulWidget {
  @override
  ChatState createState() => ChatState();
}

class ChatState extends State<Chat> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  TextEditingController messageTxt = TextEditingController();
  late Stream<QuerySnapshot> messageStream;
  String? previousResponse;

  late final ZegoExpressEngine zegoEngine;
  final int appID = 267164922;
  final String appSign = '8a70ba787132f9f5d71d7f7761197ae53735751f3dd0c7b3cff7e76fbcf89788';
  final bool isTestEnv = true;
  final ZegoScenario scenario = ZegoScenario.General;

  @override
  void initState() {
    super.initState();
    initializeZegoEngine();
    messageStream = fireStore.collection('MessageID').orderBy('time').snapshots();
  }

  @override
  void dispose() {
    messageTxt.dispose();
    ZegoExpressEngine.destroyEngine();
    super.dispose();
  }

  void initializeZegoEngine()  {
     ZegoExpressEngine.createEngine(appID, appSign, isTestEnv, scenario);
    //zegoEngine = ZegoExpressEngine.getInstance();
    // Configure other Zego settings and event listeners as needed
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.brown.shade50,
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: messageStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final responseMessage = snapshot.data!.docs;
                    final allMessages = responseMessage.map((message) {
                      final txt = message.get('msg') as String;
                      final sender = message.get('userName') as String;
                      final messageWidget = MessageWidget(
                        msg: txt,
                        sender: sender,
                        previousName: previousResponse,
                      );

                      previousResponse = sender;
                      return messageWidget;
                    }).toList();

                    return ListView(
                      reverse: true,
                      children: allMessages,
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.greenAccent,
                      ),
                    );
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    controller: messageTxt,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Write your message.....',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      fireStore.collection("MessageID").add({
                        'userName': auth.currentUser!.email,
                        'msg': messageTxt.text.toString(),
                        'time': DateTime.now(),
                      });
                    },
                    child: Icon(
                      Icons.send,
                      size: 70,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// class MessageWidget extends StatelessWidget {
//   final String msg;
//   final String sender;
//   final String? previousName;
//
//   const MessageWidget({
//     required this.msg,
//     required this.sender,
//     required this.previousName,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: Text(sender),
//       subtitle: Text(msg),
//     );
//   }
// }