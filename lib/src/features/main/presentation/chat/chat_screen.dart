import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:xchat/src/constants/db_keys.dart';
import 'package:xchat/src/constants/enum.dart';
import 'package:xchat/src/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:xchat/src/features/main/domain/model/chat_message.dart';
import 'package:xchat/src/features/main/presentation/providers/chat_messages_provider.dart';
import 'package:xchat/src/global_providers/global_providers.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final int roomId;
  final String roomName;
  const ChatScreen({super.key, required this.roomId, required this.roomName});
  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    final service = ref.read(webSocketServiceProvider);

    final token = ref.read(credentialsProvider);
    final url =
        "${DBKeys.serverUrl.initial}:${DBKeys.serverPort.initial}".toWebSocket;
    final wsUrl = "$url/chat/ws/${widget.roomId}?token=$token".toWebSocket;

    service.connect(wsUrl ?? "");
  }

  Future<void> _sendMessage() async {
    final messageText = _messageController.text.trim();
    if (messageText.isEmpty) return;

    await ref.read(webSocketServiceProvider).send(messageText);
    _messageController.clear();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(chatMessagesProvider(widget.roomId));
    final userData = ref.read(authUserProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(title: Text(widget.roomName)),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (messages) {
                if (messages.isEmpty) {
                  return const Center(
                    child: Text(
                      "Belum ada pesan.\nJadilah yang pertama mengirim pesan!",
                    ),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(8.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    if (msg.type == MessageType.info ||
                        msg.type == MessageType.error) {
                      return InfoMessageBubble(message: msg);
                    }
                    final isMe = msg.senderId == userData?.id;
                    return ChatMessageBubble(message: msg, isMe: isMe);
                  },
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Ketik pesan...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(icon: const Icon(Icons.send), onPressed: _sendMessage),
        ],
      ),
    );
  }
}

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool isMe;
  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.isMe,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        decoration: BoxDecoration(
          color: isMe
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (!isMe && message.senderName != null)
              Text(
                message.senderName!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: theme.colorScheme.primary,
                ),
              ),
            Text(message.content),
            const SizedBox(height: 4),
            Text(
              DateFormat.Hm().format(message.timestamp.toLocal()),
              style: TextStyle(
                fontSize: 10,
                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoMessageBubble extends StatelessWidget {
  final ChatMessage message;
  const InfoMessageBubble({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade700,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message.content,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
