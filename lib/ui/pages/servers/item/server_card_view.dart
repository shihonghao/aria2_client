import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:aria2_client/aria2/model/aria2_global_status.dart';
import 'package:aria2_client/aria2/model/aria2_server_config.dart';
import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/providers/aria2_model.dart';
import 'package:aria2_client/providers/server_model.dart';
import 'package:aria2_client/ui/component/animation/my_animated_icon.dart';
import 'package:aria2_client/ui/component/animation/my_colorize_text.dart';
import 'package:aria2_client/ui/pages/servers/detail/detail_page.dart';
import 'package:aria2_client/ui/pages/servers/item/server_item.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServerCardView extends StatefulWidget {
  const ServerCardView({super.key});

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
  late TextEditingController _uploadLimitSpeedTextController;
  late TextEditingController _downloadLimitSpeedTextController;

  @override
  void initState() {
    super.initState();
    _uploadLimitSpeedTextController = TextEditingController();
    _downloadLimitSpeedTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Theme.of(context).colorScheme.secondary);
    return Card(
      color: Theme.of(context).highlightColor,
      elevation: 5,
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
                              )

                              // Text(
                              //   config.uri.toString(),
                              //   style:
                              //       TextStyle(color: Theme.of(context).splashColor),
                              // ),
                              )
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
                                            "下载中 :  ${globalStatus.numActive}",
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Center(
                                            child: Text(
                                              style: textStyle,
                                              "等待中 :  ${globalStatus.numWaiting}",
                                            ),
                                          )),
                                    ),
                                    Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              style: textStyle,
                                              "已停止 :  ${globalStatus.numStopped}",
                                            ),
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
                                                color: Theme.of(context)
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
                                              color: Theme.of(context)
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
            Selector<ServerModel, Aria2ServerConfig>(
                builder: (_, config, child) {
                  _uploadLimitSpeedTextController.text =
                      config.maxUploadLimit.toString();
                  _downloadLimitSpeedTextController.text =
                      config.maxDownloadLimit.toString();
                  return Container(
                    constraints: const BoxConstraints(minHeight: 50),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 40, 0),
                                child: Column(
                                  children: [
                                    Text(
                                      "全局限速",
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).indicatorColor),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text("下载 ："),
                                        SizedBox(
                                            width: 80,
                                            height: 45,
                                            child: TextField(
                                              controller:
                                                  _downloadLimitSpeedTextController,
                                              decoration: InputDecoration(
                                                  suffix: const Text("mb/s"),
                                                  fillColor: Theme.of(context)
                                                      .cardColor,
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 15, 0),
                                                  enabledBorder:
                                                      const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  border: InputBorder.none),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text("上传 ： "),
                                        SizedBox(
                                            width: 80,
                                            height: 45,
                                            child: TextField(
                                              controller:
                                                  _uploadLimitSpeedTextController,
                                              decoration: InputDecoration(
                                                  suffix: const Text("mb/s"),
                                                  fillColor: Theme.of(context)
                                                      .cardColor,
                                                  focusedBorder:
                                                      const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  enabledBorder:
                                                      const UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide.none),
                                                  contentPadding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 0, 15, 0),
                                                  border: InputBorder.none),
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                selector: (_, model) => model.aria2.serverConfig),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(90)),
              child: IconButton(
                color: Theme.of(context).splashColor,
                iconSize: 30,
                icon: const Icon(Icons.close),
                onPressed: () {
                  context
                      .read<Aria2Model>()
                      .removeAria2(context.read<ServerModel>().aria2.config);
                },
              ),
            )
          ],
        ),
        ServerItem.buildCheckBox(),
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
                      if (context.read<ServerModel>().isCurrent) {
                        action();
                      } else {
                        Util.showTextAlert(context, "请先切换到当前服务器");
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
    for (var feature in ServerCardView.enabledFeatures) {
      Color color = features.contains(feature)
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
