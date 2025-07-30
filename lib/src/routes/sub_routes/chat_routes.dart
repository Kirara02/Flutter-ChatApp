part of '../router_config.dart';

class ChatsBranch extends StatefulShellBranchData {
  static final $initialLocation = const ChatsRoute().location;
  const ChatsBranch();
}

class ChatsRoute extends GoRouteData with _$ChatsRoute {
  const ChatsRoute();
  @override
  Widget build(context, state) => ChatsScreen();
}

class ChatRoute extends GoRouteData with _$ChatRoute {
  final String roomId;
  final String? $extra;
  const ChatRoute({required this.roomId, this.$extra});

  @override
  Widget build(context, state) =>
      ChatScreen(roomId: int.parse(roomId), roomName: state.extra as String);
}

class ChatDetailRoute extends GoRouteData with _$ChatDetailRoute {
  final String roomId;
  final String? $extra;
  const ChatDetailRoute({required this.roomId, this.$extra});

  @override
  Widget build(context, state) => ChatDetailScreen(roomId: int.parse(roomId));
}
