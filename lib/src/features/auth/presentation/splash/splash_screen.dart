import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xchat/src/features/auth/presentation/providers/auth_user_provider.dart';
import 'package:xchat/src/features/auth/presentation/widgets/app_logo.dart';
import 'package:xchat/src/routes/router_config.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authUserProvider, (prev, next) {
      if (next.isLoading) return;

      if (next is AsyncData) {
        if (next.value != null) {
          const ChatsRoute().go(context);
        } else {
          const LoginRoute().go(context);
        }
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    return const Scaffold(body: Center(child: AppLogo()));
  }
}
