import 'package:aria2_client/ui/c_navigation_home.dart';
import 'package:aria2_client/ui/pages/download_page.dart';
import 'package:aria2_client/ui/pages/servers_page.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'aria2_dropdown_menu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  List<CNavigationItem> navigationItems = [
    CNavigationItem(
      icon: const Icon(TDIcons.server),
      label: "服务器",
    ),
    CNavigationItem(
      icon: const Icon(Icons.download),
      label: "下载",
    ),
    CNavigationItem(
      icon: const Icon(Icons.settings),
      label: "设置",
    ),
  ];

  List<Widget> pages = [
    const ServersPage(),
    const DownloadPage(),
    const DownloadPage(),
  ];

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController pageController = PageController();
  final Aria2MenuNotifier menuNotifier = Aria2MenuNotifier(0);

  void onNavigationSelected(int value) {
    pageController.jumpTo((value).toDouble());
  }

  @override
  Widget build(BuildContext context) {
    return CNavigationHomePage(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Center(child: Aria2DropdownMenu()),
        leading: Center(
            child: Text(
          widget.title,
          style: const TextStyle(fontSize: 20),
        )),
        actions: [
          IconButton(
              onPressed: () => addAria2(context), icon: const Icon(Icons.add)),
        ],
      ),
      navigationItems: widget.navigationItems,
      pages: widget.pages,
    );
  }

  addAria2(context) {
    Navigator.of(context).pushNamed("/add");
  }
}

class Aria2MenuNotifier extends ValueNotifier<int> {
  Aria2MenuNotifier(super.value);

  setState(int val) {
    value = val;
    notifyListeners();
  }
}
