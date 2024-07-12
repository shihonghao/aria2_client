import 'package:aria2_client/ui/pages/servers/server_card.dart';
import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:provider/provider.dart';

import '../../../aria2/model/aria2.dart';
import '../../../aria2/model/aria2_global_status.dart';
import '../../../net/aria2_rpc_client.dart';
import '../../../util/Util.dart';
import '../../../util/card_util.dart';

class ServerGlobalStatus extends StatefulWidget {
  const ServerGlobalStatus({super.key});

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
    Aria2GlobalStatus globalStatus = model.globalStatus;
    Aria2 aria2 = model.aria2;
    return CardUtil.buildFilterCard(LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
              width: constraints.maxHeight,
              height: constraints.maxWidth,
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.1,
                    margin: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(aria2.config.name,
                          style: const TextStyle(fontSize: 20)),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.5,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildSpeedGauge(constraints, globalStatus, true),
                          buildSpeedGauge(constraints, globalStatus, false)
                        ]),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: constraints.maxWidth * 0.4,
                            child: const Center(child: Text("下载速度"))),
                        SizedBox(
                          width: constraints.maxWidth * 0.1,
                        ),
                        SizedBox(
                            width: constraints.maxWidth * 0.4,
                            child: const Center(child: Text("上传速度"))),
                      ],
                    ),
                  ),
                  Container(
                    height: constraints.maxHeight * 0.1,
                    margin: EdgeInsets.fromLTRB(
                        constraints.maxWidth * 0.05, 10, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: constraints.maxWidth * 0.2,
                            child: const Text("下载中")),
                        // const SizedBox(width: 10),
                        SizedBox(
                            width: constraints.maxWidth * 0.1,
                            child: Text(globalStatus.numActive.toString())),
                        // const SizedBox(width: 10),
                        SizedBox(
                            width: constraints.maxWidth * 0.2,
                            child: const Text("等待中")),
                        // const SizedBox(width: 10),
                        SizedBox(
                            width: constraints.maxWidth * 0.1,
                            child: Text(globalStatus.numWaiting.toString())),
                        // const SizedBox(width: 10),
                        SizedBox(
                            width: constraints.maxWidth * 0.2,
                            child: const Text("已停止")),
                        // const SizedBox(width: 10),
                        SizedBox(
                            width: constraints.maxWidth * 0.1,
                            child: Text(globalStatus.numStopped.toString())),
                      ],
                    ),
                  ),
                ],
              ));
        }));
  }

  buildSpeedGauge(
      BoxConstraints constraints, Aria2GlobalStatus model, bool isDownload) {
    Pair<double, DataUnit> pair = Util.formatBytesWithUnit(
        isDownload ? model.downloadSpeed : model.uploadSpeed, DataUnit.MB);
    double value = pair.first!;
    String unit = pair.second!.name;
    String valueString = value.toString();
    if (value < 1) {
      Pair<double, DataUnit> pair2 = Util.formatBytes(
          isDownload ? model.downloadSpeed : model.uploadSpeed);
      valueString = pair2.first!.toString();
      unit = pair2.second!.name;
    }
    return CardUtil.buildFilterCard(SizedBox(
        width: constraints.maxWidth * 0.4,
        height: constraints.maxHeight * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedRadialGauge(
            duration: const Duration(milliseconds: 500),
            value: value,
            axis: const GaugeAxis(

                /// Provide the [min] and [max] value for the [value] argument.
                min: 0,
                max: 40,

                /// Render the gauge as a 180-degree arc.
                degrees: 270,

                /// Set the background color and axis thickness.
                style: GaugeAxisStyle(
                  thickness: 7,
                  background: Color(0xFFDFE2EC),
                  segmentSpacing: 4,
                ),

                /// Define the pointer that will indicate the progress (optional).
                pointer: GaugePointer.circle(
                  border: GaugePointerBorder(color: Colors.black45,width: 1),
                    radius: 5.0, color: Colors.lightGreenAccent),

                /// Define the progress bar (optional).
                progressBar: GaugeProgressBar.rounded(
                    color: Color(0xFFF67280),
                    gradient: GaugeAxisGradient(
                        colors: <Color>[Color(0xFFFF7676), Color(0xFFF54EA2)],
                        colorStops: <double>[0.25, 0.75])),

                /// Define axis segments (optional).
                segments: [
                  GaugeSegment(
                    from: 0,
                    to: 40,
                    color: Color(0xFFD9DEEB),
                    cornerRadius: Radius.circular(10),
                  ),
                  // GaugeSegment(
                  //   from: 13.33,
                  //   to: 26.66,
                  //   color: Color(0xFFD9DEEB),
                  //   cornerRadius: Radius.circular(10),
                  // ),
                  // GaugeSegment(
                  //   from: 26.66,
                  //   to: 40,
                  //   color: Color(0xFFD9DEEB),
                  //   cornerRadius: Radius.circular(10),
                  // ),
                ]),
            builder: (context, child, value) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      valueString,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "$unit/s",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        )));
  }
}
