import 'package:dio/dio.dart';

class RegisterParams {
  final String name;
  final String email;
  final String password;
  final CancelToken? cancelToken;

  RegisterParams({
    required this.name,
    required this.email,
    required this.password,
    this.cancelToken
  });
}
