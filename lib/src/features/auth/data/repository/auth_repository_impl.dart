import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/data/datasource/remote/auth_datasource.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/auth/domain/repository/auth_repository.dart';
import 'package:xchat/src/features/auth/domain/usecase/login/login_usecase.dart';
import 'package:xchat/src/features/auth/domain/usecase/refresh/refresh_params.dart';
import 'package:xchat/src/features/auth/domain/usecase/register/register_params.dart';
import 'package:xchat/src/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:xchat/src/global_providers/global_providers.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _datasource;
  final Ref _ref;

  AuthRepositoryImpl({required AuthDataSource datasource, required Ref ref})
    : _datasource = datasource,
      _ref = ref;

  @override
  Future<Result<User>> login({required LoginParams params}) async {
    final response = await _datasource.login(
      email: params.email,
      password: params.password,
      cancelToken: params.cancelToken,
    );
    if (response.success && response.data != null) {
      final data = response.data!;

      _ref
          .read(credentialsProvider.notifier)
          .updateBearerToken(data.accessToken);
      _ref.read(refreshCredentialsProvider.notifier).update(data.refreshToken);

      _ref.read(authUserProvider.notifier).setUser(data.user.toModel());

      return Result.success(data.user.toModel(), meta: response.meta);
    }

    return Result.failed(response.message, code: response.error?.code);
  }

  @override
  Future<Result<String>> refresh({required RefreshParams params}) async {
    final response = await _datasource.refresh(
      refreshToken: params.refreshToken,
      cancelToken: params.cancelToken,
    );
    if (response.success && response.data != null) {
      final data = response.data!;

      _ref
          .read(credentialsProvider.notifier)
          .updateBearerToken(data.accessToken);

      _ref.read(refreshCredentialsProvider.notifier).update(data.refreshToken);

      return Result.success(response.message, meta: response.meta);
    }
    return Result.failed(response.message, code: response.error?.code);
  }

  @override
  Future<Result<User>> register({required RegisterParams params}) async {
    final response = await _datasource.register(
      name: params.name,
      email: params.email,
      password: params.password,
      cancelToken: params.cancelToken,
    );

    if (response.success && response.data != null) {
      final data = response.data!;
      return Result.success(data.toModel());
    }
    return Result.failed(response.message, code: response.error?.code);
  }

  @override
  Future<Result<String>> logout({CancelToken? cancelToken}) async {
    final response = await _datasource.logout(cancelToken: cancelToken);
    if (response.success && response.data != null) {
      _ref.read(credentialsProvider.notifier).update(null);
      _ref.read(refreshCredentialsProvider.notifier).update(null);
      _ref.invalidate(authUserProvider);
      return Result.success(response.message, meta: response.meta);
    }
    return Result.failed(response.message, code: response.error?.code);
  }
}

@riverpod
AuthRepository authRepository(Ref ref) =>
    AuthRepositoryImpl(datasource: ref.watch(authDataSourceProvider), ref: ref);
