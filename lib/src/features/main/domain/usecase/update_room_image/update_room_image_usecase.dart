import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/main/data/repository/chat_room_repository_impl.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/repository/chat_room_repository.dart';
import 'package:xchat/src/features/main/domain/usecase/update_room_image/update_room_image_params.dart';

part 'update_room_image_usecase.g.dart';

class UpdateRoomImage
    implements UseCase<Result<ChatRoom>, UpdateRoomImageParams> {
  final ChatRoomRepository _repository;

  UpdateRoomImage({required ChatRoomRepository repository})
    : _repository = repository;
  @override
  Future<Result<ChatRoom>> call(UpdateRoomImageParams params) async {
    return await _repository.updateRoomImage(params: params);
  }
}

@riverpod
UpdateRoomImage updateRoomImage(Ref ref) =>
    UpdateRoomImage(repository: ref.watch(chatRoomRepositoryProvider));
