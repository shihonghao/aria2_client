import 'package:aria2_client/aria2/model/aria2_global_status.dart';
import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/providers/server_model.dart';
import 'package:aria2_client/ui/pages/servers/item/server_item.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class ServerListView extends StatefulWidget {
  final ValueNotifier<bool> isSelected;

  const ServerListView({super.key, required this.isSelected});

  @override
  State<StatefulWidget> createState() {
    return _ServerListViewState();
  }
}

class _ServerListViewState extends State<ServerListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 10,
      surfaceTintColor: Theme.of(context).secondaryHeaderColor,
      margin: EdgeInsets.zero,
      child: Stack(
        children: [
          Row(children: [
            Container(
              decoration: BoxDecoration(
                  color: themeData.secondaryHeaderColor,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(1, 1),
                        color: themeData.shadowColor)
                  ]),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Icon(
                      TDIcons.server,
                      size: 60,
                    ),
                  ),
                ],
              ),
            ),
            buildOverview()
          ]),
          ServerItem.buildCheckBox(widget.isSelected)
        ],
      ),
    );
  }

  Widget buildOverview() {
    final textStyle = TextStyle(color: Theme.of(context).colorScheme.secondary);
    return Expanded(
        child: Column(children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 8, 0),
            child: Text(context.read<ServerModel>().aria2.config.name,
                style: const TextStyle(fontSize: 30)),
          ),
        ],
      ),
      Selector<ServerModel, Aria2GlobalStatus>(
          selector: (context, model) => model.globalStatus,
          builder: (context, globalStatus, child) {
            String downloadSpeed = globalStatus.calcSpeed(true);
            String uploadSpeed = globalStatus.calcSpeed();
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                      child: Column(children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          style: textStyle,
                          S
                              .of(context)
                              .downloading_count(globalStatus.numActive),
                        )),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_downward,
                                  color: Theme.of(context).indicatorColor),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                                child: Text(
                                  style: textStyle,
                                  downloadSpeed,
                                ),
                              ),
                            ],
                          )),
                    )
                  ])),
                  Expanded(
                      child: Column(children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          style: textStyle,
                          S.of(context).waiting_count(globalStatus.numWaiting),
                        )),
                    Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_upward,
                                color: Theme.of(context).indicatorColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                                child: Text(
                                  style: textStyle,
                                  uploadSpeed,
                                ),
                              ),
                            ],
                          )),
                    )
                  ])),
                  Expanded(
                      child: Column(children: [
                    Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          style: textStyle,
                          S.of(context).stopped_count(globalStatus.numStopped),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: child!,
                    )
                  ])),
                ],
              ),
            );
          },
          child: Selector<ServerModel, bool>(
            selector: (context, model) => model.isTesting,
            builder: (context, isTesting, child) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeInBack,
                switchOutCurve: Curves.linear,
                child: !isTesting
                    ? Text(
                        context.read<ServerModel>().isAvailable
                            ? S.of(context).online
                            : S.of(context).offline,
                        style: const TextStyle(fontSize: 20))
                    : LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.red, size: 35),
              );
            },
          ))
    ]));
  }
}
