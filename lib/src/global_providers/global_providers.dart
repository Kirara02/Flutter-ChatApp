import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_cache_hive_store/http_cache_hive_store.dart';
import 'package:xchat/src/core/network/dio_client.dart';
import 'package:xchat/src/core/network/network_module.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:xchat/src/constants/db_keys.dart';
import 'package:xchat/src/constants/enum.dart';
import 'package:xchat/src/utils/extensions/custom_extensions.dart';
import 'package:xchat/src/core/mixin/shared_preferences_client_mixin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xchat/src/utils/websocket_service.dart';

part 'global_providers.g.dart';

@riverpod
DioClient dioClientKey(Ref ref) => DioClient(
  dio: ref
      .watch(networkModuleProvider)
      .provideDio(
        baseUrl: DBKeys.serverUrl.initial,
        port: DBKeys.serverPort.initial,
        authType: ref.watch(authTypeKeyProvider) ?? DBKeys.authType.initial,
        hiveCacheStore: ref.watch(hiveCacheStoreProvider),
        ref: ref,
      ),
);

@riverpod
class AuthTypeKey extends _$AuthTypeKey
    with SharedPreferenceEnumClientMixin<AuthType> {
  @override
  AuthType? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final initial = initialize(
      prefs,
      DBKeys.authType,
      enumList: AuthType.values,
    );

    listenSelf((prev, next) {
      persist(next);
    });

    return initial;
  }
}

@riverpod
class Credentials extends _$Credentials
    with SharedPreferenceClientMixin<String> {
  @override
  String? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final initial = initialize(prefs, DBKeys.credentials);

    listenSelf((prev, next) {
      persist(next);
    });

    return initial;
  }

  Future<void> updateBasicAuth({
    required String username,
    required String password,
  }) async {
    final basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';
    update(basicAuth);
    await persist(basicAuth);
  }

  Future<void> updateBearerToken(String token) async {
    update(token);
    await persist(token);
  }
}

@riverpod
class RefreshCredentials extends _$RefreshCredentials
    with SharedPreferenceClientMixin<String> {
  @override
  String? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final initial = initialize(prefs, DBKeys.refreshCredentials);

    listenSelf((prev, next) {
      persist(next);
    });

    return initial;
  }
}

@riverpod
class OnBoardingPrefs extends _$OnBoardingPrefs
    with SharedPreferenceClientMixin<bool> {
  @override
  bool? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final initial = initialize(prefs, DBKeys.showOnBoarding);

    listenSelf((prev, next) {
      persist(next);
    });

    return initial;
  }
}

@riverpod
class L10n extends _$L10n with SharedPreferenceClientMixin<Locale> {
  Map<String, String> toJson(Locale locale) => {
    if (locale.countryCode.isNotBlank) "countryCode": locale.countryCode!,
    if (locale.languageCode.isNotBlank) "languageCode": locale.languageCode,
    if (locale.scriptCode.isNotBlank) "scriptCode": locale.scriptCode!,
  };
  Locale? fromJson(dynamic json) =>
      json is! Map<String, dynamic> || (json["languageCode"] == null)
      ? null
      : Locale.fromSubtags(
          languageCode: json["languageCode"]!.toString(),
          scriptCode: json["scriptCode"]?.toString(),
          countryCode: json["countryCode"]?.toString(),
        );

  @override
  Locale? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final initial = initialize(
      prefs,
      DBKeys.l10n,
      fromJson: fromJson,
      toJson: toJson,
    );

    listenSelf((prev, next) {
      persist(next);
    });

    return initial;
  }
}

@riverpod
SharedPreferences sharedPreferences(Ref ref) => throw UnimplementedError();

@riverpod
Directory? appDirectory(Ref ref) => throw UnimplementedError();

@riverpod
HiveCacheStore hiveCacheStore(Ref ref) =>
    HiveCacheStore(ref.watch(appDirectoryProvider)?.path);

@riverpod
WebSocketService webSocketService(Ref ref) => WebSocketService();
