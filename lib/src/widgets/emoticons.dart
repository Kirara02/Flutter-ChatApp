import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../constants/app_sizes.dart';
import '../utils/extensions/custom_extensions.dart';

const errorFaces = ['(･o･;)', 'Σ(ಠ_ಠ)', 'ಥ_ಥ', '(˘･_･˘)', '(；￣Д￣)', '(･Д･。'];

final randomErrorFaceProvider = Provider<String>((Ref ref) {
  return errorFaces.getRandom!;
});

class Emoticons extends ConsumerWidget {
  const Emoticons({super.key, this.text, this.button, this.iconData});
  final String? text;
  final IconData? iconData;
  final Widget? button;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorFace = ref.read(randomErrorFaceProvider);
    return Padding(
      padding: KEdgeInsets.a8.size,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconData != null
                ? Icon(iconData, size: context.height * .2)
                : Text(
                    errorFace,
                    textAlign: TextAlign.center,
                    style: context.textTheme.displayMedium,
                  ),
            const Gap(16),
            if (text.isNotBlank)
              Text(
                text!,
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            if (button != null) button!,
          ],
        ),
      ),
    );
  }
}
