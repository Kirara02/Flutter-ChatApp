import 'package:dio/dio.dart';

class UpdateProfileParams {
  final String? name;
  final String? email;
  final CancelToken? cancelToken;

  UpdateProfileParams({this.name, this.email, this.cancelToken});
}
