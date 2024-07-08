import 'dart:math';

import 'package:aria2_client/ui/pages/servers/server_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../aria2/model/aria2.dart';
import '../../../aria2/model/aria2_global_status.dart';
import '../../../net/aria2_rpc_client.dart';
import '../../../timer/my_timer.dart';
import '../../../util/Util.dart';
import '../../../util/card_util.dart';

class ServerGlobalStatus extends StatefulWidget {
  Aria2 aria2;

  Aria2RpcClient client;

  ServerGlobalStatus({super.key, required this.aria2, required this.client});

  @override
  State<StatefulWidget> createState() {
    return ServerGlobalStatusState();
  }
}

class ServerGlobalStatusState extends State<ServerGlobalStatus> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ServerCardModel model = Provider.of<ServerCardModel>(context);

    return CardUtil.buildFilterCard(SizedBox.expand(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Center(
                child: Text(widget.aria2.config.name,
                    style: const TextStyle(fontSize: 20)),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildRadialGauge(true, model),
            const SizedBox(width: 5),
            buildRadialGauge(false, model)
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("下载速度"), SizedBox(width: 55), Text("上传速度")],
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("下载中"),
              const SizedBox(width: 10),
              Text(model.globalStatus.numActive.toString()),
              const SizedBox(width: 10),
              const Text("等待中"),
              const SizedBox(width: 10),
              Text(model.globalStatus.numWaiting.toString()),
              const SizedBox(width: 10),
              const Text("已停止"),
              const SizedBox(width: 10),
              Text(model.globalStatus.numStopped.toString()),
            ],
          ),
        ),
      ],
    )));
  }

  buildRadialGauge(bool isDownload, ServerCardModel model) {
    Pair<double, String> pair = Util.formatBytesWithUnit(
        isDownload
            ? model.globalStatus.downloadSpeed
            : model.globalStatus.uploadSpeed,
        DataUnit.MB);
    double value = pair.first!;
    String unit = pair.second!;
    String valueString = value.toString();
    if (value < 1) {
      Pair<double, String> pair2 = Util.formatBytes(isDownload
          ? model.globalStatus.downloadSpeed
          : model.globalStatus.uploadSpeed);
      valueString = pair2.first!.toString();
      unit = pair2.second!;
    }

    return CardUtil.buildFilterCard(SizedBox(
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
        )));
  }
}
