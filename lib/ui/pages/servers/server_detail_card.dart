import 'package:aria2_client/aria2/model/aria2_server_config.dart';
import 'package:aria2_client/ui/pages/servers/server_card.dart';
import 'package:aria2_client/ui/pages/servers/server_detail_speed_chart.dart';
import 'package:aria2_client/ui/pages/servers/server_overview_card.dart';
import 'package:aria2_client/util/card_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServerDetailCard extends StatefulWidget {
  String tag;

  ServerDetailCard({
    required this.tag,
    super.key,
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
  late AnimationController controller;

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
                  child: Hero(
                      tag: widget.tag,
                      child: CardUtil.buildFilterCard(
                          ServerBaseInfo(visibleUri: true)))),
              SlideTransition(
                position: controller.drive(Tween<Offset>(
                    begin: const Offset(0, 1), end: const Offset(0, 0))),
                child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * 0.3,
                    child: CardUtil.buildFilterCard(
                        const ServerDetailSpeedChart())),
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

  Widget buildInfoPanel() {
    return Selector<ServerCardModel, bool>(
      builder: (context, isAvailable, child) {
        List<Widget> children = List.empty(growable: true);
        if (isAvailable) {
          Aria2ServerConfig? serverConfig =
              context.read<ServerCardModel>().aria2.serverConfig;
          for (var value in enabledFeatures) {
            children.add(MyTag(
                text: value,
                isSelected: serverConfig == null
                    ? false
                    : serverConfig.enabledFeatures.contains(value)));
          }
        }
        return Center(
          child: Wrap(
            direction: Axis.horizontal,
            children: children,
          ),
        );
      },
      selector: (context, model) => model.isAvailable,
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
