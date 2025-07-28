import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xchat/src/constants/enum.dart';
import 'package:xchat/src/core/logger/logger.dart';
import 'package:xchat/src/features/auth/presentation/providers/logout_provider.dart';
import 'package:xchat/src/global_providers/global_providers.dart';
import 'package:xchat/src/routes/router_config.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';
import 'package:xchat/src/utils/toast/toast.dart';

class HttpRequestInterceptor extends Interceptor {
  final Ref ref;
  final Dio dio;

  HttpRequestInterceptor(this.ref, this.dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final credentials = ref.read(credentialsProvider);
    final authType = ref.read(authTypeKeyProvider);

    if (authType == AuthType.basic) {
      if (credentials.isNotBlank) {
        options.headers.putIfAbsent(
          "Authorization",
          () => 'Basic $credentials',
        );
      } else {
        if (kDebugMode) {
          debugPrint('Basic credentials are null');
        }
      }
    } else if (authType == AuthType.bearer) {
      if (credentials.isNotBlank) {
        options.headers.putIfAbsent(
          "Authorization",
          () => 'Bearer $credentials',
        );
      } else {
        if (kDebugMode) {
          debugPrint('Bearer token is null');
        }
      }
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Periksa apakah error adalah 401 Unauthorized
    if (err.response?.statusCode == 401 || err.response?.statusCode == 409) {
      final context = rootNavigatorKey.currentContext;
      final statusCode = err.response?.statusCode;
      // KASUS 1: Error 401 terjadi di halaman Login (misalnya, password salah)
      if (err.requestOptions.path.contains('/login') ||
          err.requestOptions.path.contains('/register')) {
        logger.e(
          "Error ($statusCode) on ${err.requestOptions.uri.path} route. Displaying error toast.",
        );

        final String errorMessage =
            (err.response?.data is Map && err.response?.data['message'] != null)
            ? err.response!.data['message']
            : "Login gagal. Periksa kembali kredensial Anda.";

        if (context != null && context.mounted) {
          final toast = ref.read(toastProvider(context));
          toast.show(errorMessage, withMicrotask: true);
        }
      } else {
        logger.w(
          "Unauthorized (401) on ${err.requestOptions.path}. User will be logged out.",
        );

        final String errorMessage =
            (err.response?.data is Map && err.response?.data['message'] != null)
            ? err.response!.data['message']
            : "Sesi Anda telah berakhir. Silakan login kembali.";

        if (context != null && context.mounted) {
          final toast = ref.read(toastProvider(context));
          toast.show(errorMessage, withMicrotask: true);
        }

        final logoutRef = ref.read(logoutNotifierProvider.notifier);
        logoutRef.forceLogout();
      }
    }

    super.onError(err, handler);
  }
}
