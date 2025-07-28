import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/usecase/get_chats/get_chats_params.dart';

abstract interface class ChatRoomRepository {
  Future<Result<List<ChatRoom>>> getChats({required GetChatsParams params});
}
