import 'dart:async';

import 'package:aria2_client/aria2/model/aria2_global_status.dart';
import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/event/base_event.dart';
import 'package:aria2_client/event/event_bus_manager.dart';
import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/application.dart';
import 'package:aria2_client/providers/server_model.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/timer/my_timer.dart';
import 'package:aria2_client/timer/my_timer_state.dart';
import 'package:aria2_client/ui/component/overlay/my_clip_overlay.dart';
import 'package:aria2_client/ui/pages/servers/item/server_list_view.dart';
import 'package:aria2_client/ui/pages/servers/server_content.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'server_card_view.dart';

class ServerItem extends StatefulWidget {
  final ServerModel model;
  final ViewType type;
  final Future<void> Function()? onTap;
  final double width;
  final double height;

  const ServerItem(
      {super.key,
      required this.model,
      required this.type,
      this.onTap,
      required this.width,
      required this.height});

  static Widget buildCheckBox(ValueNotifier<bool> isSelected,
      [ValueChanged<bool>? callback]) {
    return Positioned(
        top: 10,
        right: 20,
        child: ValueListenableBuilder(
            valueListenable: isSelected,
            builder: (context, value, child) {
              return GestureDetector(
                  onTap: () {
                    if (!value) {
                      Application.instance
                          .changeServer(context.read<ServerModel>());
                      callback?.call(value);
                    }
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    switchInCurve: Curves.easeInBack,
                    switchOutCurve: Curves.linear,
                    transitionBuilder: (child, animation) {
                      animation = animation.drive(Tween(begin: 1.0, end: 1.2));
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: Icon(
                      key: UniqueKey(),
                      Icons.check_circle_outline,
                      color: value
                          ? Theme.of(context).indicatorColor
                          : Theme.of(context).splashColor,
                    ),
                  ));
            }));
  }

  @override
  State<StatefulWidget> createState() {
    return _ServerItemState();
  }
}

class _ServerItemState extends MyTimerState<ServerItem>
    with TickerProviderStateMixin {
  late GlobalKey<MyClipOverlayState> overlayKey;
  late StreamSubscription<CheckAvailableEvent> subscription;
  late VoidCallback _currentChangeCallBack;
  late ValueNotifier<bool> _isSelected;

  late double _containerWidth;
  late double _containerHeight;

  @override
  MyTimer initTimer() {
    return MyTimer(
        duration: Duration(
            seconds: IHive.settings
                .get(SettingsHiveKey.globalRefreshInterval, defaultValue: 1)),
        onTime: (timer, value) async {
          return Aria2RpcClient.instance.getGlobalStatus().then((result) {
            if (result.success) {
              widget.model
                  .updateGlobalStatus(Aria2GlobalStatus.fromJson(result.data));
            }
            return result.success;
          });
        },
        onError: () {
          Util.showErrorToast(
              "Can not connect to Aria2 ${widget.model.aria2.config.uri.toString()}");
        });
  }

  @override
  void initState() {
    super.initState();
    _containerWidth = widget.width;
    _containerHeight = widget.height;
    overlayKey = GlobalKey<MyClipOverlayState>();
    _isSelected = ValueNotifier(
        Application.instance.selectedServer.value == widget.model);
    subscription =
        EventBusManager.eventBus.on<CheckAvailableEvent>().listen((event) {
      widget.model.checkServerAvailable(true);
    });
    _currentChangeCallBack = () {
      if (Application.instance.selectedServer.value == widget.model) {
        _isSelected.value = true;
        startTimer();
      } else {
        _isSelected.value = false;
        pauseTimer();
        widget.model.resetGlobalStatus();
      }
    };
    Application.instance.selectedServer.addListener(_currentChangeCallBack);
  }

  @override
  void onResume() {
    if (widget.model.isCurrent) {
      startTimer();
    }
  }

  @override
  void dispose() {
    subscription.cancel();
    Application.instance.selectedServer.removeListener(_currentChangeCallBack);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: widget.model, child: buildContent());
  }

  Widget buildContent() {
    if (widget.type == ViewType.list) {
      return Container(
              margin: EdgeInsets.all(10.w),
              height: _containerHeight,
              child: MyClipOverlay(
                key: overlayKey,
                duration: Const.duration500ms,
                overlayContentBuilder: (leftTop, bottomRight, animation) {
                  return Positioned(
                      bottom: bottomRight.dy - 25.h,
                      right: bottomRight.dx + 10.w,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        width: 80.w,
                        height: (20 * animation.value).h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).splashColor,
                          ),
                          onPressed: () {
                            overlayKey.currentState!.hidden();
                            Application.instance
                                .removeAria2(widget.model.aria2.config);
                          },
                          child: Text(S.of(context).delete),
                        ),
                      ));
                },
                builder: (context, animation, child) {
                  return GestureDetector(
                      onLongPress: () {
                        if (!overlayKey.currentState!.isDisplay) {
                          if (widget.onTap != null) {
                            widget.onTap!.call().then((_) {
                              overlayKey.currentState!.display();
                            });
                          } else {
                            overlayKey.currentState!.display();
                          }
                        }
                      },
                      child: ScaleTransition(
                          scale: animation
                              .drive(CurveTween(curve: Curves.easeInOutBack))
                              .drive(Tween(begin: 1.0, end: 1.06)),
                          child: child));
                },
                child: ServerListView(
                  isSelected: _isSelected,
                ),
              ));
    } else {
      return SizedBox(
          width: widget.width,
          child: ServerCardView(
            isSelected: _isSelected,
          ));
    }
  }
}
