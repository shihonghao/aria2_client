import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:aria2_client/aria2/model/aria2_global_status.dart';
import 'package:aria2_client/aria2/model/aria2_server_config.dart';
import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/application.dart';
import 'package:aria2_client/providers/server_model.dart';
import 'package:aria2_client/ui/component/animation/my_animated_icon.dart';
import 'package:aria2_client/ui/component/animation/my_colorize_text.dart';
import 'package:aria2_client/ui/pages/servers/detail/detail_page.dart';
import 'package:aria2_client/ui/pages/servers/item/global_limit_setting.dart';
import 'package:aria2_client/ui/pages/servers/item/server_item.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServerCardView extends StatefulWidget {
  final ValueNotifier<bool> isSelected;

  const ServerCardView({super.key, required this.isSelected});

  static final List<String> enabledFeatures = [
    "Async DNS",
    "BitTorrent",
    "Firefox3 Cookie",
    "GZip",
    "HTTPS",
    "Message Digest",
    "Metalink",
    "XML-RPC",
    "SFTP",
  ];

  @override
  State<StatefulWidget> createState() {
    return _ServerCardViewState();
  }
}

class _ServerCardViewState extends State<ServerCardView> {


  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Theme.of(context).primaryColor,
      elevation: 10,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Stack(children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Selector<ServerModel, Aria2Config>(
                    builder: (BuildContext context, Aria2Config config,
                        Widget? child) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            config.name,
                            style: const TextStyle(fontSize: 50),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              child: AnimatedTextKit(
                                pause: const Duration(milliseconds: 1),
                                repeatForever: true,
                                animatedTexts: [
                                  MyColorizeAnimatedText(
                                      config.uri().toString(),
                                      speed: const Duration(milliseconds: 50),
                                      textStyle: const TextStyle(fontSize: 15),
                                      colors: [
                                        Colors.white38,
                                        Colors.blue,
                                        Colors.yellow,
                                        Colors.red,
                                      ])
                                ],
                              ))
                        ],
                      );
                    },
                    selector: (context, model) => model.aria2.config,
                  ),
                )
              ],
            ),
            Selector<ServerModel, Aria2GlobalStatus>(
              selector: (context, model) => model.globalStatus,
              builder: (context, globalStatus, child) {
                final textStyle = TextStyle(
                    color: !widget.isSelected.value
                        ? Theme.of(context).splashColor
                        : Theme.of(context).colorScheme.secondary);
                String downloadSpeed = globalStatus.calcSpeed(true);
                String uploadSpeed = globalStatus.calcSpeed();
                return Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.fromLTRB(25, 15, 25, 10),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                              style: textStyle,
                                              S.of(context).downloading_count(
                                                  globalStatus.numActive))),
                                    ),
                                    Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Center(
                                            child: Text(
                                                style: textStyle,
                                                S.of(context).waiting_count(
                                                    globalStatus.numWaiting)),
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                style: textStyle,
                                                S.of(context).stopped_count(
                                                    globalStatus.numStopped)),
                                          )),
                                    ),
                                  ]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.arrow_downward,
                                                color: !widget.isSelected.value
                                                    ? Theme.of(context)
                                                        .splashColor
                                                    : Theme.of(context)
                                                        .indicatorColor),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 4, 0, 0),
                                              child: Text(
                                                style: textStyle,
                                                downloadSpeed,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.arrow_upward,
                                              color: !widget.isSelected.value
                                                  ? Theme.of(context)
                                                      .splashColor
                                                  : Theme.of(context)
                                                      .indicatorColor,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 4, 0, 0),
                                              child: Text(
                                                style: textStyle,
                                                uploadSpeed,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
            Selector<ServerModel, Aria2ServerConfig>(
                builder: (_, config, child) {
                  return Container(
                    constraints: const BoxConstraints(minHeight: 200),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: buildFeaturesList(config.enabledFeatures),
                      ),
                    ),
                  );
                },
                selector: (_, model) => model.aria2.serverConfig),
            GlobalLimitSetting(isSelected: widget.isSelected),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(90)),
              child: IconButton(
                color: Theme.of(context).splashColor,
                iconSize: 30,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Application.instance
                      .removeAria2(context.read<ServerModel>().aria2.config);
                },
              ),
            )
          ],
        ),
        ServerItem.buildCheckBox(widget.isSelected),
        Positioned(
          bottom: 10,
          right: 10,
          child: OpenContainer(
            tappable: false,
            closedShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
            transitionType: ContainerTransitionType.fadeThrough,
            transitionDuration: Const.duration500ms,
            closedBuilder: (BuildContext context, void Function() action) {
              return Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(90),
                ),
                child: MyAnimatedIcon(
                  duration: Const.duration500ms,
                  onTap: (controller) {
                    controller.forward();
                    Future.delayed(Const.duration400ms, () {
                      if (widget.isSelected.value) {
                        action();
                      } else {
                        if (mounted) {
                          Util.showTextAlert(
                              context, S.of(context).check_firstly);
                        }
                      }
                    });
                  },
                  icon: Icons.settings,
                  size: 50,
                  color: Theme.of(context).indicatorColor,
                ),
              );
            },
            openBuilder: (BuildContext context,
                void Function({Object? returnValue}) action) {
              return const DetailPage();
            },
            closedElevation: 0,
            openElevation: 10,
            closedColor: Colors.transparent,
            openColor: Theme.of(context).cardColor,
            middleColor: Theme.of(context).splashColor,
          ),
        )
      ]),
    );
  }

  List<Widget> buildFeaturesList(List<dynamic> features) {
    List<Widget> featureWidgets = [];
    int count = 0;
    Widget? widget1;
    Widget? widget2;
    final isSelected = widget.isSelected.value;
    for (var feature in ServerCardView.enabledFeatures) {
      Color color = (features.contains(feature) && isSelected)
          ? Theme.of(context).indicatorColor
          : Theme.of(context).splashColor;
      Widget widget = Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: color,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                feature,
                style: TextStyle(color: color),
              )
            ],
          ));
      if (count == 0) {
        widget1 = widget;
        count++;
      } else if (count == 1) {
        widget2 = widget;
        featureWidgets.add(Row(
          children: [Expanded(child: widget1!), Expanded(child: widget2)],
        ));
        count = 0;
        widget1 = null;
        widget2 = null;
      }
    }

    if (widget1 != null && widget2 == null) {
      featureWidgets.add(Row(
        children: [Expanded(child: widget1), Expanded(child: Container())],
      ));
    }

    return featureWidgets;
  }
}
