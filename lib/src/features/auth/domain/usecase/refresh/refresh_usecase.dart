import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:xchat/src/features/auth/domain/repository/auth_repository.dart';
import 'package:xchat/src/features/auth/domain/usecase/refresh/refresh_params.dart';

part 'refresh_usecase.g.dart';

class Refresh implements UseCase<Result<String>, RefreshParams> {
  final AuthRepository _repository;

  Refresh({required AuthRepository repository}) : _repository = repository;
  @override
  Future<Result<String>> call(RefreshParams params) async {
    return await _repository.refresh(params: params);
  }
}

@riverpod
Refresh refresh(Ref ref) =>
    Refresh(repository: ref.read(authRepositoryProvider));
