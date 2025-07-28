import 'package:dio/dio.dart';

class RefreshParams {
  final String refreshToken;
  final CancelToken? cancelToken;

  RefreshParams({required this.refreshToken, required this.cancelToken});
}
