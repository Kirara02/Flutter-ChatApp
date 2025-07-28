part of 'login_usecase.dart';

class LoginParams {
  final String email;
  final String password;
  final CancelToken? cancelToken;

  LoginParams({required this.email, required this.password, this.cancelToken});
}
