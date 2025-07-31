import 'package:dio/dio.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/settings/domain/usecase/update_profile/update_profile_params.dart';

abstract interface class ProfileRepository {
  Future<Result<User>> getProfile({CancelToken? cancelToken});
  Future<Result<User>> updateProfile({required UpdateProfileParams params});
}
