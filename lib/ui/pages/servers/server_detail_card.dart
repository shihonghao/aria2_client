import 'package:aria2_client/aria2/model/aria2_server_config.dart';
import 'package:aria2_client/event/event_bus_manager.dart';
import 'package:aria2_client/ui/pages/servers/server_card.dart';
import 'package:aria2_client/util/card_util.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:load_switch/load_switch.dart';
import 'package:provider/provider.dart';

import '../../../util/Util.dart';

class ServerDetailCard extends StatefulWidget {
  Widget hero;

  ServerDetailCard({
    super.key,
    required this.hero,
  });

  @override
  State<StatefulWidget> createState() {
    return _ServerDetailCardState();
  }
}

class _ServerDetailCardState extends State<ServerDetailCard>
    with SingleTickerProviderStateMixin {
  final List<String> enabledFeatures = [
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
  final limitCount = 30;
  String? id;
  late AnimationController controller;
  final uploadSpeedPoints = <FlSpot>[];
  final downloadSpeedPoints = <FlSpot>[];
  DataUnit? lastDownloadUnit;
  DataUnit? lastUploadUnit;

  DataUnit selectedSpeedUnit = DataUnit.MB;

  double xValue = 1;
  double step = 1;

  List<Color> gradientColors = [Colors.cyan, Colors.blue];

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.reverse();
    controller.dispose();
    EventBusManager.eventBus.fire(
        ServerCardEvent(id: id!, eventType: ServerCardEventType.STOP_MONITOR));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
      },
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.15,
                  child: widget.hero),
              SlideTransition(
                position: controller.drive(Tween<Offset>(
                    begin: const Offset(0, 1), end: const Offset(0, 0))),
                child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.3,
                    child: CardUtil.buildFilterCard(buildLineChart())),
              ),
              SlideTransition(
                position: controller.drive(Tween<Offset>(
                    begin: const Offset(0, 2), end: const Offset(0, 0))),
                child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.25,
                    child: CardUtil.buildFilterCard(buildInfoPanel())),
              ),
              SlideTransition(
                position: controller.drive(Tween<Offset>(
                    begin: const Offset(0, 3), end: const Offset(0, 0))),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        width: constraints.maxWidth * 0.9,
                        height: constraints.maxHeight * 0.08,
                        child: CardUtil.buildFilterCard(
                          const Center(
                            child: Text("Change to this Aria2"),
                          ),
                        ))),
              ),
              SlideTransition(
                position: controller.drive(Tween<Offset>(
                    begin: const Offset(0, 4), end: const Offset(0, 0))),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      width: constraints.maxWidth * 0.9,
                      height: constraints.maxHeight * 0.08,
                      child: CardUtil.buildFilterCard(Container(
                        color: Colors.redAccent,
                        child: const Center(child: Text("Remove")),
                      ))),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildLineChart() {
    ServerCardModel model = Provider.of<ServerCardModel>(context);
    id = model.id;
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
            EventBusManager.eventBus.fire(ServerCardEvent(
                id: id!,
                eventType: !model.isAvailable
                    ? ServerCardEventType.CHECK_AVAILABLE_AND_START_MONITOR
                    : model.isMonitoring
                        ? ServerCardEventType.STOP_MONITOR
                        : ServerCardEventType.START_MONITOR));
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
              child:
                  // AnimatedTextKit(animatedTexts: [
                  Text(
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
              )
              // ]
              // ),
              )),
    ]);
  }

  LineChartData speedLineData(ServerCardModel model) {
    double maxY = 45;
    Pair<AxisTitles, AxisTitles>? titleWidgets;
    if (model.isAvailable) {
      while (uploadSpeedPoints.length > limitCount) {
        uploadSpeedPoints.removeAt(0);
      }
      while (downloadSpeedPoints.length > limitCount) {
        downloadSpeedPoints.removeAt(0);
      }

      // Pair<double, DataUnit> downloadPair =
      //     Util.formatBytes(model.globalStatus.downloadSpeed);
      // Pair<double, DataUnit> uploadPair =
      //     Util.formatBytes(model.globalStatus.uploadSpeed);

      Pair<double, DataUnit> downloadPair = Util.formatBytesWithUnit(
          model.globalStatus.downloadSpeed, selectedSpeedUnit);
      Pair<double, DataUnit> uploadPair = Util.formatBytesWithUnit(
          model.globalStatus.uploadSpeed, selectedSpeedUnit);

      DataUnit downloadUnit = downloadPair.second;
      DataUnit uploadUnit = uploadPair.second;
      double downloadValue = downloadPair.first;
      double uploadValue = uploadPair.first;
      maxY =
          downloadUnit == DataUnit.B || downloadUnit == DataUnit.KB ? 1100 : 45;
      // titleWidgets = buildTitle(downloadUnit, uploadUnit);
      calculatePoints(downloadUnit, downloadValue, uploadUnit, uploadValue);
      xValue += step;
    }

    return LineChartData(
      minX: uploadSpeedPoints.isEmpty ? 0 : uploadSpeedPoints.first.x,
      maxX: uploadSpeedPoints.isEmpty ? 0 : uploadSpeedPoints.last.x,
      minY: 0,
      // maxY: maxY,
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
      // for (var element in downloadSpeedPoints) {
      //   lastDownloadUnit!.convertData(element.y, downloadUnit);
      // }
      // for (var element in uploadSpeedPoints) {
      //   lastDownloadUnit!.convertData(element.y, downloadUnit);
      // }
    }

    if (lastUploadUnit != null && uploadUnit != lastUploadUnit) {
      // for (var element in uploadSpeedPoints) {
      //   lastDownloadUnit!.convertData(element.y, downloadUnit);
      // }
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

  Widget buildInfoPanel() {
    ServerCardModel model = Provider.of<ServerCardModel>(context);
    List<Widget> children = List.empty(growable: true);

    if (model.isAvailable) {
      Aria2ServerConfig? serverConfig = model.aria2.serverConfig;
      for (var value in enabledFeatures) {
        children.add(MyTag(
            text: value,
            isSelected: serverConfig!.enabledFeatures.contains(value)));
      }
    }

    return Center(
      child: Wrap(
        direction: Axis.horizontal,
        children: children,
      ),
    );
  }
}

class MyTag extends StatelessWidget {
  String text;
  bool isSelected;
  Color selectedColor;
  Color unSelectedColor;
  double? height;
  double? width;

  MyTag(
      {super.key,
      required this.text,
      required this.isSelected,
      this.selectedColor = Colors.blue,
      this.unSelectedColor = Colors.grey,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints:
          const BoxConstraints(minHeight: 50, maxWidth: 150, minWidth: 80),
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: isSelected ? selectedColor : unSelectedColor,
            boxShadow: const [
              BoxShadow(blurRadius: 5, spreadRadius: 2, color: Colors.white38)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
