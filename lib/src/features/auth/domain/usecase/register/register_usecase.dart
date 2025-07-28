import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/auth/domain/repository/auth_repository.dart';
import 'package:xchat/src/features/auth/domain/usecase/register/register_params.dart';

part 'register_usecase.g.dart';

class Register implements UseCase<Result<User>, RegisterParams> {
  final AuthRepository _repository;

  Register({required AuthRepository repository}) : _repository = repository;
  @override
  Future<Result<User>> call(RegisterParams params) async {
    return await _repository.register(params: params);
  }
}

@riverpod
Register register(Ref ref) =>
    Register(repository: ref.read(authRepositoryProvider));
