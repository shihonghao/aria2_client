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
  // Task task1 = Task(
  //     gid: '1',
  //     status: TaskStatus.active,
  //     totalLength: 1000,
  //     completedLength: 100,
  //     uploadLength: 1000,
  //     downloadSpeed: 30,
  //     uploadSpeed: 40);
  // Timer(const Duration(milliseconds: 2000), () {
  //
  //   aria2model.updateTask([task1],TaskStatus.active);
  //   developer.log("add Task 1");
  // });
  // Timer(const Duration(milliseconds: 5000), () {
  //   Task task2 = Task(
  //       gid: '2',
  //       status: TaskStatus.active,
  //       totalLength: 2000,
  //       completedLength: 1000,
  //       uploadLength: 2000,
  //       downloadSpeed: 50,
  //       uploadSpeed: 100);
  //   aria2model.updateTask([task2,task1],TaskStatus.active);
  //   developer.log("add Task 2");
  //   Task task3 = Task(
  //       gid: '3',
  //       status: TaskStatus.active,
  //       totalLength: 2000,
  //       completedLength: 1000,
  //       uploadLength: 2000,
  //       downloadSpeed: 50,
  //       uploadSpeed: 100);
  //   Timer(const Duration(milliseconds: 1000), () {
  //     developer.log("开始下");
  //     Timer.periodic(const Duration(milliseconds: 1000), (timer) {
  //       task2.completedLength += 100;
  //       task2.downloadSpeed = Random().nextInt(1000);
  //       aria2model.updateTask([task2,task3],TaskStatus.active);
  //     });
  //   });
  // });
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
      theme: FlexThemeData.light(
          scheme: FlexScheme.aquaBlue,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 7),
      darkTheme: FlexThemeData.dark(
          scheme: FlexScheme.aquaBlue,
          surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
          blendLevel: 7),
      themeMode: ThemeMode.light,
      routes: routes,
      home: MyHomePage(title: 'Aria2'),
    );
  }
}
