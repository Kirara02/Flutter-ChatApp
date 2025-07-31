import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/network/dio_client.dart';
import 'package:xchat/src/core/network/response/api_response.dart';
import 'package:xchat/src/features/auth/data/dto/user_dto.dart';
import 'package:xchat/src/global_providers/global_providers.dart';
import 'package:dio/dio.dart';

part 'profile_datasource.g.dart';

class ProfileDatasource {
  final DioClient _dioClient;

  ProfileDatasource({required DioClient dioClient}) : _dioClient = dioClient;

  Future<ApiResponse<UserDto>> getProfile({CancelToken? cancelToken}) async {
    return await _dioClient.getApiData<UserDto, dynamic>(
      "/profile",
      converter: (json) => UserDto.fromMap(json),
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse<UserDto>> update({
    required FormData formData,
    CancelToken? cancelToken,
  }) async {
    return _dioClient.putApiData<UserDto, dynamic>(
      "/profile",
      data: formData,
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
ProfileDatasource profileDatasource(Ref ref) =>
    ProfileDatasource(dioClient: ref.read(dioClientKeyProvider));
