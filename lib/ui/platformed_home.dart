import 'dart:io';

import 'package:aria2_client/providers/aria2_model.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlatformedHomePage extends StatefulWidget {
  final List<CNavigationItem> navigationItems;
  final List<Widget> pages;
  final AppBar? appBar;
  int selectedIndex;
  final PageController pageController = PageController(initialPage: 0);

  PlatformedHomePage(
      {super.key,
      this.appBar,
      required this.navigationItems,
      required this.pages,
      this.selectedIndex = 0});

  @override
  State<StatefulWidget> createState() => _PlatformedHomePageState();
}

class _PlatformedHomePageState extends State<PlatformedHomePage> {
  onSelected(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
    widget.pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return buildHomePage(context);
  }

  Widget buildHomePage(BuildContext context) {
    if (kIsWeb) {
      return createLeftNavigationHomePage(context);
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

  Widget createLeftNavigationHomePage(BuildContext context) {
    final List<NavigationRailDestination> destinations =
        widget.navigationItems.map((e) {
      return NavigationRailDestination(icon: e.icon, label: Text(e.label));
    }).toList();

    return Scaffold(
        appBar: widget.appBar,
        body: Row(
          children: [
            GestureDetector(
                child: NavigationRail(
              onDestinationSelected: onSelected,
              destinations: destinations,
              selectedIndex: widget.selectedIndex,
              labelType: NavigationRailLabelType.none,
              groupAlignment: -1.0,
              selectedLabelTextStyle: const TextStyle(color: Colors.blue),
              selectedIconTheme:
                  const IconThemeData(color: Colors.blue, fill: 1),
              unselectedLabelTextStyle: const TextStyle(color: Colors.white),
              unselectedIconTheme: const IconThemeData(color: Colors.white),
              useIndicator: false,
              indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.yellow, width: 2.0),
              ),
              backgroundColor: Colors.black,
              extended: false,
            )),
            Expanded(
                child: PageView(
              controller: widget.pageController,
              children: widget.pages,
            ))
          ],
        ));
  }

  Widget createBottomNavigationHomePage(BuildContext context) {
    final List<Widget> items = widget.navigationItems.map((e) {
      return e.icon;
    }).toList();
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        color: Theme.of(context).scaffoldBackgroundColor,
        index: widget.selectedIndex,
        items: items,
        onTap: onSelected,
      ),
      body: PageView(
        controller: widget.pageController,
        children: widget.pages,
      ),
    );
  }
}

class CNavigationItem {
  final String label;
  final Icon icon;
  Icon? activeIcon;
  Color? activeColor;

  CNavigationItem({
    required this.label,
    required this.icon,
  });
}
