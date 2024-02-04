import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduation_project/Pages/Chats/Message.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

import '../../Controller/ChatController.dart';

class ZegoChatt extends StatefulWidget {
  @override
  ZegoChattState createState() => ZegoChattState();
}

class ZegoChattState extends State<ZegoChatt> {
  TextEditingController messageTxt = TextEditingController();
  var auth = FirebaseAuth.instance;

  late ChatController chatController;
  int currentIndex = 0;
  String roomID = 'your_room_id';
  String userID = 'your_user_id';
  String userName = 'user_jessy';

  List<String> messages = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeZego();
    chatController = Get.put(ChatController());
  }

  void initializeZego() async {
    ZegoExpressEngine.onIMRecvBroadcastMessage =
        (String roomID, List<ZegoBroadcastMessageInfo> messageList) {
      setState(() {
        for (var message in messageList) {
          messages.add('${message.fromUser.userID}: ${message.message}');
        }
      });
    };
    await ZegoExpressEngine.instance.loginRoom(
        roomID, ZegoUser(userID, userName));
  }

  void sendMessage() {
    String messageContent = textEditingController.text;
    if (messageContent.isNotEmpty) {
      ZegoExpressEngine.instance.sendBroadcastMessage(roomID, messageContent);
      textEditingController.clear();
    }
  }

  @override
  void dispose() {
    ZegoExpressEngine.instance.logoutRoom(roomID);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var fireStore = FirebaseFirestore.instance;
    String? previosResponse;

    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
        ),
        body: SafeArea(
          child: Column(
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          color: Colors.blue.shade900,
                          onPressed: () {
                            chatController.navigateToCallPage();
                          },
                          icon: Icon(Icons.video_call),
                        ),
                      ),
                      Text("Video Call"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Column(
            children: [
              StreamBuilder<QuerySnapshot>(
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
                      String Sender = responseMessage[i].get('Name');
                      if (i > 0) {
                        previosResponse = responseMessage[i - 1].get('Name');
                      }
                      allMessages.add(MessageWidget(
                        msg: txt,
                        sender: Sender,
                        previousName: previosResponse,
                      ));
                    }
                    return Expanded(
                      child: ListView(
                        children: allMessages,
                        reverse: true,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator(
                      color: Colors.greenAccent,
                    );
                  }
                }
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
                          ), border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        )),
                  ),
                  Expanded(
                      child: TextButton(
                        onPressed: () {
                          fireStore.collection("MessageID").add({
                            'Name': auth.currentUser!.email,
                            'msg': messageTxt.text.toString(),
                            'time': DateTime.now(),
                          });
                        },
                        child: Icon(
                          Icons.send,
                          size: 70,
                        ),
                      )),
                ],
              )
            ],
          ),
       ] )),
    );
  }
}
