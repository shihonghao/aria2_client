import 'package:animations/animations.dart';
import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/event/base_event.dart';
import 'package:aria2_client/event/event_bus_manager.dart';
import 'package:aria2_client/ui/pages/servers/server_add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ServerPageState();
  }
}

class _ServerPageState extends State<ServerPage> {
  late double cardHeight;

  @override
  void initState() {
    cardHeight = 500.h;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50.h),
        decoration: const BoxDecoration(
            gradient: RadialGradient(radius: 1, colors: [
          Color.fromRGBO(189, 222, 129, 1.00),
          Color.fromRGBO(167, 204, 98, 0)
        ])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  // const Expanded(child: ServerContent())
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildActions() {
    return [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Card(
          shape: Const.roundedRectangleBorder30,
          color: Theme.of(context).highlightColor,
          child: Row(children: [
            IconButton(
              onPressed: () {
                EventBusManager.eventBus.fire(CheckAvailableEvent());
              },
              icon: Icon(
                Icons.refresh,
                size: 20.h,
              ),
            ),
            OpenContainer(
              tappable: false,
              closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              transitionType: ContainerTransitionType.fadeThrough,
              transitionDuration: Const.duration500ms,
              closedBuilder: (context, action) {
                return IconButton(
                    // shape: const CircleBorder(),
                    onPressed: () {
                      action();
                    },
                    icon: Icon(
                      Icons.add,
                      size: 20.h,
                    ));
              },
              openBuilder: (context, action) {
                return const ServerAddPage();
              },
              closedElevation: 0,
              openElevation: 10,
              // closedColor:Theme.of(context).splashColor,
              closedColor: Colors.transparent,
              openColor: Theme.of(context).cardColor,
              middleColor: Theme.of(context).splashColor,
            ),
          ]),
        ),
      )
    ];
  }
}
