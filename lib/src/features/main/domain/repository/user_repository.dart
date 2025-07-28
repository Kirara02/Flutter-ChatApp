import 'package:dio/dio.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/main/domain/usecase/search_users/search_users_params.dart';
import 'package:xchat/src/features/main/domain/usecase/update_profile/update_profile_params.dart';

abstract class UserRepository {
  Future<Result<User>> getProfile({CancelToken? cancelToken});
  Future<Result<User>> updateProfile({required UpdateProfileParams params});
  Future<Result<List<User>>> searchUsers({required SearchUsersParams params});
}
