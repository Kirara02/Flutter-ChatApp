import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/main/data/repository/user_repository_impl.dart';
import 'package:xchat/src/features/main/domain/repository/user_repository.dart';
import 'package:xchat/src/features/main/domain/usecase/update_profile/update_profile_params.dart';

part 'update_profile_usecase.g.dart';

class UpdateProfile implements UseCase<Result<User>, UpdateProfileParams> {
  final UserRepository _repository;

  UpdateProfile({required UserRepository repository})
    : _repository = repository;

  @override
  Future<Result<User>> call(UpdateProfileParams params) async {
    return await _repository.updateProfile(params: params);
  }
}

@riverpod
UpdateProfile updateProfile(Ref ref) =>
    UpdateProfile(repository: ref.read(userRepositoryProvider));
