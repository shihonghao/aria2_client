import 'package:aria2_client/providers/aria2_model.dart';
import 'package:aria2_client/ui/home.dart';
import 'package:aria2_client/ui/routes/route.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Aria2Model aria2model = await initAria2();
  runApp(MyApp(aria2model: aria2model));
}

Future<Aria2Model> initAria2() async {
  Aria2Model aria2model = Aria2Model();
  await SharedPreferences.getInstance();
  await aria2model.init();
  return aria2model;
}

class MyApp extends StatelessWidget {
  Aria2Model aria2model;

  MyApp({super.key, required this.aria2model});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<Aria2Model>(
        create: (context) => aria2model,
        lazy: false,
      )
    ], child: buildMaterialApp(context));
  }

  Widget buildMaterialApp(BuildContext context) {
    //todo 主题切换
    return MaterialApp(
      title: 'Aria2',
      themeMode: ThemeMode.light,
      routes: routes,
      home: MyHomePage(title: 'Aria2'),
    );
  }
}
