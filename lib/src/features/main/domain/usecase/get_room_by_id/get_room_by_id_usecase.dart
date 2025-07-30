import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/main/data/repository/chat_room_repository_impl.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/repository/chat_room_repository.dart';
import 'package:xchat/src/features/main/domain/usecase/get_room_by_id/get_room_by_id_params.dart';

part 'get_room_by_id_usecase.g.dart';

class GetRoomById implements UseCase<Result<ChatRoom>, GetRoomByIdParams> {
  final ChatRoomRepository _repository;

  GetRoomById({required ChatRoomRepository repository})
    : _repository = repository;
  @override
  Future<Result<ChatRoom>> call(GetRoomByIdParams params) async {
    return await _repository.getUserRoomsById(params: params);
  }
}

@riverpod
GetRoomById getRoomById(Ref ref) =>
    GetRoomById(repository: ref.watch(chatRoomRepositoryProvider));
