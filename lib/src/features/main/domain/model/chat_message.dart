
import 'package:xchat/src/constants/enum.dart';

class ChatMessage {
  final MessageType type;
  final String content;
  final int? senderId;
  final String? senderName;
  final DateTime timestamp;

  ChatMessage({
    required this.type,
    required this.content,
    this.senderId,
    this.senderName,
    required this.timestamp,
  });
}
