part of '../router_config.dart';

@TypedStatefulShellRoute<ShellRoute>(
  branches: [
    TypedStatefulShellBranch<ChatsBranch>(
      routes: [
        TypedGoRoute<ChatsRoute>(
          path: Routes.chats,
          routes: [
            TypedGoRoute<CreateRoomRoute>(path: 'create'),
            TypedGoRoute<ChatRoute>(
              path: ':roomId',
              routes: [TypedGoRoute<ChatDetailRoute>(path: 'detail')],
            ),
          ],
        ),
      ],
    ),
    TypedStatefulShellBranch<StoriesBranch>(
      routes: [TypedGoRoute<StoriesRoute>(path: Routes.stories)],
    ),
  ],
)
class ShellRoute extends StatefulShellRouteData {
  const ShellRoute();

  static final GlobalKey<NavigatorState> $navigatorKey = _shellNavigatorKey;

  @override
  Widget builder(context, state, navigationShell) =>
      ShellScreen(child: navigationShell);
}
