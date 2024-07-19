import 'package:aria2_client/ui/pages/servers/server_card.dart';
import 'package:aria2_client/ui/pages/servers/servers_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:load_switch/load_switch.dart';
import 'package:provider/provider.dart';

import '../../../event/event_bus_manager.dart';
import '../../../util/Util.dart';

class ServerDetailSpeedChart extends StatefulWidget {
  const ServerDetailSpeedChart({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ServerDetailSpeedChartState();
  }
}

class _ServerDetailSpeedChartState extends State<ServerDetailSpeedChart> {
  DataUnit selectedSpeedUnit = DataUnit.MB;
  late String key;
  final uploadSpeedPoints = <FlSpot>[const FlSpot(0, 0)];
  final downloadSpeedPoints = <FlSpot>[const FlSpot(0, 0)];
  DataUnit? lastDownloadUnit;
  DataUnit? lastUploadUnit;
  final limitCount = 60;

  double xValue = 1;
  double step = 1;

  List<Color> gradientColors = [Colors.cyan, Colors.blue];

  @override
  void dispose() {
    EventBusManager.eventBus.fire(
        ServerPageEvent(key: key, eventType: ServerPageEventType.STOP_MONITOR));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    key = context.read<ServerModel>().key;
    return buildLineChart();
  }

