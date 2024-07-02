import 'dart:math';
import 'dart:ui';

import 'package:aria2_client/aria2/model/aria2_global_status.dart';
import 'package:aria2_client/net/Aria2RpcFactory.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../aria2/model/aria2.dart';
import '../../providers/aria2_model.dart';
import '../../timer/my_timer.dart';
import '../../util/Util.dart';

class ServerCard extends StatefulWidget {
  ServerCard({super.key, required this.aria2})
      : client = Aria2RpcFactory.create(aria2.config);

  final Aria2 aria2;

  bool isCurrent = false;

  bool isAvailable = false;

  bool isTesting = false;

  late Aria2RpcClient client;

  @override
  State<StatefulWidget> createState() {
    return _ServerCardState();
  }
}

class _ServerCardState extends State<ServerCard> with TickerProviderStateMixin {
  late AnimationController _animationController;

  // 翻转动画
  late Animation<double> _rotateAnimation;

  late AnimationStatus _lastStatus = AnimationStatus.dismissed;

  // 定义一个翻转从左往右，为false，如果为true，则从右往左开始翻转
  bool _flipReversal = false;

  bool _isDisposed = false;

  late MyTimer globalStatusTimer;

  Aria2GlobalStatus globalStatus = Aria2GlobalStatus(
      downloadSpeed: 0,
      uploadSpeed: 1345464560,
      numActive: 0,
      numWaiting: 0,
      numStopped: 0,
      numStoppedTotal: 0);

  @override
  void initState() {
    checkServerAvailable();
    super.initState();
    _isDisposed = false;
    _flipReversal = false;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    //使用弹性曲线
    _rotateAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _rotateAnimation = Tween(begin: 0.0, end: pi).animate(_rotateAnimation);

    _animationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    _animationController.addStatusListener((status) {
      if (status == _lastStatus) return;
      _lastStatus = status;
    });

    globalStatusTimer = MyTimer();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    _isDisposed = true;
  }

  @override
  Widget build(BuildContext context) {
    return Selector<Aria2Model, Aria2?>(
        selector: (context, model) => model.current,
        builder: (context, value, child) {
          if (value != null) {
            if (value.config.name == widget.aria2.config.name) {
              widget.isCurrent = true;
            }
          }
          return GestureDetector(
              onTap: () {
                cardFlip(_flipReversal);
              },
              child: Transform(
                transform: buildTransform(),
                alignment: Alignment.center,
                child: IndexedStack(
                  sizing: StackFit.expand,
                  textDirection: TextDirection.rtl,
                  index: _rotateAnimation.value < pi / 2.0 ? 0 : 1,
                  children: [
                    buildOverview(),
                    buildRealTime(),
                  ],
                ),
              ));
        });
  }

  // 翻转动画
  void cardFlip(bool reverse) {
    if (_isDisposed == true) {
      return;
    }

    if (_animationController.isAnimating) return;
    if (reverse) {
      stopGlobalStatusTimer();
      _animationController.reverse();
    } else {
      startGlobalStatusTimer();
      _animationController.forward();
    }
    _flipReversal = !_flipReversal;
  }

  void checkServerAvailable() {
    setState(() {
      widget.isTesting = true;
    });
    widget.client.connect().then((value) {
      var available = false;
      if (value != false) {
        available = true;
      }
      setState(() {
        widget.isTesting = false;
        widget.isAvailable = available;
      });
    });
  }

