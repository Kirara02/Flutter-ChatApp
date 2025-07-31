import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xchat/src/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:xchat/src/features/main/domain/usecase/update_room_image/update_room_image_params.dart';
import 'package:xchat/src/features/main/presentation/chat_detail/widgets/direct_message_detail_section.dart';
import 'package:xchat/src/features/main/presentation/chat_detail/widgets/group_chat_detail_section.dart';
import 'package:xchat/src/features/main/presentation/providers/chat_detail_provider.dart';
import 'package:xchat/src/features/main/presentation/providers/update_room_image_provider.dart';
import 'package:xchat/src/utils/image_picker_helper.dart';

class ChatDetailScreen extends ConsumerWidget {
  final int roomId;
  const ChatDetailScreen({super.key, required this.roomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomAsync = ref.watch(chatDetailNotifierProvider(roomId));
    final userData = ref.read(authUserProvider).valueOrNull;
    final updateState = ref.watch(updateRoomImageNotifierProvider);
    final updateNotifier = ref.read(updateRoomImageNotifierProvider.notifier);

    return roomAsync.when(
      data: (room) {
        if (room == null) {
          return const Scaffold(body: Center(child: Text("Room not found")));
        }

        final isOwner = userData?.id == room.ownerId;

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.of(context).maybePop(),
                      ),
                      const Spacer(),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) async {
                          switch (value) {
                            case 'edit_image':
                              final picker = ImagePickerHelper();
                              final selectedImage = await picker
                                  .pickAndProcessImage(source: ImageSource.gallery);
                              if (selectedImage == null) return;

                              await updateNotifier.updateImage(
                                UpdateRoomImageParams(
                                  roomId: room.id,
                                  file: selectedImage,
                                ),
                              );

                              updateState.whenOrNull(
                                data: (_) => ref.invalidate(
                                  chatDetailNotifierProvider(room.id),
                                ),
                              );
                              break;

                            case 'transfer_ownership':
                              break;
                            case 'leave_group':
                              break;
                            case 'block_user':
                              break;
                            case 'report_user':
                              break;
                          }
                        },
                        itemBuilder: (context) {
                          if (room.isGroup) {
                            if (isOwner) {
                              return [
                                const PopupMenuItem(
                                  value: 'edit_image',
                                  child: Text('Update Room Image'),
                                ),
                                const PopupMenuItem(
                                  value: 'transfer_ownership',
                                  child: Text('Transfer Ownership'),
                                ),
                              ];
                            } else {
                              return [
                                const PopupMenuItem(
                                  value: 'leave_group',
                                  child: Text('Leave Group'),
                                ),
                              ];
                            }
                          } else {
                            return [
                              const PopupMenuItem(
                                value: 'block_user',
                                child: Text('Block User'),
                              ),
                              const PopupMenuItem(
                                value: 'report_user',
                                child: Text('Report User'),
                              ),
                            ];
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: room.isGroup
                        ? GroupChatDetailSection(
                            room: room,
                            currentUserId: userData!.id,
                          )
                        : DirectMessageDetailSection(
                            room: room,
                            currentUserId: userData!.id,
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
    );
  }
}
