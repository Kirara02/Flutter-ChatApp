import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/main/data/repository/chat_room_repository_impl.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/repository/chat_room_repository.dart';
import 'package:xchat/src/features/main/domain/usecase/get_chats/get_chats_params.dart';

part 'get_chats_usecase.g.dart';

class GetChats implements UseCase<Result<List<ChatRoom>>, GetChatsParams> {
  final ChatRoomRepository _repository;

  GetChats({required ChatRoomRepository repository}) : _repository = repository;
  @override
  Future<Result<List<ChatRoom>>> call(GetChatsParams params) async {
    return await _repository.getChats(params: params);
  }
}

@riverpod
GetChats getChats(Ref ref) =>
    GetChats(repository: ref.watch(chatRoomRepositoryProvider));
