import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

import '../../Controller/ChatController.dart';

class ZegoChat extends StatefulWidget {
  @override
  ZegoChatState createState() => ZegoChatState();
}

class ZegoChatState extends State<ZegoChat> {
  late ChatController chatController;
  int currentIndex = 0;

  String roomID = 'your_room_id';
  String userID = 'your_user_id';
  String userName = 'user_jessy';

  // Zego sign in and login
  int appId = 1925638511;
  String appSignIn =
      '41a41e8993fcc270a4153ac167d83dc35a6b3bbb164fb18adccf7f80e83a0298';

  List<String> messages = [];
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeZego();
    chatController = Get.put(ChatController());
  }

  void initializeZego() async {
    // await ZegoExpressEngine.initSDK(1925638511, '41a41e8993fcc270a4153ac167d83dc35a6b3bbb164fb18adccf7f80e83a0298');
    ZegoExpressEngine.onIMRecvBroadcastMessage =
        (String roomID, List<ZegoBroadcastMessageInfo> messageList) {
      setState(() {
        for (var message in messageList) {
          messages.add('${message.fromUser.userID}: ${message.fromUser}');
        }
      });
    };

    ZegoExpressEngine.instance.loginRoom(roomID, ZegoUser(userID, userName));
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            //load screen
            CircularProgressIndicator(),
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
                            color: Colors.blue.shade900, onPressed: () {
                            chatController.navigateToCallPage();
                          }, icon: Icon(Icons.call),
                          ),
                        ),
                        Text("Voice Call"),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            color: Colors.blue.shade900, onPressed: () {
                            chatController.navigateToCallPage();
                          }, icon: Icon(Icons.video_call),
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
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(hintText: 'Type a message...'),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.blue.shade900,
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