import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/settings/domain/usecase/get_profile/get_profile_usecase.dart';
import 'package:xchat/src/global_providers/global_providers.dart';

part 'auth_user_provider.g.dart';

@Riverpod(keepAlive: true)
class AuthUser extends _$AuthUser {
  @override
  FutureOr<User?> build() async {
    final cancelToken = CancelToken();

    ref.onDispose(() {
      cancelToken.cancel('Provider disposed or invalidated');
    });

    final credentials = ref.read(credentialsProvider);
    if (credentials == null) return null;

    final GetProfile getUser = ref.read(getProfileProvider);
    final result = await getUser.call(cancelToken);

    return switch (result) {
      Success(value: final user) => user,
      _ => null,
    };
  }

  void setUser(User user) {
    state = AsyncData(user);
  }
}
