import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/network/dio_client.dart';
import 'package:xchat/src/core/network/response/api_response.dart';
import 'package:xchat/src/features/auth/data/dto/user_dto.dart';
import 'package:xchat/src/global_providers/global_providers.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';
import 'package:dio/dio.dart';

part 'user_datasource.g.dart';

class UserDatasource {
  final DioClient _dioClient;

  UserDatasource({required DioClient dioClient}) : _dioClient = dioClient;

  Future<ApiResponse<UserDto>> getProfile({CancelToken? cancelToken}) async {
    return await _dioClient.getApiData<UserDto, dynamic>(
      "/profile",
      converter: (json) => UserDto.fromMap(json),
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse<UserDto>> update({
    String? name,
    String? email,
    CancelToken? cancelToken,
  }) async {
    return _dioClient.putApiData<UserDto, dynamic>(
      "/profile",
      data: {
        if (name.isNotBlank) 'name': name,
        if (email.isNotBlank) 'email': email,
      },
      converter: (json) => UserDto.fromMap(json),
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse<List<UserDto>>> searchUsers({
    required String keyword,
    CancelToken? cancelToken,
  }) async {
    final queryParameters = {'keyword': keyword, 'include_self': false};

    return await _dioClient.getApiData<List<UserDto>, UserDto>(
      "/users",
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      itemConverter: (json) => UserDto.fromMap(json),
    );
  }
}

@riverpod
UserDatasource userDatasource(Ref ref) =>
    UserDatasource(dioClient: ref.read(dioClientKeyProvider));
