import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/core/usecase.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/main/data/repository/user_repository_impl.dart';
import 'package:xchat/src/features/main/domain/repository/user_repository.dart';
import 'package:xchat/src/features/main/domain/usecase/search_users/search_users_params.dart';

part 'search_users_usecase.g.dart';

class SearchUsers implements UseCase<Result<List<User>>, SearchUsersParams> {
  final UserRepository _repository;

  SearchUsers({required UserRepository repository}) : _repository = repository;
  @override
  Future<Result<List<User>>> call(SearchUsersParams params) async {
    return await _repository.searchUsers(params: params);
  }
}

@riverpod
SearchUsers searchUsers(Ref ref) =>
    SearchUsers(repository: ref.watch(userRepositoryProvider));
