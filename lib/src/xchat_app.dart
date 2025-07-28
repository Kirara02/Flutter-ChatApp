import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xchat/src/constants/theme.dart';
import 'package:xchat/src/global_providers/global_providers.dart';
import 'package:xchat/src/l10n/generated/app_localizations.dart';
import 'package:xchat/src/routes/router_config.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';
import 'package:xchat/src/widgets/theme/app_theme_mode_tile.dart';

class XchatApp extends ConsumerWidget {
  const XchatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routes = ref.watch(routerConfigProvider);
    final appLocale = ref.watch(l10nProvider);
    final appThemeMode = ref.watch(appThemeModeProvider);

    return MaterialApp.router(
      builder: FToastBuilder(),
      onGenerateTitle: (context) => context.l10n!.app_name,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      locale: appLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: appThemeMode,
      routerConfig: routes,
    );
  }
}
