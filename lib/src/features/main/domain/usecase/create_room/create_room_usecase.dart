import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/main/data/repository/chat_room_repository_impl.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/repository/chat_room_repository.dart';
import 'package:xchat/src/features/main/domain/usecase/create_room/create_room_params.dart';

part 'create_room_usecase.g.dart';

class CreateRoom implements UseCase<Result<ChatRoom>, CreateRoomParams> {
  final ChatRoomRepository _repository;

  CreateRoom({required ChatRoomRepository repository})
    : _repository = repository;

  @override
  Future<Result<ChatRoom>> call(CreateRoomParams params) async {
    return await _repository.createRoom(params: params);
  }
}

@riverpod
CreateRoom createRoom(Ref ref) =>
    CreateRoom(repository: ref.watch(chatRoomRepositoryProvider));
