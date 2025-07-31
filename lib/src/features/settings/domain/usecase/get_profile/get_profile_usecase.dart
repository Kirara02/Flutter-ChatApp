import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/settings/data/repository/profile_repository_impl.dart';
import 'package:xchat/src/features/settings/domain/repository/profile_repository.dart';

part 'get_profile_usecase.g.dart';

class GetProfile implements UseCase<Result<User>, CancelToken?> {
  final ProfileRepository _repository;

  GetProfile({required ProfileRepository repository}) : _repository = repository;

  @override
  Future<Result<User>> call(CancelToken? cancelToken) async {
    return await _repository.getProfile(cancelToken: cancelToken);
  }
}

@riverpod
GetProfile getProfile(Ref ref) =>
    GetProfile(repository: ref.read(profileRepositoryProvider));
