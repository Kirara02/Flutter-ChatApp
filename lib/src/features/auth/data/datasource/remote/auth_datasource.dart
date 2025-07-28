import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xchat/src/core/network/dio_client.dart';
import 'package:xchat/src/core/network/response/api_response.dart';
import 'package:xchat/src/features/auth/data/dto/login_dto.dart';
import 'package:xchat/src/features/auth/data/dto/refresh_dto.dart';
import 'package:xchat/src/features/auth/data/dto/user_dto.dart';
import 'package:xchat/src/global_providers/global_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dio/dio.dart';

part 'auth_datasource.g.dart';

class AuthDataSource {
  final DioClient _dioClient;

  AuthDataSource({required DioClient dioClient}) : _dioClient = dioClient;

  Future<ApiResponse<LoginDto>> login({
    required String email,
    required String password,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.postApiData<LoginDto, dynamic>(
      "/auth/login",
      data: {'email': email.trim(), 'password': password.trim()},
      converter: (json) => LoginDto.fromMap(json),
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse> logout({CancelToken? cancelToken}) async {
    return await _dioClient.postApiData(
      "/auth/logout",
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse<UserDto>> register({
    required String name,
    required String email,
    required String password,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.postApiData<UserDto, dynamic>(
      "/auth/register",
      data: {
        'name': name.trim(),
        'email': email.trim(),
        'password': password.trim(),
      },
      converter: (json) => UserDto.fromMap(json),
      cancelToken: cancelToken,
    );
  }

  Future<ApiResponse<RefreshDto>> refresh({
    required String refreshToken,
    CancelToken? cancelToken,
  }) async {
    return await _dioClient.postApiData<RefreshDto, dynamic>(
      "auth/refresh",
      data: {'refresh_token': refreshToken.trim()},
      converter: (json) => RefreshDto.fromMap(json),
      cancelToken: cancelToken,
    );
  }
}

@riverpod
AuthDataSource authDataSource(Ref ref) =>
    AuthDataSource(dioClient: ref.watch(dioClientKeyProvider));
