import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/usecase/get_room_by_id/get_room_by_id_params.dart';
import 'package:xchat/src/features/main/domain/usecase/get_room_by_id/get_room_by_id_usecase.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';

part 'chat_detail_provider.g.dart';

@riverpod
class ChatDetailNotifier extends _$ChatDetailNotifier {
  @override
  FutureOr<ChatRoom?> build(int roomId) async {
    final usecase = ref.read(getRoomByIdProvider);
    final result = await usecase(GetRoomByIdParams(roomId: roomId));

    return result.whenOrNull(success: (data, _) => data);
  }
}
