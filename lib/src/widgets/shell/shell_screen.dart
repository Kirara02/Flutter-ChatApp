import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xchat/src/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:xchat/src/routes/router_config.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';
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

    if (context.isTablet) {
      return Scaffold(
        body: Row(
          children: [
            BigScreenNavigationBar(selectedScreen: context.location),
            Expanded(child: child),
          ],
        ),
      );
    } else {
      return Scaffold(
        body: child,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomNavigationBar: SmallScreenNavigationBar(
          selectedScreen: context.location,
        ),
      );
    }
  }
}
