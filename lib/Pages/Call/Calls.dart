import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID}) : super(key: key);
  final String callID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Call"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Text("Start Call"),
            ),
            ZegoUIKitPrebuiltCall(
              appID: 267164922,
              appSign:
              '8a70ba787132f9f5d71d7f7761197ae53735751f3dd0c7b3cff7e76fbcf89788',
              userID: '1',
              userName: 'user_Two',
              callID: '2',
              config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
            ),
          ],
        ),
      ),
    );
  }
}