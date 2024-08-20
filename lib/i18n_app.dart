import 'package:aria2_client/store/IHive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class I18nApp extends StatefulWidget {
  final Widget Function(BuildContext context, Locale local,Widget? child) builder;
  final Widget? child;

  const I18nApp({super.key, required this.builder,this.child});

  @override
  State<StatefulWidget> createState() {
    return _I18nAppState();
  }
}

class _I18nAppState extends State<I18nApp> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            IHive.settings.listenable(keys: [SettingsHiveKey.language]),
        builder: (context, settings, child) {
          final language = settings.get(SettingsHiveKey.language);
          final locale = language.contains("_")
              ? Locale(language.split("_")[0], language.split("_")[1])
              : Locale(language);
          return widget.builder(context, locale,widget.child);
        });
  }
}
