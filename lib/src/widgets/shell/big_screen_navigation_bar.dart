import 'package:flutter/material.dart';
import 'package:xchat/src/constants/navigation_bar_data.dart';
import 'package:xchat/src/features/auth/presentation/widgets/app_logo.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';

class BigScreenNavigationBar extends StatelessWidget {
  const BigScreenNavigationBar({super.key, required this.selectedScreen});

  final String selectedScreen;

  NavigationRailDestination getNavigationRailDestination(
    BuildContext context,
    NavigationBarData data,
  ) {
    return NavigationRailDestination(
      icon: data.icon,
      label: Text(data.label(context)),
      selectedIcon: data.activeIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget leadingIcon;
    if (context.isDesktop) {
      leadingIcon = AppLogo();
    } else {
      leadingIcon = AppLogo();
    }

    return NavigationRail(
      useIndicator: true,
      elevation: 5,
      extended: context.isDesktop,
      labelType: context.isDesktop
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      leading: leadingIcon,
      destinations: NavigationBarData.navList
          .map<NavigationRailDestination>(
            (e) => getNavigationRailDestination(context, e),
          )
          .toList(),
      selectedIndex: NavigationBarData.indexWherePathOrZero(selectedScreen),
      onDestinationSelected: (value) =>
          NavigationBarData.navList[value].go(context),
    );
  }
}
