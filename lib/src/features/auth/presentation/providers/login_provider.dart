import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/auth/domain/usecase/login/login_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_provider.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  CancelToken? _cancelToken;

  @override
  FutureOr<User?> build() {
    ref.onDispose(() {
      _cancelToken?.cancel("Notifier was disposed.");
    });

    return null;
  }

  Future<void> login({required String email, required String password}) async {
    _cancelToken?.cancel("Memulai request login baru.");
    _cancelToken = CancelToken();

    state = const AsyncLoading();

    final usecase = ref.read(loginProvider);
    final result = await usecase.call(
      LoginParams(email: email, password: password, cancelToken: _cancelToken),
    );

    if (_cancelToken?.isCancelled ?? false) {
      return;
    }

    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
    }
  }

  void cancelLogin() {
    if (state.isLoading) {
      _cancelToken?.cancel("Login dibatalkan oleh pengguna.");
      state = AsyncError(FlutterError("Login dibatalkan."), StackTrace.current);
    }
  }
}
