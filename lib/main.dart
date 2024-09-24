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
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return ThemeProvider(builder: (BuildContext context, ThemeMode mode) {
      return ScreenUtilInit(
        designSize: const Size(430, 932),
        builder: (context, child) {
          return MaterialApp(
            key: UniqueKey(),
            title: 'Aria2',
            themeMode: mode,
            theme: ThemeData(
                appBarTheme:
                    const AppBarTheme(backgroundColor: Color(0xFFDFE2DA)),
                brightness: Brightness.light,
                primaryColor: const Color(0xFFDFE2DA),
                scaffoldBackgroundColor: const Color(0xFFCBCDCB),
                cardColor: const Color(0xFFFFDAD4),
                indicatorColor: const Color(0xFF9714A1),
         ),
            navigatorObservers: [Lifecycle.lifecycleRouteObserver],
            darkTheme: ThemeData(
              appBarTheme:
                  const AppBarTheme(backgroundColor: Color(0xFF2E3133)),
              brightness: Brightness.dark,
              scaffoldBackgroundColor: const Color(0xFF1F333C),
              primaryColor: const Color(0xFF2E3133),
              cardColor: const Color(0xFF1A1E21),
              indicatorColor: Colors.cyan,
              // highlightColor: const Color(0xFF377E07),
            ),
            routes: routes,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: PlatformedHomePage(
              key: UniqueKey(),
              initialPageIndex: 0,
            ),
          );
        },
      );
    });
  }
}
