import 'package:xchat/src/core/serializable.dart';
import 'package:xchat/src/features/auth/data/dto/user_dto.dart';

class LoginDto extends MapSerializable {
  LoginDto.fromMap(super.map) : super.fromMap();

  String get accessToken => this['access_token'];
  String get refreshToken => this['refresh_token'];
  UserDto get user => getNested('user', UserDto.fromMap);

  @override
  Map<String, dynamic> toMap() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'user': user.toMap(),
  };
}
