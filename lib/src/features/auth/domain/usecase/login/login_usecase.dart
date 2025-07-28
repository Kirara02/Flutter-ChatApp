import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/auth/domain/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_params.dart';
part 'login_usecase.g.dart';

class Login implements UseCase<Result<User>, LoginParams> {
  final AuthRepository _repository;

  Login({required AuthRepository repository}) : _repository = repository;

  @override
  Future<Result<User>> call(LoginParams params) async {
    return await _repository.login(params: params);
  }
}

@riverpod
Login login(Ref ref) => Login(repository: ref.watch(authRepositoryProvider));
