import 'package:aria2_client/model/task.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/task_model.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/timer/my_timer.dart';
import 'package:aria2_client/timer/my_timer_state.dart';
import 'package:aria2_client/ui/component/form/my_form.dart';
import 'package:aria2_client/ui/pages/download/detail/piece_bar.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:flutter/material.dart';

class BtInfo extends StatefulWidget {
  final TaskModel taskModel;

  const BtInfo({super.key, required this.taskModel});

  @override
  State<StatefulWidget> createState() {
    return _BtInfoState();
  }
}

class _BtInfoState extends MyTimerState<BtInfo> {
  late Task task;
  late List<Peer> peers;

  @override
  void initState() {
    debugPrint("initState");
    peers = [];
    super.initState();
  }

  @override
  void onResume() {
    debugPrint("onResume");
    super.onResume();
  }

  @override
  void onPause() {}

  @override
  void dispose() {
    debugPrint("dispose");
    startTimer();
    super.dispose();
  }

  @override
  MyTimer initTimer() {
    return MyTimer(
        duration: Duration(
            seconds: IHive.settings
                .get(SettingsHiveKey.taskRefreshInterval, defaultValue: 1)),
        onTime: (timer, _) async {
          return Aria2RpcClient.instance.getPeers(task.gid).then((result) {
            if (result.success) {
              List<Peer> newList = List.empty(growable: true);
              for (var peerJson in (result.data as List<dynamic>)) {
                newList.add(Peer.fromJson(peerJson));
              }
              peers.clear();
              peers.addAll(newList);
              peers.add(Peer(
                ip: "本机",
                seeder: false,
                downloadSpeed: task.downloadSpeed,
                uploadSpeed: task.uploadSpeed,
                bitfield: task.bitfield,
              ));
              setState(() {});
            }
            return result.success;
          });
        },
        onError: () {
          Util.showErrorToast("Can not connect to server !!");
        });
  }

  @override
  Widget build(BuildContext context) {
    task = widget.taskModel.task;
    return Card(
      margin: EdgeInsets.zero,
      color: Theme.of(context).highlightColor,
      child: SingleChildScrollView(
        child: MyForm(
          groups: [
            FormGroup(
              style: FormGroupStyle(
                backgroundColor: Theme.of(context).splashColor,
                collapsedBackgroundColor: Theme.of(context).highlightColor,
                textColor: Theme.of(context).primaryColor,
                elevation: 3,
              ),
              title: "BT服务器列表",
              items: task.bittorrent == null
                  ? []
                  : task.bittorrent!.announceList!
                      .map((e) => FormItem<String>(
                          readOnly: true,
                          key: 'Bittorrent',
                          label: '',
                          type: FormItemType.input,
                          leadingBuilder: (context) => Container(),
                          alignment: Alignment.centerLeft,
                          value: e[0]))
                      .toList(),
            ),
            FormGroup(
              showDivider: false,
              style: FormGroupStyle(
                backgroundColor: Theme.of(context).splashColor,
                collapsedBackgroundColor: Theme.of(context).highlightColor,
                textColor: Theme.of(context).primaryColor,
                elevation: 3,
              ),
              title: "连接信息",
              items: peers
                  .map((e) => FormItem<String>(
                      readOnly: true,
                      key: 'Bittorrent',
                      label: '',
                      type: FormItemType.input,
                      leadingBuilder: (context) => Container(),
                      contentBuilder: (context) {
                        return Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(child: Text(e.ip ?? "")),
                                    Text(e.client ?? "未知客户端"),
                                    Icon(Icons.keyboard_double_arrow_up,
                                        color: e.seeder!
                                            ? Theme.of(context).indicatorColor
                                            : null),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height: 20,
                                        child: PieceBar(
                                            bitfield: e.bitfield ?? "f",
                                            numPieces: widget
                                                    .taskModel.task.numPieces ??
                                                1,
                                            activeColor: Theme.of(context)
                                                .indicatorColor,
                                            inactiveColor:
                                                Theme.of(context).splashColor)),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(calcPeerPercent(e.bitfield)),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.arrow_upward,
                                          color:
                                              Theme.of(context).indicatorColor,
                                        ),
                                        Text(widget.taskModel.task
                                            .formatBytes(e.uploadSpeed)),
                                        Icon(
                                          Icons.arrow_downward,
                                          color:
                                              Theme.of(context).indicatorColor,
                                        ),
                                        Text(widget.taskModel.task
                                            .formatBytes(e.downloadSpeed)),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      alignment: Alignment.centerLeft,
                      value: ''))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  String calcPeerPercent(String? bitfield) {
    if (bitfield == null) {
      return "0%";
    }
    int count = 0;
    for (int i = 0; i < bitfield.length; i++) {
      int bitSet = int.parse(bitfield[i], radix: 16);

      for (int j = 1; j <= 4; j++) {
        int bit = 1 << (4 - j);
        bool isCompleted = (bitSet & bit) == bit;

        count += isCompleted ? 1 : 0;
      }
    }
    return "${(count / bitfield.length * 100).toStringAsFixed(2)}%";
  }
}
