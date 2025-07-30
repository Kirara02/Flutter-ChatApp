import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/main/domain/model/chat_room.dart';
import 'package:xchat/src/features/main/domain/usecase/get_chats/get_chats_params.dart';
import 'package:xchat/src/features/main/domain/usecase/get_room_by_id/get_room_by_id_params.dart';
import 'package:xchat/src/features/main/domain/usecase/update_room_image/update_room_image_params.dart';

abstract interface class ChatRoomRepository {
  Future<Result<List<ChatRoom>>> getChats({required GetChatsParams params});
  Future<Result<ChatRoom>> getUserRoomsById({required GetRoomByIdParams params});
  Future<Result<ChatRoom>> updateRoomImage({required UpdateRoomImageParams params});
}
