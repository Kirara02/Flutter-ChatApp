import 'package:xchat/src/core/serializable.dart';

class Language extends MapSerializable {
  Language.fromMap(super.map) : super.fromMap();

  String? get code => this['code'];
  String? get name => this['name'];
  String? get nativeName => this['nativeName'] ?? this['native_name'];

  String? get displayName => nativeName ?? name ?? code;
}
