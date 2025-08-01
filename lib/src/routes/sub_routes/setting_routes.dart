part of '../router_config.dart';

@TypedGoRoute<SettingsRoute>(
  path: Routes.settings,
  routes: [TypedGoRoute<ProfileRoute>(path: 'profile')],
)
class SettingsRoute extends GoRouteData with _$SettingsRoute {
  const SettingsRoute();

  static final GlobalKey<NavigatorState> $parentNavigatorKey = rootNavigatorKey;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const SettingsScreen();
}

class ProfileRoute extends GoRouteData with _$ProfileRoute {
  const ProfileRoute();
  @override
  Widget build(context, state) => ProfileScreen();
}
