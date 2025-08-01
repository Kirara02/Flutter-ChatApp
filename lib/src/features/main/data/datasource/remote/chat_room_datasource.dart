import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/network/dio_client.dart';
import 'package:xchat/src/core/network/response/api_response.dart';
import 'package:xchat/src/features/main/data/dto/chat_room_dto.dart';
import 'package:xchat/src/global_providers/global_providers.dart';

part 'chat_room_datasource.g.dart';

class ChatRoomDatasource {
  final DioClient _dioClient;

  ChatRoomDatasource({required DioClient dioClient}) : _dioClient = dioClient;

  Future<ApiResponse<List<ChatRoomDto>>> getChats({
    String? viewType = 'detailed',
    bool includeMembers = false,
    bool showEmpty = false,
    CancelToken? cancelToken,
  }) async {
    final queryParameters = {
      'view': viewType, // detailed | simple
      'include_members': includeMembers,
      'show_empty': showEmpty,
    };
    return await _dioClient.getApiData<List<ChatRoomDto>, ChatRoomDto>(
      "/rooms",
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      itemConverter: (json) => ChatRoomDto.fromMap(json),
    );
  }

  Future<ApiResponse<ChatRoomDto>> getUserRoomsById({
    required int roomId,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.getApiData<ChatRoomDto, dynamic>(
      "/rooms/$roomId",
      cancelToken: cancelToken,
      converter: (json) => ChatRoomDto.fromMap(json),
    );
  }

  Future<ApiResponse<ChatRoomDto>> createRoom({
    required String name,
    required List<int> userIds,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.postApiData(
      '/rooms',
      data: {'name': name, 'userIds': userIds},
      cancelToken: cancelToken,
      converter: (json) => ChatRoomDto.fromMap(json),
    );
  }

  Future<ApiResponse<ChatRoomDto>> updateRoomImage({
    required int roomId,
    required FormData formData,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.putApiData<ChatRoomDto, dynamic>(
      "/rooms/$roomId/image",
      data: formData,
      cancelToken: cancelToken,
      converter: (json) => ChatRoomDto.fromMap(json),
    );
  }
}

@riverpod
ChatRoomDatasource chatRoomDatasource(Ref ref) =>
    ChatRoomDatasource(dioClient: ref.watch(dioClientKeyProvider));