  Widget buildLineChart() {
    ServerModel model = Provider.of<ServerModel>(context);
    Pair<double, DataUnit> downloadPair = Util.formatBytesWithUnit(
        model.globalStatus.downloadSpeed, selectedSpeedUnit);
    Pair<double, DataUnit> uploadPair = Util.formatBytesWithUnit(
        model.globalStatus.uploadSpeed, selectedSpeedUnit);

    return Stack(children: [
      Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0), //阴影y轴偏移量
                        blurRadius: 10, //阴影模糊程度
                        spreadRadius: 0 //阴影扩散程度
                        )
                  ],
                ),
                width: 30,
                height: 5,
              ),
              const SizedBox(
                width: 5,
              ),
              Text("上传 ${uploadPair.first} ${uploadPair.second.name}/s"),
              const SizedBox(
                width: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 1.0), //阴影y轴偏移量
                        blurRadius: 10, //阴影模糊程度
                        spreadRadius: 0 //阴影扩散程度
                        )
                  ],
                ),
                width: 30,
                height: 5,
              ),
              const SizedBox(
                width: 5,
              ),
              Text("下载 ${downloadPair.first} ${downloadPair.second.name}/s")
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: LineChart(speedLineData(model)),
          ),
        ),
      ]),
      Positioned(
        right: 20,
        top: 10,
        child: LoadSwitch(
          width: 50,
          height: 25,
          thumbDecoration: (value, isActive) => BoxDecoration(
            color: Colors.lightGreenAccent,
            borderRadius: BorderRadius.circular(30),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: value
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          switchDecoration: (value, isActive) => BoxDecoration(
            color: value ? Colors.green[100] : Colors.grey,
            borderRadius: BorderRadius.circular(30),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: value
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          value: model.isMonitoring,
          future: () async {
            EventBusManager.eventBus.fire(ServerPageEvent(
                key: key,
                eventType: !model.isAvailable
                    ? ServerPageEventType.CHECK_AVAILABLE_AND_START_MONITOR
                    : model.isMonitoring
                        ? ServerPageEventType.STOP_MONITOR
                        : ServerPageEventType.START_MONITOR));
            await Future.delayed(const Duration(seconds: 1));
            return model.isMonitoring;
          },
          onChange: (value) {},
          onTap: (value) {},
          // ),
        ),
      ),
      Positioned(
          left: 20,
          top: 10,
          child: GestureDetector(
              onTap: () {
                var index = DataUnit.values.indexOf(selectedSpeedUnit);
                if (index == DataUnit.values.length - 1) {
                  selectedSpeedUnit = DataUnit.values.first;
                } else {
                  selectedSpeedUnit = DataUnit.values[index + 1];
                }
                setState(() {});
              },
              child: Text(
                selectedSpeedUnit.name,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white60,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.white,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ))),
    ]);
  }

  LineChartData speedLineData(ServerModel model) {
    Pair<AxisTitles, AxisTitles>? titleWidgets;
    if (model.isAvailable) {
      while (uploadSpeedPoints.length > limitCount) {
        uploadSpeedPoints.removeAt(0);
      }
      while (downloadSpeedPoints.length > limitCount) {
        downloadSpeedPoints.removeAt(0);
      }

      Pair<double, DataUnit> downloadPair = Util.formatBytesWithUnit(
          model.globalStatus.downloadSpeed, selectedSpeedUnit);
      Pair<double, DataUnit> uploadPair = Util.formatBytesWithUnit(
          model.globalStatus.uploadSpeed, selectedSpeedUnit);

      DataUnit downloadUnit = downloadPair.second;
      DataUnit uploadUnit = uploadPair.second;
      double downloadValue = downloadPair.first;
      double uploadValue = uploadPair.first;

      calculatePoints(downloadUnit, downloadValue, uploadUnit, uploadValue);
      xValue += step;
    }

    return LineChartData(
      minX: uploadSpeedPoints.isEmpty ? 0 : uploadSpeedPoints.first.x,
      maxX: uploadSpeedPoints.isEmpty
          ? limitCount.toDouble()
          : uploadSpeedPoints.last.x < limitCount
              ? limitCount.toDouble()
              : uploadSpeedPoints.last.x,
      minY: 0,
      lineTouchData: const LineTouchData(enabled: false),
      gridData: buildGridData(),
      // clipData: const FlClipData.all(),
      titlesData: buildTitleData(titleWidgets),
      borderData: buildBorderData(),
      lineBarsData: buildLineBarsData(),
    );
  }

  AxisTitles buildTitleWidgets(double max, bool isLeft) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black54,
      fontSize: 15,
    );

    return AxisTitles(
      sideTitles: SideTitles(
        showTitles: true,
        interval: 1,
        getTitlesWidget: (value, _) {
          var arr = [
            (max * 0.1).floor(),
            (max * 0.2).floor(),
            (max * 0.4).floor(),
            (max * 0.6).floor(),
            (max * 0.8).floor(),
            (max).floor(),
            (max * 1.1).floor(),
          ];
          if (arr.contains(value.floor())) {
            return Text("${value.floor()}",
                style: style,
                textAlign: isLeft ? TextAlign.right : TextAlign.left);
          } else {
            return Container();
          }
        },
        reservedSize: max < 100
            ? 30
            : max > 100
                ? 50
                : 70,
      ),
    );
  }

  Pair<AxisTitles, AxisTitles> buildTitle(
      DataUnit downloadUnit, DataUnit uploadUnit) {
    return Pair(
        first: buildTitleWidgets(
            (downloadUnit == DataUnit.B || downloadUnit == DataUnit.KB)
                ? 1024
                : 40,
            true),
        second: buildTitleWidgets(
            (uploadUnit == DataUnit.B || uploadUnit == DataUnit.KB) ? 1024 : 40,
            false));
  }

  void calculatePoints(DataUnit downloadUnit, double downloadValue,
      DataUnit uploadUnit, double uploadValue) {
    if (lastDownloadUnit != null && downloadUnit != lastDownloadUnit) {
      downloadSpeedPoints.clear();
    }

    if (lastUploadUnit != null && uploadUnit != lastUploadUnit) {
      uploadSpeedPoints.clear();
    }
    lastUploadUnit = uploadUnit;
    lastDownloadUnit = downloadUnit;
    downloadSpeedPoints.add(FlSpot(xValue, downloadValue));
    uploadSpeedPoints
        .add(FlSpot(xValue, uploadUnit.convertData(uploadValue, downloadUnit)));
  }

  FlGridData buildGridData() {
    return FlGridData(
      show: false,
      drawVerticalLine: true,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: Colors.white10,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: Colors.white10,
          strokeWidth: 1,
        );
      },
    );
  }

  FlTitlesData buildTitleData(Pair<AxisTitles, AxisTitles>? titles) {
    AxisTitles defaultTitle = const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    );
    return FlTitlesData(
      show: true,
      rightTitles: titles == null ? defaultTitle : titles.second,
      topTitles: defaultTitle,
      bottomTitles: defaultTitle,
      leftTitles: titles == null ? defaultTitle : titles.first,
    );
  }

  FlBorderData buildBorderData() {
    return FlBorderData(
      show: false,
      border: Border.all(color: const Color(0xff37434d)),
    );
  }

  buildLineBarsData() {
    return [
      LineChartBarData(
        spots: uploadSpeedPoints,
        isCurved: true,
        gradient: LinearGradient(
          colors: [Colors.blue.withOpacity(0), Colors.blue],
          stops: const [0.05, 0.1],
        ),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
      ),
      LineChartBarData(
        spots: downloadSpeedPoints,
        isCurved: true,
        gradient: LinearGradient(
          colors: [Colors.grey.withOpacity(0), Colors.grey],
          stops: const [0.05, 0.1],
        ),
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
      ),
    ];
  }
}
