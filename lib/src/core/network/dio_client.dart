import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:xchat/src/core/logger/logger.dart';
import 'dio_error_util.dart';
import 'response/api_response.dart';

typedef JsonConverter<T> = T Function(Map<String, dynamic> json);
typedef ListJsonConverter<T> = T Function(Map<String, dynamic> json);

class DioClient {
  final Dio dio;
  DioClient({required this.dio});

  /// GET Request
  Future<ApiResponse<T>> getApiData<T, TItem>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    T Function(Map<String, dynamic> json)? converter,
    TItem Function(Map<String, dynamic> json)? itemConverter,
  }) async {
    return _handleRequest<T, TItem>(
      () => dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      ),
      converter: converter,
      itemConverter: itemConverter,
    );
  }

  /// POST Request
  Future<ApiResponse<T>> postApiData<T, TItem>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    T Function(Map<String, dynamic> json)? converter,
    TItem Function(Map<String, dynamic> json)? itemConverter,
  }) async {
    return _handleRequest<T, TItem>(
      () => dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      converter: converter,
      itemConverter: itemConverter,
    );
  }

  /// PUT Request
  Future<ApiResponse<T>> putApiData<T, TItem>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    T Function(Map<String, dynamic> json)? converter,
    TItem Function(Map<String, dynamic> json)? itemConverter,
  }) async {
    return _handleRequest<T, TItem>(
      () => dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      ),
      converter: converter,
      itemConverter: itemConverter,
    );
  }

  /// DELETE Request
  Future<ApiResponse<T>> deleteApiData<T, TItem>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    T Function(Map<String, dynamic> json)? converter,
    TItem Function(Map<String, dynamic> json)? itemConverter,
  }) async {
    return _handleRequest<T, TItem>(
      () => dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      ),
      converter: converter,
      itemConverter: itemConverter,
    );
  }

  /// Core handler untuk semua method
  Future<ApiResponse<T>> _handleRequest<T, TItem>(
    Future<Response> Function() request, {
    T Function(Map<String, dynamic> json)? converter,
    TItem Function(Map<String, dynamic> json)? itemConverter,
  }) async {
    try {
      final response = await request();
      final jsonData = response.data;
      dynamic parsedData;

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        final rawData = jsonData['data'];

        // Handle List<T>
        if (itemConverter != null) {
          if (rawData is String) {
            parsedData = await _decodeAndConvertList<TItem>(
              rawData,
              itemConverter,
            );
          } else if (rawData is List) {
            parsedData = await compute<List<dynamic>, List<TItem>>(
              (list) => list
                  .map((item) => itemConverter(item as Map<String, dynamic>))
                  .toList(),
              rawData,
            );
          }
        }
        // Handle Single T
        else if (converter != null) {
          if (rawData is String) {
            final decoded = jsonDecode(rawData);
            parsedData = await compute<Map<String, dynamic>, T>(
              converter,
              Map<String, dynamic>.from(decoded),
            );
          } else if (rawData is Map) {
            parsedData = await compute<Map<String, dynamic>, T>(
              converter,
              Map<String, dynamic>.from(rawData),
            );
          }
        }

        logger.i(response);

        final finalJson = Map<String, dynamic>.from(jsonData)
          ..['data'] = parsedData;

        return ApiResponse<T>.fromMap(finalJson, fromJsonT: (_) => parsedData);
      }

      final errorMessage = jsonData?['message'] ?? 'Unknown error';

      return ApiResponse<T>.fromMap({
        'success': false,
        'message': errorMessage,
        'meta': {'timestamp': DateTime.now().toIso8601String()},
        'error': {'code': response.statusCode ?? 0, 'details': errorMessage},
      });
    } on DioException catch (e) {
      final msg = DioErrorUtil.handleError(e);
      logger.d("Dio error: ${e.response}");
      return ApiResponse<T>.fromMap({
        'success': false,
        'message': msg,
        'meta': {'timestamp': DateTime.now().toIso8601String()},
        'error': {'code': e.response?.statusCode ?? 0, 'details': msg},
      });
    } catch (e) {
      logger.i("Unknown error: $e");
      return ApiResponse<T>.fromMap({
        'success': false,
        'message': e.toString(),
        'meta': {'timestamp': DateTime.now().toIso8601String()},
        'error': {'code': 500, 'details': e.toString()},
      });
    }
  }

  Future<List<T>> _decodeAndConvertList<T>(
    String source,
    T Function(Map<String, dynamic>) converter,
  ) async {
    final list = (jsonDecode(source) as List)
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    return compute((list) => list.map(converter).toList(), list);
  }
}
