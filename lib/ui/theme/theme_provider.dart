import 'package:aria2_client/store/IHive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ThemeProvider extends StatefulWidget {
  final Widget Function(BuildContext context, ThemeMode mode) builder;

  const ThemeProvider({super.key, required this.builder});

  @override
  State<StatefulWidget> createState() {
    return _ThemeProviderState();
  }
}

class _ThemeProviderState extends State<ThemeProvider> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
            IHive.settings.listenable(keys: [SettingsHiveKey.themeMode]),
        builder: (context, settings, child) {
          final name = settings.get(SettingsHiveKey.themeMode);
          final mode = ThemeMode.values.firstWhere((e) => e.name == name,
              orElse: () => ThemeMode.dark);
          return widget.builder(context, mode);
        });
  }
}
