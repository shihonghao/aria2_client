import 'package:animations/animations.dart';
import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/event/base_event.dart';
import 'package:aria2_client/event/event_bus_manager.dart';
import 'package:aria2_client/ui/pages/servers/server_add_page.dart';
import 'package:aria2_client/ui/pages/servers/server_content_v2.dart';
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
                  // AnimatedContainer(
                  //   height: cardHeight,
                  //   width: 401.w,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       boxShadow: const [
                  //         BoxShadow(
                  //           offset: Offset(0, 0),
                  //           blurRadius: 4,
                  //           color: Color.fromRGBO(0, 0, 0, 0.25),
                  //           blurStyle: BlurStyle.outer,
                  //         )
                  //       ],
                  //       gradient: const LinearGradient(
                  //           colors: [
                  //             Color.fromRGBO(34, 102, 125, 1.00),
                  //             Color.fromRGBO(177, 179, 95, 0)
                  //           ],
                  //           begin: Alignment.centerLeft,
                  //           end: Alignment.centerRight)),
                  //   duration: Const.duration500ms,
                  // ),
                  SizedBox(
                    height: 40.h,
                  ),
                  // const Expanded(child: ServerContent())
                ],
              ),
            ),
            // Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: buildActions()),
            // Expanded(
            //     child: ValueListenableBuilder<ViewType>(
            //   valueListenable: Application.instance.serverViewType,
            //   builder: (BuildContext context, ViewType type, Widget? child) {
            //     return AnimatedSwitcher(
            //         duration: const Duration(milliseconds: 500),
            //         child: ServerContent(key: UniqueKey(), type: type));
            //   },
            // )),
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
            // IconButton(
            //     onPressed: () {
            //       Application.instance.switchServerViewType();
            //     },
            //     icon: ValueListenableBuilder<ViewType>(
            //       valueListenable: Application.instance.serverViewType,
            //       builder:
            //           (BuildContext context, ViewType viewType, Widget? child) {
            //         IconData icon = viewType == ViewType.list
            //             ? Icons.format_list_numbered_sharp
            //             : Icons.credit_card;
            //         return Center(
            //             child: AnimatedSwitcher(
            //                 duration: Const.duration200ms,
            //                 child: Icon(
            //                   icon,
            //                   key: UniqueKey(),
            //                 )));
            //       },
            //     )),
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
