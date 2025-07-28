import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:xchat/src/features/auth/domain/repository/auth_repository.dart';

part 'logout_usecase.g.dart';

class Logout implements UseCase<Result<String>, CancelToken?> {
  final AuthRepository _repository;

  Logout({required AuthRepository repository}) : _repository = repository;
  @override
  Future<Result<String>> call(CancelToken? params) async {
    return await _repository.logout(cancelToken: params);
  }
}

@riverpod
Logout logout(Ref ref) => Logout(repository: ref.watch(authRepositoryProvider));
