import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/main/data/datasource/remote/user_datasource.dart';
import 'package:xchat/src/features/main/domain/repository/user_repository.dart';
import 'package:xchat/src/features/main/domain/usecase/search_users/search_users_params.dart';
import 'package:xchat/src/features/main/domain/usecase/update_profile/update_profile_params.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';
import 'package:dio/dio.dart';

part 'user_repository_impl.g.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource _datasource;

  UserRepositoryImpl({required UserDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Result<User>> getProfile({CancelToken? cancelToken}) async {
    final response = await _datasource.getProfile(cancelToken: cancelToken);
    if (response.success && response.data != null) {
      return Result.success(response.data!.toModel());
    }
    return Result.failed(response.message, code: response.error?.code);
  }

  @override
  Future<Result<User>> updateProfile({
    required UpdateProfileParams params,
  }) async {
    final response = await _datasource.update(
      name: params.name,
      email: params.email,
      cancelToken: params.cancelToken,
    );
    if (response.success && response.data != null) {
      return Result.success(response.data!.toModel());
    }
    return Result.failed(response.message, code: response.error?.code);
  }

  @override
  Future<Result<List<User>>> searchUsers({
    required SearchUsersParams params,
  }) async {
    final response = await _datasource.searchUsers(
      keyword: params.keyword,
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
UserRepository userRepository(Ref ref) =>
    UserRepositoryImpl(datasource: ref.read(userDatasourceProvider));
