import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/usecase/create_room/create_room_params.dart';
import 'package:xchat/src/features/main/domain/usecase/create_room/create_room_usecase.dart';
import 'package:xchat/src/features/main/presentation/providers/chats_provider.dart';

part 'room_creation_provider.g.dart';

@riverpod
class RoomCreationNotifier extends _$RoomCreationNotifier {
  @override
  FutureOr<ChatRoom?> build() {
    return null;
  }

  Future<void> createRoom({
    required String name,
    required List<int> userIds,
  }) async {
    state = const AsyncLoading();
    final usecase = ref.read(createRoomProvider);
    final params = CreateRoomParams(name: name, userIds: userIds);

    final result = await usecase(params);

    switch (result) {
      case Success(value: final room):
        // Invalidate provider daftar chat agar me-refresh data
        ref.invalidate(chatsNotifierProvider);
        state = AsyncData(room);
      case Failed(message: final message):
        state = AsyncError(message, StackTrace.current);
    }
  }
}
