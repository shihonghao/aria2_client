import 'package:aria2_client/ui/pages/my_action_bar.dart';
import 'package:aria2_client/ui/pages/servers/server_add_page_v2.dart';
import 'package:aria2_client/ui/pages/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'download/download_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  late ActionBarController _actionBarController;

  @override
  void initState() {
    _actionBarController = ActionBarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawerEnableOpenDragGesture: false,
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(
          width: 300.w,
          child: const SettingsPage(),
        ),
        endDrawer: Drawer(
          width: 300.w,
          elevation: 10,
          child: const ServerAddPage(),
        ),
        bottomNavigationBar: MyActionBar(
          content: const MyActionBarContent(),
          expand: const MyActionBarExpand(),
          actionBarController: _actionBarController,
        ),
        body: Stack(children: [
          const DownloadPage(),
          ListenableBuilder(
            listenable: _actionBarController,
            builder: (BuildContext context, Widget? child) {
              return Offstage(
                offstage: !_actionBarController.isExpend,
                child: SizedBox.expand(
                  child: GestureDetector(
                    onTap: () {
                      _actionBarController.collapse();
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                ),
              );
            },
          ),
        ]));
  }
}
