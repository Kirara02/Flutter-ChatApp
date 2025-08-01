import 'package:dio/dio.dart';

class SearchUsersParams {
  final String keyword;
  final CancelToken? cancelToken;

  SearchUsersParams({required this.keyword, this.cancelToken});
}
