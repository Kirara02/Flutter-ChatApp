part of '../router_config.dart';

class StoriesBranch extends StatefulShellBranchData {
  static final $initialLocation = const StoriesRoute().location;
  const StoriesBranch();
}

class StoriesRoute extends GoRouteData with _$StoriesRoute {
  const StoriesRoute();
  @override
  Widget build(context, state) => StoriesScreen();
}
