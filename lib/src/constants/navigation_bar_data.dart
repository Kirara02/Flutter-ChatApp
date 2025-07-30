import 'package:flutter/material.dart';
import '../routes/router_config.dart';

class NavigationBarData {
  final String Function(BuildContext context) label;
  final ValueSetter<BuildContext> go;
  final Widget icon;
  final Widget activeIcon;
  final List<String> activeOn;

  static int indexWherePathOrZero(String path) {
    final index = navList.indexWhere(
      (e) => e.activeOn.any((element) => path.contains(element)),
    );
    return index > 0 ? index : 0;
  }

  static final navList = [
    NavigationBarData(
      icon: Icon(Icons.chat_outlined),
      activeIcon: Icon(Icons.chat),
      label: (context) => "Chats",
      go: const ChatsRoute().go,
      activeOn: [const ChatsRoute().location],
    ),
    NavigationBarData(
      icon: Icon(Icons.update_outlined),
      activeIcon: Icon(Icons.update_rounded),
      label: (context) => "Story",
      go: const StoriesRoute().go,
      activeOn: [const StoriesRoute().location],
    ),
  ];

  NavigationBarData({
    required this.label,
    required this.go,
    required this.icon,
    required this.activeIcon,
    required this.activeOn,
  });
}
