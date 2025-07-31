import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/settings/data/repository/profile_repository_impl.dart';
import 'package:xchat/src/features/settings/domain/repository/profile_repository.dart';
import 'package:xchat/src/features/settings/domain/usecase/update_profile/update_profile_params.dart';

part 'update_profile_usecase.g.dart';

class UpdateProfile implements UseCase<Result<User>, UpdateProfileParams> {
  final ProfileRepository _repository;

  UpdateProfile({required ProfileRepository repository})
    : _repository = repository;

  @override
  Future<Result<User>> call(UpdateProfileParams params) async {
    return await _repository.updateProfile(params: params);
  }
}

@riverpod
UpdateProfile updateProfile(Ref ref) =>
    UpdateProfile(repository: ref.read(profileRepositoryProvider));
