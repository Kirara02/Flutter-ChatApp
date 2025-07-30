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
    final getChatsUseCase = ref.watch(getChatsProvider);
    final result = await getChatsUseCase.call(GetChatsParams());

    switch (result) {
      case Success(value: final chats):
        return chats;
      case Failed(message: final msg):
        throw Exception(msg);
    }
  }

  Future<void> refreshChats() async {
    ref.invalidateSelf();
  }
}
