import 'package:aria2_client/aria2/aria2_constants.dart';
import 'package:aria2_client/framework/lifecycle.dart';
import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/net/aria2_request.dart';
import 'package:aria2_client/net/aria2_websocket_request.dart';
import 'package:aria2_client/providers/application.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/ui/platformed_home.dart';
import 'package:aria2_client/ui/routes/route.dart';
import 'package:aria2_client/ui/theme/theme_provider.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'net/aria2_http_request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IHive.init();
  Application aria2model = await initAria2();
  runApp(MyApp(aria2model: aria2model));
}

Future<Application> initAria2() async {
  Aria2Request.register(Aria2Constants.PROTOCOL_HTTP, Aria2HttpRequest());
  Aria2Request.register(
      Aria2Constants.PROTOCOL_WEBSOCKET, Aria2WebSocketRequest());
  Aria2Request.register(Aria2Constants.PROTOCOL_HTTPS, Aria2HttpRequest());
  Aria2Request.register(
      Aria2Constants.PROTOCOL_WEBSOCKET_SECURE, Aria2WebSocketRequest());
  Application aria2model = Application.instance;
  await SharedPreferences.getInstance();
  await aria2model.init();
  return aria2model;
}

class MyApp extends StatelessWidget {
  Application aria2model;

  MyApp({super.key, required this.aria2model});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<Application>(
        create: (context) => aria2model,
        lazy: false,
      )
    ], child: buildMaterialApp(context));
  }

  Widget buildMaterialApp(BuildContext context) {
    final darkThemeData = FlexThemeData.dark(
      scheme: FlexScheme.materialBaseline,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,

      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
    return ThemeProvider(
      builder: (BuildContext context, ThemeMode mode) {
        return ValueListenableBuilder(
          valueListenable: IHive.aria2s.listenable(),
          builder: (context, value, child) {
            return child!;
          },
          child: MaterialApp(
            title: 'Aria2',
            themeMode: mode,
            theme: FlexThemeData.light(
              scheme: FlexScheme.materialBaseline,
              surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
              blendLevel: 7,
              subThemesData: const FlexSubThemesData(
                blendOnLevel: 10,
                blendOnColors: false,
                useTextTheme: true,
                useM2StyleDividerInM3: true,
                alignedDropdown: true,
                useInputDecoratorThemeInDialogs: true,
              ),
              visualDensity: FlexColorScheme.comfortablePlatformDensity,
              useMaterial3: true,
              swapLegacyOnMaterial3: true,

              // To use the Playground font, add GoogleFonts package and uncomment
              // fontFamily: GoogleFonts.notoSans().fontFamily,
            ),
            navigatorObservers: [Lifecycle.lifecycleRouteObserver],
            darkTheme: darkThemeData,
            routes: routes,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: const PlatformedHomePage(
              initialPageIndex: 0,
            ),
          ),
        );
      },
    );
    // },
    // );
  }
}
