import 'db_keys.dart';

abstract class Endpoints {
  // base url
  static String baseApi({
    String? baseUrl,
    int? port,
    bool addPort = true,
    bool appendApiToUrl = true,
  }) =>
      "${baseUrl ?? DBKeys.serverUrl.initial}"
      "${port != null && addPort ? ":$port" : ''}"
      "${appendApiToUrl ? '/api' : ''}";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(minutes: 1);

  // connectTimeout
  static const Duration connectionTimeout = Duration(minutes: 1);
}

abstract class AuthUrl {
  static const String login = 'web-api/auth/login';
  static const String profile = 'web-api/account/profile';
  static const String logout = 'web-api/auth/logout';
}