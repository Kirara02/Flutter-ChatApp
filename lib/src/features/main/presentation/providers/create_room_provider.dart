import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/main/domain/usecase/search_users/search_users_params.dart';
import 'package:xchat/src/features/main/domain/usecase/search_users/search_users_usecase.dart';

part 'create_room_provider.g.dart';

@riverpod
class CreateRoomNotifier extends _$CreateRoomNotifier {
  @override
  FutureOr<List<User>> build() {
    return [];
  }

  Future<void> searchUsers({required String keyword}) async {
    state = AsyncLoading();

    final result = await ref
        .read(searchUsersProvider)
        .call(SearchUsersParams(keyword: keyword));

    switch (result) {
      case Success(value: final users):
        state = AsyncData(users);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
    }
  }
}
