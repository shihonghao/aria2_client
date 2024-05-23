import 'package:flutter/material.dart';

const List<NavigationRailDestination> destinations = [
  NavigationRailDestination(
      icon: Icon(Icons.menu), label: Text(""), indicatorColor: Colors.black),
  NavigationRailDestination(
      icon: Icon(Icons.download),
      label: Text("下载"),
      indicatorColor: Colors.black,
      indicatorShape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.yellow, width: 2.0),
      )),
  NavigationRailDestination(
      icon: Icon(Icons.history),
      label: Text("历史记录"),
      indicatorColor: Colors.black),
  NavigationRailDestination(
      icon: Icon(Icons.settings),
      label: Text("设置"),
      indicatorColor: Colors.black),
];

class LeftNavigation extends StatefulWidget {
  final ValueChanged<int>? onSelected;

  const LeftNavigation({super.key, this.onSelected});

  //
  // Widget buildLeftNavigation(
  //     BuildContext context, int index, Function(int) onSelected) {
  //   return
  // }

  @override
  State<StatefulWidget> createState() => _LeftNavigationState();
}

class _LeftNavigationState extends State<LeftNavigation> {
  bool extended = false;
  int selectedIndex = 1;

  switchLabelType() {
    extended = extended ? false : true;
    setState(() {});
  }

  _onSelected(int index) {
    if (index == 0) {
      switchLabelType();
      return;
    }
    selectedIndex = index;
    widget.onSelected?.call(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        // onEnter: (event)=> switchLabelType(),
        // onExit:  (event)=> switchLabelType(),
        child: GestureDetector(
            child: NavigationRail(
      onDestinationSelected: _onSelected,
      destinations: destinations,
      selectedIndex: selectedIndex,
      labelType: NavigationRailLabelType.none,
      groupAlignment: -1.0,
      selectedLabelTextStyle: const TextStyle(color: Colors.blue),
      selectedIconTheme: const IconThemeData(color: Colors.blue, fill: 1),
      unselectedLabelTextStyle: const TextStyle(color: Colors.white),
      unselectedIconTheme: const IconThemeData(color: Colors.white),
      useIndicator: false,
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: Colors.yellow, width: 2.0),
      ),
      backgroundColor: Colors.black,
      extended: extended,
    )));
  }
}
