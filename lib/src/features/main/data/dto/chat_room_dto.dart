import 'package:xchat/src/core/serializable.dart';
import 'package:xchat/src/features/auth/data/dto/user_dto.dart';

class ChatRoomDto extends MapSerializable {
  ChatRoomDto.fromMap(super.data) : super.fromMap();

  int get id => this['id'];
  String get name => this['name'];
  bool get isGroup => this['is_group'];
  bool get isPrivate => this['is_private'];
  List<UserDto>? get users => getNestedList('users', UserDto.fromMap);
  int? get ownerId => this['owner_id'];
  String? get lastMessage => this['last_message'];
  String? get lastMessageAtRaw => this['last_message_at'];
  String get createdAtRaw => this['created_at'];

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'is_group': isGroup,
      'is_private': isPrivate,
      'users': users?.map((e) => e.toMap()).toList() ?? [],
      'owner_id': ownerId,
      'last_message': lastMessage,
      'last_message_at': lastMessageAtRaw,
      'created_at': createdAtRaw,
    };
  }
}
