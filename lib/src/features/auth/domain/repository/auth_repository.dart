import 'package:dio/dio.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/auth/domain/usecase/login/login_usecase.dart';
import 'package:xchat/src/features/auth/domain/usecase/refresh/refresh_params.dart';
import 'package:xchat/src/features/auth/domain/usecase/register/register_params.dart';

abstract interface class AuthRepository {
  Future<Result<User>> login({required LoginParams params});

  Future<Result<User>> register({required RegisterParams params});

  Future<Result<String>> refresh({required RefreshParams params});

  Future<Result<String>> logout({CancelToken? cancelToken});
}
