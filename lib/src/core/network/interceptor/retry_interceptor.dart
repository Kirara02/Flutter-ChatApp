import 'dart:async';
import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetryAttempts;
  final Duration retryDelay;

  RetryInterceptor({
    required this.dio,
    this.maxRetryAttempts = 3,
    this.retryDelay = const Duration(seconds: 2),
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    var attempt = err.requestOptions.extra['retry_attempt'] ?? 0;

    if (_shouldRetry(err) && attempt < maxRetryAttempts) {
      attempt += 1;
      err.requestOptions.extra['retry_attempt'] = attempt;

      await Future.delayed(retryDelay);

      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.receiveTimeout;
  }
}
