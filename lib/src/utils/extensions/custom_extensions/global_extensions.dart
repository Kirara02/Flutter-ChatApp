part of '../custom_extensions.dart';

extension ResultExtension<T> on Result<T> {
  /// Branching success vs failed (UI/Provider Layer)
  R when<R>({
    required R Function(T value, Meta? meta) success,
    required R Function(String message, int? code) failed,
  }) {
    if (this is Success<T>) {
      final s = this as Success<T>;
      return success(s.value, s.meta);
    } else if (this is Failed<T>) {
      final f = this as Failed<T>;
      return failed(f.message, f.code);
    }
    throw Exception('Unhandled case in Result.when');
  }

  /// Functional reduce menjadi single value (data/logic layer)
  R fold<R>(
    R Function(T value) onSuccess,
    R Function(String message, int? code) onFailed,
  ) {
    if (this is Success<T>) {
      final s = this as Success<T>;
      return onSuccess(s.value);
    } else if (this is Failed<T>) {
      final f = this as Failed<T>;
      return onFailed(f.message, f.code);
    }
    throw Exception('Unhandled case in Result.fold');
  }

  /// Map Success value saja (misal transform type), failed tetap aman
  Result<R> mapSuccess<R>(R Function(T value) transform) {
    if (this is Success<T>) {
      final s = this as Success<T>;
      return Success<R>(transform(s.value), meta: s.meta);
    } else if (this is Failed<T>) {
      final f = this as Failed<T>;
      return Failed<R>(f.message, code: f.code);
    }
    throw Exception('Unhandled case in Result.mapSuccess');
  }

  R? whenOrNull<R>({
    R Function(T value, Meta? meta)? success,
    R Function(String message, int? code)? failed,
  }) {
    if (this is Success<T>) {
      final s = this as Success<T>;
      return success?.call(s.value, s.meta);
    } else if (this is Failed<T>) {
      final f = this as Failed<T>;
      return failed?.call(f.message, f.code);
    }
    return null;
  }
}
