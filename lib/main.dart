import 'package:aria2_client/model/aria2_context.dart';
import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  initAria2();
  runApp(const MyApp());
}

void initAria2() {
  Aria2Context.getInstance().loadLocalConfig();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aria2',
      theme: FlexThemeData.light(
        scheme: FlexScheme.aquaBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7
      ),
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.aquaBlue,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7
      ),
      themeMode: ThemeMode.light,
      home: const MyHomePage(title: 'Aria2'),
    );
  }
}