  Card buildFilterCard(Widget child) {
    return Card(
      color: widget.isAvailable ? Colors.green : Colors.red,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: child,
        ),
      ),
    );
  }

  Widget buildOverview() {
    return buildFilterCard(Stack(
      children: [
        const Positioned(
            top: 20, left: 20, child: Icon(TDIcons.server, size: 60)),
        Positioned(
            top: 30,
            right: 30,
            child: Text(widget.aria2.config.name,
                style: const TextStyle(fontSize: 30))),
        Visibility(
          visible: widget.isTesting,
          child: Positioned(
              bottom: 30,
              right: 30,
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.red, size: 50)),
        ),
        Visibility(
            visible: !widget.isTesting,
            child: Positioned(
                bottom: 30,
                right: 30,
                child: Text(widget.isAvailable ? '在线' : '离线',
                    style: const TextStyle(fontSize: 20)))),
      ],
    ));
  }

  Widget buildRealTime() {
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(pi),
        child: buildFilterCard(Stack(
          children: [
            Positioned(
                top: 10,
                right: 80,
                child: Text(widget.aria2.config.name,
                    style: const TextStyle(fontSize: 20))),
            Positioned(
              child: buildRadialGauge(true),
              top: 50,
              left: 20,
            ),
            const Positioned(
              top: 150,
              left: 40,
              child: Text("下载速度"),
            ),
            Positioned(
              child: buildRadialGauge(false),
              top: 50,
              right: 20,
            ),
            const Positioned(
              top: 150,
              right: 40,
              child: Text("上传速度"),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              child: Row(
                children: [
                  const Text("下载中"),
                  const SizedBox(width: 10),
                  Text(globalStatus.numActive.toString()),
                  const SizedBox(width: 10),
                  const Text("等待中"),
                  const SizedBox(width: 10),
                  Text(globalStatus.numWaiting.toString()),
                  const SizedBox(width: 10),
                  const Text("已停止"),
                  const SizedBox(width: 10),
                  Text(globalStatus.numStopped.toString()),
                ],
              ),
            ),
          ],
        )));
  }

  buildRadialGauge(bool isDownload) {
    Pair<double, String> pair = Util.formatBytesWithUnit(
        isDownload ? globalStatus.downloadSpeed : globalStatus.uploadSpeed,
        DataUnit.MB);
    double value = pair.first!;
    String unit = pair.second!;
    String valueString = value.toString();
    if (value < 1) {
      Pair<double, String> pair2 = Util.formatBytes(
          isDownload ? globalStatus.downloadSpeed : globalStatus.uploadSpeed);
      valueString = pair2.first!.toString();
      unit = pair2.second!;
    }

    return SizedBox(
        width: 100,
        height: 100,
        child: SfRadialGauge(
          enableLoadingAnimation: true,
          axes: <RadialAxis>[
            RadialAxis(
                showLabels: false,
                showTicks: false,
                radiusFactor: 0.8,
                maximum: 40,
                axisLineStyle: const AxisLineStyle(
                    cornerStyle: CornerStyle.startCurve, thickness: 5),
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      angle: 90,
                      widget: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(valueString,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                            child: Text(
                              "$unit/s",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 12),
                            ),
                          )
                        ],
                      )),
                  const GaugeAnnotation(
                    angle: 124,
                    positionFactor: 1.2,
                    widget: Text('0', style: TextStyle(fontSize: 12)),
                  ),
                  const GaugeAnnotation(
                    angle: 54,
                    positionFactor: 1.2,
                    widget: Text('40', style: TextStyle(fontSize: 12)),
                  ),
                ],
                pointers: <GaugePointer>[
                  RangePointer(
                    value: value,
                    width: 5,
                    pointerOffset: 0,
                    cornerStyle: CornerStyle.bothCurve,
                    color: const Color(0xFFF67280),
                    enableAnimation: true,
                    gradient: const SweepGradient(
                        colors: <Color>[Color(0xFFFF7676), Color(0xFFF54EA2)],
                        stops: <double>[0.25, 0.75]),
                  ),
                  MarkerPointer(
                    value: value,
                    color: Colors.lightGreenAccent,
                    markerType: MarkerType.circle,
                    markerHeight: 7,
                    markerWidth: 7,
                    enableAnimation: true,
                  ),
                ]),
          ],
        ));
  }

  Matrix4 buildTransform() {
    final matrix = Matrix4.identity()..rotateY(_rotateAnimation.value);
    return matrix;
  }

  void startGlobalStatusTimer() {
    globalStatusTimer.reStart(1, null, (timer, value) async {
      // widget.client.getGlobalStatus().then((result) {
      //   globalStatus = Aria2GlobalStatus.fromJson(result);
      // });
      globalStatus = Aria2GlobalStatus(
          downloadSpeed: Random.secure().nextInt(40 * 1024 * 1024),
          uploadSpeed: Random.secure().nextInt(40 * 1024 * 1024),
          numActive: Random.secure().nextInt(10),
          numWaiting: Random.secure().nextInt(10),
          numStopped: Random.secure().nextInt(10),
          numStoppedTotal: Random.secure().nextInt(10));
      setState(() {});
    });
  }

  void stopGlobalStatusTimer() {
    globalStatusTimer.stop();
  }
}
