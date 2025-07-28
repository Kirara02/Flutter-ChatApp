import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xchat/src/core/logger/provider_state_logger.dart';
import 'package:xchat/src/global_providers/global_providers.dart';
import 'package:xchat/src/xchat_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final sharedPreferences = await SharedPreferences.getInstance();

  final Directory? appDirectory;
  if (!kIsWeb) {
    final appDocDirectory = await getApplicationDocumentsDirectory();
    appDirectory = Directory(path.join(appDocDirectory.path, 'Uniguard'));

    await appDirectory.create(recursive: true);

    final cacheFiles = ['dio_cache.hive', 'dio_cache.lock'];
    for (final cacheFile in cacheFiles) {
      final oldCacheFilePath = path.join(appDocDirectory.path, cacheFile);
      final newCacheFilePath = path.join(appDirectory.path, cacheFile);

      if (!(await File(newCacheFilePath).exists()) &&
          await File(oldCacheFilePath).exists()) {
        await File(oldCacheFilePath).rename(newCacheFilePath);
      }
    }
  } else {
    appDirectory = null;
  }

  GoRouter.optionURLReflectsImperativeAPIs = true;

  runApp(
    ProviderScope(
      observers: [if (kDebugMode) ProviderStateLogger()],
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        appDirectoryProvider.overrideWithValue(appDirectory),
      ],
      child: const XchatApp(),
    ),
  );
}
