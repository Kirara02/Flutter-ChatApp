// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_specify_types, public_member_api_docs

part of 'router_config.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $splashRoute,
  $loginRoute,
  $registerRoute,
  $shellRoute,
  $settingsRoute,
];

RouteBase get $splashRoute => GoRouteData.$route(
  path: '/',

  parentNavigatorKey: SplashRoute.$parentNavigatorKey,

  factory: _$SplashRoute._fromState,
);

mixin _$SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginRoute => GoRouteData.$route(
  path: '/login',

  parentNavigatorKey: LoginRoute.$parentNavigatorKey,

  factory: _$LoginRoute._fromState,
);

mixin _$LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location('/login');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $registerRoute => GoRouteData.$route(
  path: '/register',

  parentNavigatorKey: RegisterRoute.$parentNavigatorKey,

  factory: _$RegisterRoute._fromState,
);

mixin _$RegisterRoute on GoRouteData {
  static RegisterRoute _fromState(GoRouterState state) => const RegisterRoute();

  @override
  String get location => GoRouteData.$location('/register');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $shellRoute => StatefulShellRouteData.$route(
  factory: $ShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      initialLocation: ChatsBranch.$initialLocation,

      routes: [
        GoRouteData.$route(
          path: '/chats',

          factory: _$ChatsRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: ':roomId',

              factory: _$ChatRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'detail',

                  factory: _$ChatDetailRoute._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      initialLocation: StoriesBranch.$initialLocation,

      routes: [
        GoRouteData.$route(
          path: '/stories',

          factory: _$StoriesRoute._fromState,
        ),
      ],
    ),
  ],
);

extension $ShellRouteExtension on ShellRoute {
  static ShellRoute _fromState(GoRouterState state) => const ShellRoute();
}

mixin _$ChatsRoute on GoRouteData {
  static ChatsRoute _fromState(GoRouterState state) => const ChatsRoute();

  @override
  String get location => GoRouteData.$location('/chats');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ChatRoute on GoRouteData {
  static ChatRoute _fromState(GoRouterState state) => ChatRoute(
    roomId: state.pathParameters['roomId']!,
    $extra: state.extra as String?,
  );

  ChatRoute get _self => this as ChatRoute;

  @override
  String get location =>
      GoRouteData.$location('/chats/${Uri.encodeComponent(_self.roomId)}');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin _$ChatDetailRoute on GoRouteData {
  static ChatDetailRoute _fromState(GoRouterState state) => ChatDetailRoute(
    roomId: state.pathParameters['roomId']!,
    $extra: state.extra as String?,
  );

  ChatDetailRoute get _self => this as ChatDetailRoute;

  @override
  String get location => GoRouteData.$location(
    '/chats/${Uri.encodeComponent(_self.roomId)}/detail',
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

mixin _$StoriesRoute on GoRouteData {
  static StoriesRoute _fromState(GoRouterState state) => const StoriesRoute();

  @override
  String get location => GoRouteData.$location('/stories');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsRoute => GoRouteData.$route(
  path: '/settings',

  parentNavigatorKey: SettingsRoute.$parentNavigatorKey,

  factory: _$SettingsRoute._fromState,
  routes: [
    GoRouteData.$route(path: 'profile', factory: _$ProfileRoute._fromState),
  ],
);

mixin _$SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location('/settings/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routerConfigHash() => r'8980981c643405e79a230534a471dec0a0504c3b';

/// See also [routerConfig].
@ProviderFor(routerConfig)
final routerConfigProvider = AutoDisposeProvider<GoRouter>.internal(
  routerConfig,
  name: r'routerConfigProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routerConfigHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouterConfigRef = AutoDisposeProviderRef<GoRouter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
