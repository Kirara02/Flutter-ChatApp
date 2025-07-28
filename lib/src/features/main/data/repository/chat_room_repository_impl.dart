import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/main/data/datasource/remote/chat_room_datasource.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/repository/chat_room_repository.dart';
import 'package:xchat/src/features/main/domain/usecase/get_chats/get_chats_params.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';

part 'chat_room_repository_impl.g.dart';

class ChatRoomRepositoryImpl implements ChatRoomRepository {
  final ChatRoomDatasource _datasource;

  ChatRoomRepositoryImpl({required ChatRoomDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Result<List<ChatRoom>>> getChats({
    required GetChatsParams params,
  }) async {
    final response = await _datasource.getChats(
      viewType: params.type,
      includeMembers: params.includeMembers,
      cancelToken: params.cancelToken,
    );
    if (response.success && response.data != null) {
      return Result.success(
        response.data!.map((e) => e.toModel()).toList(),
        meta: response.meta,
      );
    }
    return Result.failed(response.message, code: response.error?.code);
  }
}

@riverpod
ChatRoomRepository chatRoomRepository(Ref ref) =>
    ChatRoomRepositoryImpl(datasource: ref.watch(chatRoomDatasourceProvider));
