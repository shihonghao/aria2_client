import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:aria2_client/ui/pages/servers/server_card.dart';
import 'package:aria2_client/ui/pages/servers/server_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../aria2/model/aria2.dart';
import '../../../net/aria2_rpc_client.dart';
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
  late ServerCardModel model;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildOverview();
  }

  Widget buildOverview() {
    ServerCardModel serverCardModel = Provider.of<ServerCardModel>(context);
    String tag = Util.generateId("overview");
    return GestureDetector(
      onLongPress: () {
        Navigator.push(context, MyTransparentPageRoute(builder: (context) {
          return ChangeNotifierProvider.value(
              value: serverCardModel,
              child: ServerDetailCard(
                hero: Hero(
                  tag: tag,
                  child: CardUtil.buildFilterCard(buildBaseInfo(true)),
                ),
              ));
        }));
      },
      child:
          Hero(tag: tag, child: CardUtil.buildFilterCard(buildBaseInfo(false))),
    );
  }

  Widget buildBaseInfo(bool more) {
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
            visible: more,
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
                )

                //
                // model.aria2.config.uri.toString(),
                // style: const TextStyle(fontSize: 10)))
                )),
      ],
    );
  }
}
