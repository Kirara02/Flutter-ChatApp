import 'package:xchat/src/features/auth/domain/model/user.dart';

class ChatRoom {
  final int id;
  final String name;
  final bool isGroup;
  final bool isPrivate;
  final List<User>? users;
  final int? ownerId;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final DateTime createdAt;

  ChatRoom({
    required this.id,
    required this.name,
    required this.isGroup,
    required this.isPrivate,
    this.users,
    this.ownerId,
    this.lastMessage,
    this.lastMessageAt,
    required this.createdAt,
  });
}
