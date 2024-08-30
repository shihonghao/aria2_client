import 'dart:io';

import 'package:aria2_client/ui/pages/download/download_page.dart';
import 'package:aria2_client/ui/pages/servers/server_page.dart';
import 'package:aria2_client/ui/pages/settings/settings_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class PlatformedHomePage extends StatefulWidget {
  final int initialPageIndex;

  const PlatformedHomePage({super.key, this.initialPageIndex = 0});

  @override
  State<StatefulWidget> createState() => _PlatformedHomePageState();
}

class _PlatformedHomePageState extends State<PlatformedHomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  late int _selectedIndex;

  @override
  initState() {
    super.initState();
    _selectedIndex = widget.initialPageIndex;
  }

  onSelected(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return buildHomePage(context);
  }

  Widget buildHomePage(BuildContext context) {
    if (kIsWeb) {
      throw Exception("unsupported");
    } else if (Platform.isWindows) {
      throw Exception("unsupported");
    } else if (Platform.isMacOS) {
      throw Exception("unsupported");
    } else if (Platform.isLinux) {
      throw Exception("unsupported");
    } else if (Platform.isAndroid) {
      return createBottomNavigationHomePage(context);
    } else if (Platform.isIOS) {
      return createBottomNavigationHomePage(context);
    } else if (Platform.isFuchsia) {
      throw Exception("unsupported");
    } else {
      throw Exception("unsupported");
    }
  }

  Widget createBottomNavigationHomePage(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        color: Theme.of(context).scaffoldBackgroundColor,
        index: _selectedIndex,
        items: const [
          Icon(TDIcons.server),
          Icon(Icons.download),
          Icon(Icons.settings),
        ],
        onTap: onSelected,
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          ServerPage(),
          DownloadPage(),
          SettingsPage(),
        ],
      ),
    );
  }
}
