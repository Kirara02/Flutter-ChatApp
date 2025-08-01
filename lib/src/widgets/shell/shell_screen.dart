import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xchat/src/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:xchat/src/routes/router_config.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';
import 'package:xchat/src/utils/route_ui_config.dart';
import 'package:xchat/src/widgets/shell/big_screen_navigation_bar.dart';
import 'package:xchat/src/widgets/shell/small_screen_navigation_bar.dart';

class ShellScreen extends ConsumerWidget {
  const ShellScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authUserProvider, (prev, next) {
      if (prev != null && next is AsyncData && next.value == null) {
        LoginRoute().go(context);
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    final location = context.location;

    final ui = getRouteUIConfig(
      context: context,
      location: location,
      onSettings: () => SettingsRoute().push(rootNavigatorKey.currentContext!),
    );

    final showNavBar =
        location == ChatsRoute().location ||
        location == StoriesRoute().location;

    if (context.isTablet) {
      return Scaffold(
        body: Row(
          children: [
            // NavigationRail (sidebar) selalu ditampilkan di layar besar.
            BigScreenNavigationBar(selectedScreen: context.location),
            // Expanded berisi Scaffold untuk area konten utama.
            Expanded(
              child: Scaffold(
                appBar: ui.appBar,
                body: child,
                floatingActionButton: ui.floatingActionButton,
              ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: ui.appBar,
        body: child,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: ui.floatingActionButton,
        bottomNavigationBar: showNavBar
            ? SmallScreenNavigationBar(selectedScreen: location)
            : null,
      );
    }
  }
}
