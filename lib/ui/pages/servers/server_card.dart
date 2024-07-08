import 'dart:math';

import 'package:aria2_client/aria2/model/aria2_global_status.dart';
import 'package:aria2_client/net/Aria2RpcFactory.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/ui/pages/servers/server_global_status.dart';
import 'package:aria2_client/ui/pages/servers/server_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../aria2/model/aria2.dart';
import '../../../providers/aria2_model.dart';
import '../../../timer/my_timer.dart';
import '../../component/animation/my_flip_animation.dart';

class ServerCard extends StatefulWidget {
  ServerCard({super.key, required this.aria2, this.index})
      : client = Aria2RpcFactory.create(aria2.config);

  final Aria2 aria2;

  late Aria2RpcClient client;

  int? index;

  @override
  State<StatefulWidget> createState() {
    return _ServerCardState();
  }
}

class _ServerCardState extends State<ServerCard> with TickerProviderStateMixin {
  late MyTimer globalStatusTimer;

  ServerCardModel serverCardModel = ServerCardModel();


  @override
  void initState() {
    initTimer();
    checkServerAvailable();
    super.initState();
  }

  void initTimer() {
    globalStatusTimer = MyTimer(
        savedSecond: 1,
        savedCallback: (timer, value) async {
          // widget.client.getGlobalStatus().then((result) {
          //   globalStatus = Aria2GlobalStatus.fromJson(result);
          // });
          debugPrint("aaaaaaaaaaaaaaaaa");
          serverCardModel.updateGlobalStatus(Aria2GlobalStatus(
              downloadSpeed: Random.secure().nextInt(40 * 1024 * 1024),
              uploadSpeed: Random.secure().nextInt(40 * 1024 * 1024),
              numActive: Random.secure().nextInt(10),
              numWaiting: Random.secure().nextInt(10),
              numStopped: Random.secure().nextInt(10),
              numStoppedTotal: Random.secure().nextInt(10)));
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: ServerCardModel(),
        child: Selector<Aria2Model, Aria2?>(
            selector: (context, model) => model.current,
            builder: (context, value, child) {
              if (value != null) {
                if (value.config.name == widget.aria2.config.name) {
                  serverCardModel.setCurrent(true);
                }
              }
              return MyFlipAnimation(
                front: ServerOverviewCard(
                  index: widget.index,
                  aria2: widget.aria2,
                  client: widget.client,
                ),
                back: ServerGlobalStatus(
                    aria2: widget.aria2, client: widget.client),
                onTap: () {},
                beforeForward: () {
                  serverCardModel.setKeepNetWorking(true);
                },
                beforeReverse: () {
                  serverCardModel.setKeepNetWorking(false);
                  checkServerAvailable();
                },
              );
            }));
  }

  void checkServerAvailable() {
    serverCardModel.setTesting(true);
    widget.client.connect().then((value) {
      var available = false;
      if (value != false) {
        available = true;
      }
      serverCardModel.setTesting(false);
      serverCardModel.setAvailable(available);
    });
  }

  void openPopupMenu(BuildContext context) {
    final RenderBox card = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        card.localToGlobal(Offset(card.size.width - 20, card.size.height - 20),
            ancestor: overlay),
        card.localToGlobal(card.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(context: context, position: position, items: [
      const PopupMenuItem(
        value: 1,
        child: Text('添加服务器'),
      ),
      const PopupMenuItem(
        value: 2,
        child: Text('设置'),
      ),
      const PopupMenuItem(
        value: 3,
        child: Text('关于'),
      ),
    ]);
  }
}

class ServerCardModel extends ChangeNotifier {
  bool isAvailable = false;
  bool isTesting = false;
  bool isCurrent = false;
  bool keepNetWorking = false;

  Aria2GlobalStatus globalStatus = Aria2GlobalStatus(
      downloadSpeed: 0,
      uploadSpeed: 1345464560,
      numActive: 0,
      numWaiting: 0,
      numStopped: 0,
      numStoppedTotal: 0);

  setAvailable(bool available) {
    isAvailable = available;
    notifyListeners();
  }

  setTesting(bool testing) {
    isTesting = testing;
    notifyListeners();
  }

  setCurrent(bool current) {
    isCurrent = current;
    notifyListeners();
  }

  setKeepNetWorking(bool keepNetWorking) {
    keepNetWorking = keepNetWorking;
    notifyListeners();
  }

  updateGlobalStatus(Aria2GlobalStatus info) {
    globalStatus = info;
    notifyListeners();
  }
}
