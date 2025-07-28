import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/usecase/get_chats/get_chats_params.dart';
import 'package:xchat/src/features/main/domain/usecase/get_chats/get_chats_usecase.dart';

part 'chats_provider.g.dart';

@riverpod
class ChatsNotifier extends _$ChatsNotifier {
  @override
  Future<List<ChatRoom>> build() async {
    // Panggil usecase saat provider pertama kali dibuat
    final getChatsUseCase = ref.watch(getChatsProvider);
    final result = await getChatsUseCase.call(GetChatsParams());

    switch (result) {
      case Success(value: final chats):
        return chats;
      case Failed(message: final msg):
        throw Exception(msg); // Lempar error agar state menjadi AsyncError
    }
  }

  // Fungsi untuk pull-to-refresh
  Future<void> refreshChats() async {
    // Invalidate provider agar build() dijalankan kembali untuk fetch data baru
    ref.invalidateSelf();
  }
}