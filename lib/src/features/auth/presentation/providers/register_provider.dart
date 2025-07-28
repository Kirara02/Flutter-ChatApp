import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/core/result.dart';
import 'package:xchat/src/features/auth/domain/model/user.dart';
import 'package:xchat/src/features/auth/domain/usecase/register/register_params.dart';
import 'package:xchat/src/features/auth/domain/usecase/register/register_usecase.dart';

part 'register_provider.g.dart';

@riverpod
class RegisterNotifier extends _$RegisterNotifier {
  CancelToken? _cancelToken;
  @override
  AsyncValue<User?> build() {
    ref.onDispose(() => _cancelToken?.cancel("Notifier was disposed."));
    return const AsyncData(null);
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    _cancelToken?.cancel("Memulai request registrasi baru.");
    _cancelToken = CancelToken();
    state = const AsyncLoading();
    final result = await ref
        .read(registerProvider)
        .call(
          RegisterParams(
            name: name,
            email: email,
            password: password,
            cancelToken: _cancelToken,
          ),
        );
    switch (result) {
      case Success(value: final user):
        state = AsyncData(user);
      case Failed(message: final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
    }
  }
}
