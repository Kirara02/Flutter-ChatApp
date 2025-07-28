import 'package:xchat/src/core/serializable.dart';

class UserDto extends MapSerializable {
  UserDto.fromMap(super.map) : super.fromMap();

  int get id => this['id'];
  String get name => this['name'];
  String get email => this['email'];

  @override
  Map<String, dynamic> toMap() => {'id': id, 'name': name, 'email': email};
}
