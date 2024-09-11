import 'package:animations/animations.dart';
import 'package:aria2_client/aria2/model/aria2_global_status.dart';
import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/providers/server_model.dart';
import 'package:aria2_client/ui/component/animation/star_effect.dart';
import 'package:aria2_client/ui/pages/servers/detail/detail_page.dart';
import 'package:aria2_client/ui/pages/servers/item/server_item.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late StartEffectController _startEffectController;
  late String heroTag;
  late VoidCallback openAction;

  @override
  void initState() {
    _startEffectController = StartEffectController();
    heroTag = Util.generateId("server_item");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GestureDetector(
      onDoubleTap: () {
        _startEffectController.active();
        if (widget.isSelected.value) {
          Future.delayed(Const.duration1s, () {
            if (mounted) {
              openAction.call();
            }
          });
        } else {
          if (mounted) {
            Util.showTextAlert(context, S.of(context).check_firstly);
          }
        }
      },
      child: Card(
        color: Colors.transparent,
        shape: Const.roundedRectangleBorder20,
        elevation: 10,
        surfaceTintColor: Theme.of(context).secondaryHeaderColor,
        margin: EdgeInsets.zero,
        child: Selector<ServerModel, int>(
            selector: (context, model) => model.isTesting
                ? 1
                : model.isAvailable
                    ? 0
                    : -1,
            builder: (context, val, child) {
              if (val == 1) {
                _startEffectController.active();
                _startEffectController.rotation();
              } else {
                _startEffectController.pause();
                _startEffectController.pauseRotation();
              }
              return Stack(
                children: [
                  OpenContainer(
                      closedColor: Colors.transparent,
                      openColor: Colors.transparent,
                      closedShape: Const.roundedRectangleBorder20,
                      closedBuilder: (context, action) {
                        openAction = action;
                        return StarEffect(
                            startEffectController: _startEffectController,
                            setting: StarEffectSetting(
                              starFovAnimationDuration: 0.5,
                            ));
                      },
                      openBuilder: (context, action) {
                        return const DetailPage();
                      }),
                  Row(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: themeData.splashColor,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15.0.w),
                            child: Icon(
                              TDIcons.server,
                              size: 40.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: buildOverview(val)),
                  ]),
                  ServerItem.buildCheckBox(widget.isSelected),
                ],
              );
            }),
      ),
    );
  }

  Widget buildOverview(int val) {
    final textStyle = TextStyle(color: Theme.of(context).colorScheme.secondary);
    return Column(children: [
      Row(
        children: [
          Expanded(
            child: Container(
              height: 40.h,
              // color: Theme.of(context).cardColor,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.w, 6.h, 0, 0),
                child: Text(context.read<ServerModel>().aria2.config.name,
                    style: Const.fontLg),
              ),
            ),
          ),
        ],
      ),
      Expanded(
          child: AnimatedSwitcher(
        duration: Const.duration500ms,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: val == 0
            ? Selector<ServerModel, Aria2GlobalStatus>(
                selector: (context, model) => model.globalStatus,
                builder: (context, globalStatus, child) {
                  String downloadSpeed = globalStatus.calcSpeed(true);
                  String uploadSpeed = globalStatus.calcSpeed();
                  return Column(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 15.w),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(right: 25.w),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          style: textStyle,
                                          S.of(context).downloading,
                                        ),
                                        Text(
                                          style: textStyle,
                                          globalStatus.numActive.toString(),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(right: 25.w),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          style: textStyle,
                                          S.of(context).waiting,
                                        ),
                                        Text(
                                          style: textStyle,
                                          globalStatus.numWaiting.toString(),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              )),
                              Expanded(
                                  child: Padding(
                                padding: EdgeInsets.only(right: 25.w),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          style: textStyle,
                                          S.of(context).completed,
                                        ),
                                        Text(
                                          style: textStyle,
                                          globalStatus.numStopped.toString(),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                              )),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.w, right: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 8.w),
                                      child: Icon(Icons.arrow_downward,
                                          color:
                                              Theme.of(context).indicatorColor),
                                    ),
                                    Text(
                                      style: textStyle,
                                      downloadSpeed,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      style: textStyle,
                                      uploadSpeed,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8.w),
                                      child: Icon(
                                        Icons.arrow_upward,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              )
            : Center(
                child: Text(val == -1 ? "无法连接" : "连接中....."),
              ),
      ))
    ]);
  }
}
