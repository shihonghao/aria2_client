import 'package:aria2_client/ui/pages/servers/server_card.dart';
import 'package:aria2_client/ui/pages/servers/server_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../aria2/model/aria2.dart';
import '../../../net/aria2_rpc_client.dart';
import '../../../util/card_util.dart';
import '../../component/pageRoute/my_transparent_page_route.dart';

class ServerOverviewCard extends StatefulWidget {
  int? index;
  final Aria2 aria2;
  final Aria2RpcClient client;

  ServerOverviewCard(
      {super.key, this.index, required this.aria2, required this.client});

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
    String tag = "overview-${widget.index ?? 0}";
    Widget card = CardUtil.buildFilterCard(buildBaseInfo());
    return GestureDetector(
      onLongPress: () {
        Navigator.push(context, MyTransparentPageRoute(builder: (context) {
          return ServerDetailCard(
            hero: Hero(
              tag: tag,
              child: card,
            ),
          );
        }));
      },
      child: Hero(tag: tag, child: card),
    );
  }

  Widget buildBaseInfo() {
    ServerCardModel model = Provider.of<ServerCardModel>(context);

    return Stack(
      children: [
        const Positioned(
            top: 20, left: 20, child: Icon(TDIcons.server, size: 60)),
        Positioned(
            top: 30,
            right: 30,
            child: Text(widget.aria2.config.name,
                style: const TextStyle(fontSize: 30))),
        Visibility(
          visible: model.isTesting,
          child: Positioned(
              bottom: 30,
              right: 30,
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.red, size: 50)),
        ),
        Visibility(
            visible: !model.isTesting,
            child: Positioned(
                bottom: 30,
                right: 30,
                child: Text(model.isAvailable ? '在线' : '离线',
                    style: const TextStyle(fontSize: 20)))),
      ],
    );
  }
}
