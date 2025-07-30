import 'package:flutter/material.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';

class DirectMessageDetailSection extends StatelessWidget {
  final int currentUserId;
  final ChatRoom room;

  const DirectMessageDetailSection({
    super.key,
    required this.room,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final targetUser = room.users?.firstWhere(
      (u) => u.id != currentUserId,
      orElse: () => User(id: 0, name: 'Unknown', email: ''),
    );

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundImage: targetUser?.profileImage != null
                ? NetworkImage(targetUser!.profileImage!)
                : null,
            child: targetUser?.profileImage == null
                ? const Icon(Icons.person, size: 48)
                : null,
          ),
          const SizedBox(height: 12),
          Text(room.name, style: context.textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text(
            targetUser?.email ?? '-',
            style: context.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Direct Message",
            style: TextStyle(
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
