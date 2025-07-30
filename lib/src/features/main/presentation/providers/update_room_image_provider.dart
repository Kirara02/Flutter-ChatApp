import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/usecase/update_room_image/update_room_image_params.dart';
import 'package:xchat/src/features/main/domain/usecase/update_room_image/update_room_image_usecase.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';

part 'update_room_image_provider.g.dart';

@riverpod
class UpdateRoomImageNotifier extends _$UpdateRoomImageNotifier {
  @override
  FutureOr<ChatRoom?> build() => null;

  Future<void> updateImage(UpdateRoomImageParams params) async {
    state = const AsyncLoading();

    final usecase = ref.read(updateRoomImageProvider);
    final result = await usecase(params);

    result.when(
      success: (room, _) => state = AsyncData(room),
      failed: (msg, _) => state = AsyncError(msg, StackTrace.current),
    );
  }
}
