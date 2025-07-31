import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/main/domain/usecase/search_users/search_users_params.dart';

abstract interface class UserRepository {
  Future<Result<List<User>>> searchUsers({required SearchUsersParams params});
}
