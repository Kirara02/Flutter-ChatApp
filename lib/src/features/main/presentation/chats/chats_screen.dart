import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xchat/src/features/auth/presentation/providers/logout_provider.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/presentation/providers/chats_provider.dart';
import 'package:xchat/src/routes/router_config.dart';

class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  void _navigateToListUsers(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Navigasi ke halaman daftar pengguna...')),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatsState = ref.watch(chatsNotifierProvider);
    final logoutState = ref.watch(logoutNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chats',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          if (logoutState.isLoading)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            )
          else
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'logout') {
                  ref.read(logoutNotifierProvider.notifier).logout();
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(chatsNotifierProvider.notifier).refreshChats(),
        child: chatsState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Gagal memuat chat: $err'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => ref.invalidate(chatsNotifierProvider),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
          data: (chats) {
            if (chats.isEmpty) {
              return const Center(child: Text('Belum ada chat.'));
            }
            return ListView.separated(
              itemCount: chats.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: 0, indent: 80),
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ChatListItem(chat: chat);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToListUsers(context),
        child: const Icon(Icons.message),
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key, required this.chat});

  final ChatRoom chat;

  String _formatTimestamp(BuildContext context, DateTime? dateTime) {
    if (dateTime == null) return '';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dateToCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (dateToCheck == today) {
      return DateFormat.Hm().format(dateTime);
    }
    if (dateToCheck == yesterday) {
      return 'Kemarin';
    }
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lastMessage = chat.lastMessage ?? 'Belum ada pesan';
    final timestamp = _formatTimestamp(
      context,
      chat.lastMessageAt?.toLocal() ?? chat.createdAt.toLocal(),
    );
    final unreadCount = 0;

    return ListTile(
      onTap: () => ChatRoute(
        roomId: chat.id.toString(),
        $extra: chat.name,
      ).push(context),
      leading: CircleAvatar(
        radius: 28,
        backgroundImage: NetworkImage(
          chat.roomImage != null
              ? chat.roomImage!
              : 'https://ui-avatars.com/api/?name=${chat.name}&size=150',
        ),
        child: chat.isGroup
            ? const Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 10,
                  child: Icon(Icons.group, size: 14),
                ),
              )
            : null,
      ),
      title: Text(
        chat.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.8),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            timestamp,
            style: TextStyle(
              fontSize: 12,
              color: unreadCount > 0
                  ? theme.colorScheme.primary
                  : theme.textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 4),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                unreadCount.toString(),
                style: TextStyle(
                  color: theme.colorScheme.onPrimary,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          else
            const SizedBox(height: 18), // Placeholder
        ],
      ),
    );
  }
}
