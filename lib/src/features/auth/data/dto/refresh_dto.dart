import 'package:xchat/src/core/serializable.dart';

class RefreshDto extends MapSerializable {
  RefreshDto.fromMap(super.map) : super.fromMap();

  String get accessToken => this['access_token'];
  String get refreshToken => this['refresh_token'];

  @override
  Map<String, dynamic> toMap() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
  };
}