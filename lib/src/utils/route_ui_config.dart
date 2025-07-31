import 'package:flutter/material.dart';
import 'package:xchat/src/routes/router_config.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';

class RouteUIConfig {
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;

  const RouteUIConfig({this.appBar, this.floatingActionButton});
}

RouteUIConfig getRouteUIConfig({
  required BuildContext context,
  required String location,
  required VoidCallback onSettings,
}) {
  if (location.startsWith(const ChatRoute(roomId: '').location)) {
    return const RouteUIConfig();
  }

  if (location.contains(const ChatsRoute().location)) {
    return RouteUIConfig(
      appBar: AppBar(
        title: Text(
          context.l10n!.chats,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),

          // PopupMenuButton<String>(
          //   itemBuilder: (context) => [
          //     PopupMenuItem(
          //       value: 'settings',
          //       onTap: onSettings,
          //       child: Text('Settings'),
          //     ),
          //     PopupMenuItem(
          //       value: 'logout',
          //       onTap: onLogout,
          //       child: Text('Logout'),
          //     ),
          //   ],
          // ),
          IconButton(
            onPressed: onSettings,
            icon: Icon(Icons.settings_outlined),
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
        child: const Icon(Icons.contacts_rounded),
      ),
    );
  }

  // Stories config
  if (location.contains(const StoriesRoute().location)) {
    return RouteUIConfig(
      appBar: AppBar(
        title: Text(context.l10n!.stories),
        actions: [
          // PopupMenuButton<String>(
          //   itemBuilder: (context) => [
          //     PopupMenuItem(
          //       value: 'settings',
          //       onTap: onSettings,
          //       child: Text('Settings'),
          //     ),
          //     PopupMenuItem(
          //       value: 'logout',
          //       onTap: onLogout,
          //       child: Text('Logout'),
          //     ),
          //   ],
          // ),
          IconButton(
            onPressed: onSettings,
            icon: Icon(Icons.settings_outlined),
          ),
        ],
      ),
    );
  }

  return const RouteUIConfig();
}
