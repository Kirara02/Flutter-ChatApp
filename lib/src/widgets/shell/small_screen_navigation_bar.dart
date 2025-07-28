import 'package:flutter/material.dart';
import 'package:xchat/src/constants/navigation_bar_data.dart';

class SmallScreenNavigationBar extends StatelessWidget {
  const SmallScreenNavigationBar({super.key, required this.selectedScreen});

  final String selectedScreen;

  NavigationDestination getNavigationDestination(
    BuildContext context,
    NavigationBarData data,
  ) {
    return NavigationDestination(
      icon: data.icon,
      label: data.label(context),
      selectedIcon: data.activeIcon,
      tooltip: data.label(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
      child: NavigationBar(
        selectedIndex: NavigationBarData.indexWherePathOrZero(selectedScreen),
        onDestinationSelected: (value) =>
            NavigationBarData.navList[value].go(context),
        destinations: NavigationBarData.navList
            .map<NavigationDestination>(
              (e) => getNavigationDestination(context, e),
            )
            .toList(),
      ),
    );
  }
}
