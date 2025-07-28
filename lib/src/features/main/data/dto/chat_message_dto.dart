import 'dart:convert';

import 'package:xchat/src/constants/enum.dart';
import 'package:xchat/src/features/main/domain/model/chat_message.dart';

class ChatMessageDto {
  static List<ChatMessage> parse(String jsonData) {
    final Map<String, dynamic> data = json.decode(jsonData);
    final typeString = data['type'] as String? ?? 'unknown';
    MessageType type = MessageType.values.firstWhere(
      (e) => e.name == typeString,
      orElse: () => MessageType.unknown,
    );
    if (type == MessageType.history) {
      final messages = data['messages'] as List;
      return messages
          .map((msg) => _parseSingleMessage(msg, MessageType.chat))
          .toList();
    } else {
      return [_parseSingleMessage(data, type)];
    }
  }

  static ChatMessage _parseSingleMessage(
    Map<String, dynamic> data,
    MessageType type,
  ) => ChatMessage(
    type: type,
    content: data['content'] ?? data['message'] ?? '',
    senderId: data['sender_id'],
    senderName: data['sender_name'],
    timestamp: data['created_at'] != null
        ? DateTime.parse(data['created_at'])
        : DateTime.now(),
  );
}
