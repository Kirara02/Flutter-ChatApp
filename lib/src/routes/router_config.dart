import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:xchat/src/features/auth/presentation/login/login_screen.dart';
import 'package:xchat/src/features/auth/presentation/register/register_screen.dart';
import 'package:xchat/src/features/auth/presentation/splash/splash_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/features/main/presentation/chat/chat_screen.dart';
import 'package:xchat/src/features/main/presentation/chats/chats_screen.dart';
import 'package:xchat/src/features/main/presentation/profile/profile_screen.dart';
import 'package:xchat/src/widgets/shell/shell_screen.dart';

part 'router_config.g.dart';
part 'sub_routes/auth_routes.dart';
part 'sub_routes/shell_routes.dart';
part 'sub_routes/chat_routes.dart';
part 'sub_routes/profile_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'lc shell');

abstract class Routes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';

  static const mainpage = '/main';
  static const chats = '/chats';
  static const profile = '/profile';

}

@riverpod
GoRouter routerConfig(Ref ref) {
  return GoRouter(
    routes: $appRoutes,
    debugLogDiagnostics: true,
    initialLocation: Routes.splash,
    navigatorKey: rootNavigatorKey,
  );
}
