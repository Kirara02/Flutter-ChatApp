import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xchat/src/constants/language_list.dart';
import 'package:xchat/src/features/auth/presentation/providers/logout_provider.dart';
import 'package:xchat/src/global_providers/global_providers.dart';
import 'package:xchat/src/l10n/generated/app_localizations.dart';
import 'package:xchat/src/routes/router_config.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';
import 'package:xchat/src/widgets/radio_list_popup.dart';
import 'package:xchat/src/widgets/theme/app_theme_mode_tile.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(logoutNotifierProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: ${error.toString()}')));
        },
      );
    });

    final logoutState = ref.watch(logoutNotifierProvider);

    void showLogoutConfirmationDialog() {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(dialogContext).pop(),
              ),
              TextButton(
                child: const Text('Logout'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  ref.read(logoutNotifierProvider.notifier).logout();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n!.settings),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: Text(context.l10n!.profile),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => ProfileRoute().push(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: Text(context.l10n!.change_password),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              /* Navigasi ke halaman ganti password */
            },
          ),
          const Divider(),
          const AppThemeModeTile(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: Text(context.l10n!.app_language),
            subtitle: Text(getLanguageNameFormLocale(context.currentLocale)),
            onTap: () => showDialog(
              context: context,
              builder: (context) => RadioListPopup<Locale>(
                title: context.l10n!.app_language,
                optionList: AppLocalizations.supportedLocales,
                value: context.currentLocale,
                getOptionTitle: (locale) => getLanguageNameFormLocale(locale),
                onChange: (newLocale) {
                  ref.read(l10nProvider.notifier).update(newLocale);
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(context.l10n!.about),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              /* Navigasi ke halaman about */
            },
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
              onPressed: logoutState.isLoading
                  ? null
                  : showLogoutConfirmationDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: logoutState.isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 8),
                        Text(context.l10n!.logout),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
