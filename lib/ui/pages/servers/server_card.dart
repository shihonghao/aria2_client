import 'package:aria2_client/aria2/model/aria2_global_status.dart';
import 'package:aria2_client/event/base_event.dart';
import 'package:aria2_client/event/event_bus_manager.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/net/aria2_rpc_client_factory.dart';
import 'package:aria2_client/ui/pages/servers/server_global_status.dart';
import 'package:aria2_client/ui/pages/servers/server_overview_card.dart';
import 'package:aria2_client/ui/pages/servers/servers_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../aria2/model/aria2.dart';
import '../../../providers/aria2_model.dart';
import '../../../static/vars.dart';
import '../../../timer/my_timer.dart';
import '../../../util/Util.dart';
import '../../component/animation/my_flip_animation.dart';

class ServerCard extends StatefulWidget {
  ServerCard({super.key, required this.aria2})
      : client = Aria2RpcClientFactory.create(aria2.config);

  final Aria2 aria2;

  late Aria2RpcClient client;

  @override
  State<StatefulWidget> createState() {
    return _ServerCardState();
  }
}

class _ServerCardState extends State<ServerCard> with TickerProviderStateMixin {
  late MyTimer globalStatusTimer;

  late ServerModel serverCardModel;

  @override
  void initState() {
    initTimer();
    serverCardModel =
        ServerModel(aria2: widget.aria2, client: widget.client);
    EventBusManager.eventBus.on<ServerPageEvent>().listen((event) {
      if (serverCardModel.key == event.key || event.scope == EventScope.All) {
        switch (event.eventType) {
          case ServerPageEventType.START_MONITOR:
            globalStatusTimer.resume();
            serverCardModel.setMonitoring(true);
            break;
          case ServerPageEventType.CHECK_AVAILABLE_AND_START_MONITOR:
            checkServerAvailable().then((available) {
              if (available) {
                globalStatusTimer.resume();
                serverCardModel.setMonitoring(true);
              }
            });
            break;
          case ServerPageEventType.STOP_MONITOR:
            globalStatusTimer.pause();
            serverCardModel.setMonitoring(false);
            serverCardModel.resetGlobalStatus();
            break;
          case ServerPageEventType.CHECK_AVAILABLE:
            checkServerAvailable().then((value) {
              event.executeCallback();
            });
            break;
          default:
            break;
        }
      }
    });
    checkServerAvailable();
    super.initState();
  }

  void initTimer() {
    globalStatusTimer = MyTimer(
        duration: duration1s,
        onTime: (timer, value) async {
          return widget.client.getGlobalStatus().then((result) {
            if (result.success) {
              serverCardModel
                  .updateGlobalStatus(Aria2GlobalStatus.fromJson(result.data));
            }
            return result.success;
          });
        },
        onError: () {
          Util.showErrorToast(
              "Can not connect to Aria2 ${widget.aria2.config.uri.toString()}");
        });
  }

  @override
  void dispose() {
    globalStatusTimer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: serverCardModel,
        child: Selector<Aria2Model, bool>(
            selector: (context, model) =>
                model.current?.config.name == widget.aria2.config.name,
            builder: (context, isCurrent, child) {
              if (!isCurrent) {
                EventBusManager.eventBus.fire(ServerPageEvent(
                    key: serverCardModel.key,
                    eventType: ServerPageEventType.STOP_MONITOR));
              }
              serverCardModel.isCurrent = isCurrent;
              return MyFlipAnimation(
                front: const ServerOverviewCard(),
                back: const ServerGlobalStatus(),
                onTap: () {},
                beforeForward: () {
                  globalStatusTimer.resume();
                },
                beforeReverse: () {
                  globalStatusTimer.pause();
                  checkServerAvailable();
                },
              );
            }));
  }

  Future<bool> checkServerAvailable() async {
    serverCardModel.setTesting(true);
    await Future.delayed(const Duration(seconds: 1));
    var available = false;
    return await widget.client.connect().then((result) {
      if (result.success) {
        return true;
      }
      throw Exception();
    }).catchError((error) {
      Util.showErrorToast(
          "Can not connect to Aria2 ${widget.aria2.config.uri.toString()}");
      return false;
    }).then((isAvailable) {
      available = isAvailable;
      return available;
    }).whenComplete(() {
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

class ServerModel extends ChangeNotifier {
  final String key;
  bool isMonitoring = false;
  bool isAvailable = false;
  bool isTesting = false;
  bool isCurrent = false;
  bool keepNetWorking = false;
  Aria2 aria2;
  Aria2RpcClient client;
  bool shouldDispose = true;

  ServerModel({required this.aria2, required this.client})
      : key = Util.generateId("serverCard");

  Aria2GlobalStatus globalStatus = Aria2GlobalStatus(
      downloadSpeed: 0,
      uploadSpeed: 0,
      numActive: 0,
      numWaiting: 0,
      numStopped: 0,
      numStoppedTotal: 0);

  setAvailable(bool available) {
    isAvailable = available;
    if (isAvailable == false) {
      setMonitoring(false);
    }
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

  setMonitoring(bool monitoring) {
    isMonitoring = monitoring;
    notifyListeners();
  }

  updateGlobalStatus(Aria2GlobalStatus info) {
    globalStatus = info;
    notifyListeners();
  }

  void resetGlobalStatus() {
    globalStatus = Aria2GlobalStatus(
        downloadSpeed: 0,
        uploadSpeed: 0,
        numActive: 0,
        numWaiting: 0,
        numStopped: 0,
        numStoppedTotal: 0);
  }

  @override
  void dispose() {
    if (!shouldDispose) {
      shouldDispose = true;
      return;
    }
    super.dispose();
  }
}
