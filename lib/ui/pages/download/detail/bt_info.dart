import 'package:aria2_client/generated/l10n.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    peers = [];
    super.initState();
  }

  @override
  void onResume() {
    super.onResume();
  }

  @override
  void onPause() {}

  @override
  void dispose() {
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
              peers = newList;
              peers.add(Peer(
                ip: S.of(context).local,
                seeder: false,
                downloadSpeed: task.uploadSpeed,
                uploadSpeed: task.downloadSpeed,
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
    return  SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all( 10.h),
    child: MyForm(
          groups: [
            FormGroup(
              style: FormGroupStyle(
                backgroundColor: Theme.of(context).cardColor,
                collapsedBackgroundColor: Theme.of(context).primaryColor,
                elevation: 3,
              ),
              title: S.of(context).bt_tracker_servers,
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
                backgroundColor: Theme.of(context).cardColor,
                collapsedBackgroundColor: Theme.of(context).primaryColor,
                elevation: 3,
              ),
              title: S.of(context).connection_info,
              items: buildPeersItem(),
            ),
          ],
        )),
    );
  }

  String calcPeerPercent(String? bitfield, int? numPieces) {
    if (bitfield == null  || numPieces == null || numPieces == 0) {
      return "0%";
    }
    int count = 0;
    int pieceIndex = 0;

    for (int i = 0; i < bitfield.length; i++) {
      int bitSet = int.parse(bitfield[i], radix: 16);

      for (int j = 1; j <= 4; j++) {
        int bit = 1 << (4 - j);
        bool isCompleted = (bitSet & bit) == bit;
        count += isCompleted ? 1 : 0;
        pieceIndex++;
        if (pieceIndex >= numPieces) {
          return "${(count / numPieces * 100).toStringAsFixed(2)}%";
        }
      }
    }
    return "${(count / numPieces * 100).toStringAsFixed(2)}%";
  }

  buildPeersItem() {
    List<FormItem> items = [];
    for (var peer in peers) {
      final ip = peer.ip ?? "";
      final client = peer.client ?? S.of(context).unKnown;
      final seeder = peer.seeder ?? false;
      final bitfield = peer.bitfield ?? "f";
      final uploadSpeed = peer.uploadSpeed;
      final downloadSpeed = peer.downloadSpeed;
      items.add(FormItem<Peer>(
        readOnly: true,
        key: 'Bittorrent',
        label: '',
        value: peer,
        type: FormItemType.input,
        leadingBuilder: (context) => Container(),
        contentBuilder: (context) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Text(ip)),
                      Text(client),
                      Icon(Icons.keyboard_double_arrow_up,
                          color:
                              seeder ? Theme.of(context).indicatorColor : null),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 20,
                          child: PieceBar(
                              bitfield: bitfield,
                              numPieces: widget.taskModel.task.numPieces ?? 1,
                              activeColor: Theme.of(context).indicatorColor,
                              inactiveColor: Theme.of(context).splashColor)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(calcPeerPercent(
                          bitfield, widget.taskModel.task.numPieces)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: Theme.of(context).indicatorColor,
                          ),
                          Text(widget.taskModel.task.formatBytes(downloadSpeed)),
                          Icon(
                            Icons.arrow_downward,
                            color: Theme.of(context).indicatorColor,
                          ),
                          Text(
                              widget.taskModel.task.formatBytes(uploadSpeed)),
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
      ));
    }
    return items;
  }
}

