import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CNavigationHomePage extends StatefulWidget {
  List<CNavigationItem> navigationItems;
  List<Widget> pages;
  AppBar appBar;
  int selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);



  CNavigationHomePage(
      {super.key,
      required this.appBar,
      required this.navigationItems,
      required this.pages});

  @override
  State<StatefulWidget> createState() => _CNavigationHomePageState();
}

class _CNavigationHomePageState extends State<CNavigationHomePage> {

  onSelected(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
    widget.pageController.jumpToPage(index);
  }


  @override
  Widget build(BuildContext context) {
    return buildNavigationHomePage(context);
  }

  Widget buildNavigationHomePage(BuildContext context) {
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
      throw Exception("unsupported");
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
    final List<BottomNavigationBarItem> items = widget.navigationItems.map((e) {
      return BottomNavigationBarItem(
          label: e.label, icon: e.icon, activeIcon: e.activeIcon);
    }).toList();
    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.selectedIndex,
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
