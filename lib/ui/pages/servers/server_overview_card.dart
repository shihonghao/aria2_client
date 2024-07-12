import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:aria2_client/ui/pages/servers/server_card.dart';
import 'package:aria2_client/ui/pages/servers/server_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../util/Util.dart';
import '../../../util/card_util.dart';
import '../../component/pageRoute/my_transparent_page_route.dart';

typedef BoolCallBack = Future<bool> Function();

class ServerOverviewCard extends StatefulWidget {
  const ServerOverviewCard({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ServerOverviewCardState();
  }
}

class _ServerOverviewCardState extends State<ServerOverviewCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildOverview();
  }

  Widget buildOverview() {
    String tag = Util.generateId("overview");
    ServerCardModel model = context.read<ServerCardModel>();
    return GestureDetector(
      onLongPress: () {
        Navigator.push(context, MyTransparentPageRoute(builder: (context) {
          return ChangeNotifierProvider.value(
            value: model,
            child: ServerDetailCard(tag: tag),
          );
        }));
      },
      child:
      Hero(tag: tag, child: CardUtil.buildFilterCard(ServerBaseInfo(visibleUri: false))),
    );
  }

}

class ServerBaseInfo extends StatefulWidget {

  bool visibleUri;

  ServerBaseInfo({super.key, required this.visibleUri});

  @override
  State<StatefulWidget> createState() {
    return _ServerBaseInfoState();
  }

}

class _ServerBaseInfoState extends State<ServerBaseInfo> {
  @override
  Widget build(BuildContext context) {
    ServerCardModel model = Provider.of<ServerCardModel>(context);
    return Stack(
      children: [
        const Positioned(
            top: 20, left: 20, child: Icon(TDIcons.server, size: 60)),
        Positioned(
            top: 30,
            right: 30,
            child: Text(model.aria2.config.name,
                style: const TextStyle(fontSize: 30))),
        Visibility(
          visible: model.isTesting,
          child: Positioned(
              bottom: 10,
              right: 30,
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.red, size: 50)),
        ),
        Visibility(
            visible: !model.isTesting,
            child: Positioned(
                bottom: 10,
                right: 30,
                child: Text(model.isAvailable ? '在线' : '离线',
                    style: const TextStyle(fontSize: 20)))),
        Visibility(
            visible: widget.visibleUri,
            child: Positioned(
                bottom: 10,
                left: 30,
                child: AnimatedTextKit(
                  pause: const Duration(milliseconds: 200),
                  repeatForever: true,
                  animatedTexts: [
                    ColorizeAnimatedText(model.aria2.config.uri.toString(),
                        speed: const Duration(milliseconds: 100),
                        textStyle: const TextStyle(fontSize: 15),
                        colors: [
                          Colors.white38,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red,
                        ])
                  ],
                ))),
      ],
    );
  }
}
