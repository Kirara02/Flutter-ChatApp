part of '../router_config.dart';

class ProfileBranch extends StatefulShellBranchData {
  static final $initialLocation = const ProfileRoute().location;
  const ProfileBranch();
}

class ProfileRoute extends GoRouteData with _$ProfileRoute {
  const ProfileRoute();
  @override
  Widget build(context, state) => ProfileScreen();
}
