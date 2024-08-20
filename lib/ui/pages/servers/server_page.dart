import 'dart:async';

import 'package:animations/animations.dart';
import 'package:aria2_client/event/base_event.dart';
import 'package:aria2_client/event/event_bus_manager.dart';
import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/providers/aria2_model.dart';
import 'package:aria2_client/ui/pages/servers/server_add_page.dart';
import 'package:aria2_client/ui/pages/servers/server_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../aria2/model/aria2.dart';
import '../../../const/Const.dart';
import '../../../providers/server_model.dart';
import 'event/server_event.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ServerPageState();
  }
}

class _ServerPageState extends State<ServerPage> {
  late List<Aria2> aria2s;
  late ValueNotifier<bool> _isCardView;
  late StreamSubscription<ServerEvent> subscription;

  @override
  void initState() {
    super.initState();
    _isCardView = ValueNotifier(false);
    subscription = EventBusManager.eventBus.on<ServerEvent>().listen((event) {
      if (event.eventType == ServerEventType.CHANGE_CURRENT) {
        if (mounted) {
          final model = event.value as ServerModel;
          context.read<Aria2Model>().setCurrentServer(model);
        }
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: buildActions()),
             Row(
              children: [
                SizedBox(
                  height: 110,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      S.of(context).serverPageTitle,
                      style:
                      const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: ValueListenableBuilder<bool>(
              valueListenable: _isCardView,
              builder: (BuildContext context, bool value, Widget? child) {
                return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: ServerContent(
                        key: UniqueKey(),
                        type:
                            _isCardView.value ? ViewType.card : ViewType.list));
              },
            )),
          ],
        ),
      ),
    );
  }

  List<Widget> buildActions() {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Theme.of(context).highlightColor,
          child: Row(children: [
            IconButton(
              onPressed: () {
                EventBusManager.eventBus.fire(ServerEvent(
                  scope: EventScope.All,
                  eventType: ServerEventType.CHECK_AVAILABLE,
                ));
              },
              icon: const Icon(
                Icons.refresh,
                size: 30,
              ),
            ),
            IconButton(
                onPressed: () {
                  _isCardView.value = !_isCardView.value;
                },
                icon: ValueListenableBuilder<bool>(
                  valueListenable: _isCardView,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Center(
                        child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              value
                                  ? Icons.format_list_numbered_sharp
                                  : Icons.credit_card,
                              key: UniqueKey(),
                            )));
                  },
                )),
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
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ));
              },
              openBuilder: (context, action) {
                return ServerAddPage();
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
