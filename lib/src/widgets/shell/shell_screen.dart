import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xchat/src/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:xchat/src/features/auth/presentation/providers/logout_provider.dart';
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
    final uiConfig = getRouteUIConfig(context, ref, location);

    final showNavBar =
        location == ChatsRoute().location ||
        location == StoriesRoute().location;

    final appBar = getDynamicAppBar(context, location, ref);

    if (context.isTablet) {
      return Scaffold(
        appBar: appBar,
        body: Row(
          children: [
            BigScreenNavigationBar(selectedScreen: location),
            Expanded(child: child),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: uiConfig.appBar,
        body: child,
        floatingActionButton: uiConfig.floatingActionButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        bottomNavigationBar: showNavBar
            ? SmallScreenNavigationBar(selectedScreen: location)
            : null,
      );
    }
  }
}

AppBar? getDynamicAppBar(BuildContext context, String location, WidgetRef ref) {
  final logoutState = ref.watch(logoutNotifierProvider);

  if (location.contains(ChatsRoute().location)) {
    return AppBar(
      title: const Text('Chats', style: TextStyle(fontWeight: FontWeight.bold)),
      actions: [
        IconButton(icon: const Icon(Icons.search), onPressed: () {}),
        if (logoutState.isLoading)
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          )
        else
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'logout') {
                ref.read(logoutNotifierProvider.notifier).logout();
              }
            },
            itemBuilder: (BuildContext context) => const [
              PopupMenuItem<String>(value: 'logout', child: Text('Logout')),
            ],
          ),
      ],
    );
  }

  if (location.contains(StoriesRoute().location)) {
    return AppBar(
      title: const Text('Stories'),
      actions: [
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () {
            // TODO: Tambah Story
          },
        ),
      ],
    );
  }

  return null;
}
