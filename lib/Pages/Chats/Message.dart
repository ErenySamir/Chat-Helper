import 'package:firebase_auth/firebase_auth.dart';

class Message {
  final String id;
  final String senderId;
  final String text;
  final DateTime timestamp;
  var auth = FirebaseAuth.instance;

  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
  });
}