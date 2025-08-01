import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/usecase/get_chats/get_chats_params.dart';
import 'package:xchat/src/features/main/domain/usecase/get_chats/get_chats_usecase.dart';

part 'chats_provider.g.dart';

@riverpod
class ChatsNotifier extends _$ChatsNotifier {
  @override
  Future<List<ChatRoom>> build({bool showEmpty = false}) async {
    final getChatsUseCase = ref.watch(getChatsProvider);
    
    // Membuat objek GetChatsParams di dalam provider.
    // 'viewType' diubah menjadi 'type'.
    final params = GetChatsParams(
      showEmpty: showEmpty,
      type: 'detailed', 
      includeMembers: true,
    );

    final result = await getChatsUseCase.call(params);

    switch (result) {
      case Success(value: final chats):
        return chats;
      case Failed(message: final msg):
        throw Exception(msg);
    }
  }

  // Metode ini akan me-refresh provider dengan parameter yang sama
  // seperti saat pertama kali dibuat.
  Future<void> refreshChats() async {
    ref.invalidateSelf();
  }
}
