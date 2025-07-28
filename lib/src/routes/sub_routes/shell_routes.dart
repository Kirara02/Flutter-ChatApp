part of '../router_config.dart';

@TypedStatefulShellRoute<ShellRoute>(
  branches: [
    TypedStatefulShellBranch<ChatsBranch>(
      routes: [
        TypedGoRoute<ChatsRoute>(
          path: Routes.chats,
          routes: [TypedGoRoute<ChatRoute>(path: ':roomId')],
        ),
      ],
    ),
    TypedStatefulShellBranch<ProfileBranch>(
      routes: [TypedGoRoute<ProfileRoute>(path: Routes.profile)],
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
