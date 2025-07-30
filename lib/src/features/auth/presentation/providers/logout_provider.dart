import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/domain/usecase/logout/logout_usecase.dart';
import 'package:xchat/src/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:xchat/src/global_providers/global_providers.dart';
import 'package:xchat/src/utils/print.dart';

part 'logout_provider.g.dart';

@riverpod
class LogoutNotifier extends _$LogoutNotifier {
  @override
  FutureOr<void> build() {}

  Future<void> logout() async {
    state = const AsyncLoading();

    final logoutUsecase = ref.read(logoutProvider);

    final result = await logoutUsecase(null);

    switch (result) {
      case Success():
        state = const AsyncData(null);
      case Failed(:final message):
        if (message.contains("cancelled")) {
          state = AsyncData(null);
        } else {
          printIfDebug("error: $message");
          state = AsyncError(FlutterError(message), StackTrace.current);
        }
    }
  }

  Future<void> forceLogout() async {
    try {
      ref.read(credentialsProvider.notifier).update(null);
      ref.read(refreshCredentialsProvider.notifier).update(null);
      ref.invalidate(authUserProvider);
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
