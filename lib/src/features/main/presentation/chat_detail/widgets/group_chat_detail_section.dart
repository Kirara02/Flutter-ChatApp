import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/presentation/providers/update_room_image_provider.dart';

class GroupChatDetailSection extends ConsumerWidget {
  final ChatRoom room;
  final int currentUserId;
  const GroupChatDetailSection({
    super.key,
    required this.room,
    required this.currentUserId,
  });

  bool get isCurrentUserOwner => currentUserId == room.ownerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateState = ref.watch(updateRoomImageNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundImage: room.roomImage != null
                  ? NetworkImage(room.roomImage!)
                  : null,
              child: room.roomImage == null
                  ? const Icon(Icons.group, size: 48)
                  : null,
            ),
            if (updateState.isLoading)
              const Positioned.fill(
                child: ColoredBox(
                  color: Colors.black45,
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          room.name,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          "Group Chat",
          style: TextStyle(
            color: Colors.grey[600],
            fontStyle: FontStyle.italic,
          ),
        ),
        const Divider(height: 32),
        if (room.users != null) ...[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Members (${room.users!.length})",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 8),
          ...room.users!.map((user) {
            final isOwner = user.id == room.ownerId;
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: user.profileImage != null
                    ? NetworkImage(user.profileImage!)
                    : null,
                child: user.profileImage == null
                    ? const Icon(Icons.person)
                    : null,
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: isOwner
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        "Owner",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : null,
            );
          }),
        ],
      ],
    );
  }
}
