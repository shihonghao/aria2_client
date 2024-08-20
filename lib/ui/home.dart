import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/ui/pages/settings/settings_item.dart';
import 'package:aria2_client/ui/pages/settings/settings_page.dart';
import 'package:aria2_client/ui/platformed_home.dart';
import 'package:aria2_client/ui/pages/download/download_page.dart';
import 'package:aria2_client/ui/pages/servers/server_page.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import 'aria2_dropdown_menu.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformedHomePage(
      appBar: AppBar(
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
      navigationItems: [
        CNavigationItem(
          icon: const Icon(TDIcons.server),
          label: S.of(context).appNavigation1,
        ),
        CNavigationItem(
          icon: const Icon(Icons.download),
          label: S.of(context).appNavigation2,
        ),
        CNavigationItem(
          icon: const Icon(Icons.settings),
          label: S.of(context).appNavigation3,
        ),
      ],
      pages: const [
        ServerPage(),
        DownloadPage(),
        SettingsPage(),
      ],
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
