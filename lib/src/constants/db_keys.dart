import 'package:flutter/material.dart';

import 'enum.dart';

enum DBKeys {
  // serverUrl("http://10.166.236.124"),
  serverUrl("http://192.168.1.156"),
  serverPort(8080),
  themeMode(ThemeMode.system),
  authType(AuthType.bearer),
  credentials(null),
  refreshCredentials(null),
  l10n(Locale('en')),
  showOnBoarding(true);

  const DBKeys(this.initial);

  final dynamic initial;
}
