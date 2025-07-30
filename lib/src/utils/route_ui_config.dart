import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xchat/src/features/auth/presentation/providers/logout_provider.dart';
import 'package:xchat/src/routes/router_config.dart';

class RouteUIConfig {
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  const RouteUIConfig({this.appBar, this.floatingActionButton});
}

RouteUIConfig getRouteUIConfig(
  BuildContext context,
  WidgetRef ref,
  String location,
) {
  final logoutState = ref.watch(logoutNotifierProvider);

  if (location.contains(const ChatsRoute().location)) {
    return RouteUIConfig(
      appBar: AppBar(
        title: const Text(
          'Chats',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                switch (value) {
                  case 'logout':
                    ref.read(logoutNotifierProvider.notifier).logout();
                    break;
                  case 'settings':
                    break;
                }
              },
              itemBuilder: (BuildContext context) => const [
                PopupMenuItem<String>(
                  value: 'settings',
                  child: Text('Settings'),
                ),
                PopupMenuItem<String>(value: 'logout', child: Text('Logout')),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Navigasi ke halaman daftar pengguna...'),
            ),
          );
        },
        child: const Icon(Icons.message),
      ),
    );
  }

  if (location.contains(const StoriesRoute().location)) {
    return RouteUIConfig(appBar: AppBar(title: const Text('Stories')));
  }

  return const RouteUIConfig();
}
