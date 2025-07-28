part of '../custom_extensions.dart';

extension UserMapper on UserDto {
  User toModel() => User(id: id, name: name, email: email);
}

extension LoginMapper on LoginDto {
  LoginResult toModel() => LoginResult(
    accessToken: accessToken,
    refreshToken: refreshToken,
    user: user.toModel(),
  );
}

extension RefreshMapper on RefreshDto {
  RefreshResult toModel() =>
      RefreshResult(accessToken: accessToken, refreshToken: refreshToken);
}

extension ChatRoomMapper on ChatRoomDto {
  ChatRoom toModel() => ChatRoom(
    id: id,
    name: name,
    isGroup: isGroup,
    isPrivate: isPrivate,
    users: users?.map((e) => e.toModel()).toList(),
    ownerId: ownerId,
    lastMessage: lastMessage,
    lastMessageAt: lastMessageAtRaw != null
        ? DateTime.parse(lastMessageAtRaw!)
        : null,
    createdAt: DateTime.parse(createdAtRaw),
  );
}
