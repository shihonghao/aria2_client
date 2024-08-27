import 'dart:io';

import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class IHiveKey {
  const IHiveKey._();

  static const String settings = "SETTINGS";
  static const String aria2 = "ARIA2";
}

class SettingsHiveKey {
  const SettingsHiveKey._();

  static const String themeMode = "THEME_MODE";
  static const String language = "LANGUAGE";
  static const String globalRefreshInterval = "GLOBAL_REFRESH_INTERVAL";
  static const String taskRefreshInterval = "TASK_REFRESH_INTERVAL";
  static const String optionUpdateConfirm = "OPTION_UPDATE_CONFIRM";
}

class IHive {
  const IHive._();

  static late Box settings;

  static late Box<Aria2Config> aria2s;

  static late final Directory filesDir;

  static Future<void> init() async {
    await Future.wait([
      getApplicationSupportDirectory().then((value) => filesDir = value),
    ]);
    Hive.init("${filesDir.path}${Platform.pathSeparator}aria2");
    Hive.registerAdapter(Aria2ConfigAdapter());
    settings = await Hive.openBox(IHiveKey.settings);
    aria2s = await Hive.openBox<Aria2Config>(IHiveKey.aria2);

    if (settings.isEmpty) {
      await settings.put(SettingsHiveKey.language, "zh");
      await settings.put(SettingsHiveKey.themeMode, "dark");
      await settings.put(SettingsHiveKey.globalRefreshInterval, 1);
      await settings.put(SettingsHiveKey.taskRefreshInterval, 1);
      await settings.put(SettingsHiveKey.optionUpdateConfirm, '1');
    }
  }
}
