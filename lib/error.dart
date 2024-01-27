import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

import 'Pages/Chats/Message.dart';

class error extends StatefulWidget {
  @override
  errorState createState() => errorState();
}
class errorState extends State<error> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  // TextEditingController messageTxt = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final List<MessageWidget> messageTxt = [];
  late Stream<QuerySnapshot<Object?>> messageStream = Stream.empty();
  String? previousResponse;
  int index = 0;

  late final ZegoExpressEngine zegoEngine;
  final int appID = 267164922;
  final String appSign =
      '8a70ba787132f9f5d71d7f7761197ae53735751f3dd0c7b3cff7e76fbcf89788';
  final bool isTestEnv = true;
  final ZegoScenario scenario = ZegoScenario.General;

  StreamSubscription<QuerySnapshot<Object?>>? messageSubscription;

  @override
  void initState() {
    super.initState();
    initializeZegoEngine();
    listenToMessages();
  }

  @override
  void dispose() {
    //messageTxt.dispose();
    ZegoExpressEngine.destroyEngine();
    messageSubscription?.cancel(); // Cancel the subscription before disposing
    super.dispose();
  }

  void initializeZegoEngine() {
    ZegoExpressEngine.createEngine(appID, appSign, isTestEnv, scenario);
    //zegoEngine = ZegoExpressEngine();
    //zegoEngine.createEngine(appID, appSign, isTestEnv, scenario);    // Configure other Zego settings and event listeners as needed
  }

  void listenToMessages() {
    messageSubscription?.cancel(); // Cancel the previous subscription, if any
    messageSubscription = fireStore
        .collection('MessageID')
        .orderBy('time')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      if (snapshot.size > 0) {
        final responseMessage = snapshot.docs;
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

        setState(() {
          // messageStream = snapshot.docs;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.purple.shade50,
        appBar: AppBar(
          title: Text('Chat Helper'),
          backgroundColor: Colors.deepPurple.shade200,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Object?>>(
                stream: fireStore
                    .collection('MessageID')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<MessageWidget> allMessages = [];

                  if (snapshot.hasData) {
                    var responseMessage = snapshot.data!.docs;
                    print(responseMessage.length.toString() + 'chatlength');
                    for (int i = 0; i < responseMessage.length; i++) {
                      String txt = responseMessage[i].get('msg');
                      String Sender = responseMessage[i].get('userName');
                      if (i > 0) {
                        previousResponse =
                            responseMessage[i - 1].get('userName');
                      }
                      allMessages.add(MessageWidget(
                          msg: txt,
                          sender: Sender,
                          previousName: previousResponse));
                    }
                    return Expanded(
                      child: ListView(
                        // scrollDirection: Axis.vertical,shrinkWrap: true -> دول بحظهم لو انا هسييب الليست فاضيه
                        children: allMessages,
                        reverse: true,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator(
                      color: Colors.greenAccent,
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messageTxt.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (messageTxt[index].msg == "receiver"
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (messageTxt[index].msg == "receiver"
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          messageController as String,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: 'Write your message...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      fireStore.collection("MessageID").add({
                        'userName': auth.currentUser!.email,
                        'msg': messageController.text.toString(),
                        'time': DateTime.now(),
                      });
                      messageTxt.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      size: 70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}