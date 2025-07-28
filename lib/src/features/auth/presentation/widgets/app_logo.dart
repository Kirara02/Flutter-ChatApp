import 'package:flutter/material.dart';
import 'package:xchat/src/constants/gen/assets.gen.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Assets.images.xLogo.image(width: 42, height: 42),
        const SizedBox(width: 4),
        Text(
          'Chat',
          style: context.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
