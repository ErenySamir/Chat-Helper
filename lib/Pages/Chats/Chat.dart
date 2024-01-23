// import 'package:flutter/material.dart';
// import 'package:zego_express_engine/zego_express_engine.dart';
//
// import 'user.dart';
// import 'message.dart';
//
// class ChatScreen extends StatefulWidget {
//   final User user;
//
//   const ChatScreen({Key? key, required this.user}) : super(key: key);
//
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   final ZegoExpressEngine _zegoEngine = ZegoExpressEngine.instance;
//   final TextEditingController _textController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeZegoEngine();
//   }
//
//   Future<void> _initializeZegoEngine() async {
//     try {
//       await _zegoEngine.createEngine(
//         ZegoEngineConfig(appID: , appSign: ),
//         ZegoScenario.General,
//       );
//       await _zegoEngine.loginRoom(
//         roomID: 'your_room_id',
//         userID: widget.user.id,
//         userName: widget.user.name,
//       );
//     } catch (e) {
//       print('Zego initialization failed: $e');
//     }
//   }
//
//   @override
//   void dispose() {
//     _textController.dispose();
//     _zegoEngine.logoutRoom('your_room_id');
//     _zegoEngine.destroyEngine();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.user.name),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               // Display chat messages
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _textController,
//               decoration: const InputDecoration(
//                 hintText: 'Type a message...',
//               ),
//               onSubmitted: (value) {
//                 _sendMessage(value.trim());
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _sendMessage(String text) {
//     final message = Message(
//       id: DateTime.now().toString(),
//       senderId: widget.user.id,
//       text: text,
//       timestamp: DateTime.now(),
//     );
//
//     // Send the message using Zego
//     // _zegoEngine.sendBroadcastMessage(YOUR_ROOM_ID, text);
//
//     _textController.clear();
//   }
// }