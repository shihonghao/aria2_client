import 'package:aria2_client/model/task.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/task_model.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/timer/my_timer.dart';
import 'package:aria2_client/timer/my_timer_state.dart';
import 'package:aria2_client/ui/pages/download/detail/basic_info.dart';
import 'package:aria2_client/ui/pages/download/detail/bt_info.dart';
import 'package:aria2_client/ui/pages/download/detail/file_list.dart';
import 'package:aria2_client/ui/pages/download/detail/pieces_info.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class TaskDetailCard extends StatefulWidget {
  final TaskModel model;

  const TaskDetailCard({super.key, required this.model});

  @override
  State<StatefulWidget> createState() {
    return _TaskDetailCardState();
  }
}

class _TaskDetailCardState extends MyTimerState<TaskDetailCard> {
  late String title;
  late bool isBt;
  late ValueNotifier<Piece> piece;
  MyTimer? peerTimer;

  @override
  MyTimer initTimer() {
    return MyTimer(
        duration: Duration(
            seconds: IHive.settings
                .get(SettingsHiveKey.taskRefreshInterval, defaultValue: 1)),
        onTime: (timer, _) async {
          return Aria2RpcClient.instance
              .tellStatus(widget.model.task.gid)
              .then((result) {
            if (result.success) {
              widget.model.update(Task.fromJson(result.data));
            }
            return result.success;
          });
        },
        onError: () {
          Util.showErrorToast("Can not connect to server !!");
        });
  }

  @override
  void onResume() {
    Aria2RpcClient.instance.tellStatus(widget.model.task.gid).then((result) {
      if (result.success) {
        widget.model.update(Task.fromJson(result.data));
        isBt = widget.model.task.isBitTorrent();
        startTimer();
      } else {
        Util.showErrorToast("Can not connect to server !!");
      }
    });
  }

  @override
  void initState() {
    super.initState();
    title = "详情";
    piece = ValueNotifier(Piece(numPieces: 0, bitfield: ""));
    isBt = false;
  }

  @override
  void dispose() {
    peerTimer?.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Swiper.children(
          onIndexChanged: (index) {
            title = getTitle(index);
            setState(() {});
          },
          pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                  activeColor: Theme.of(context).indicatorColor)),
          children: [
            BasicInfo(taskModel: widget.model),
            FileList(taskModel: widget.model),
            PiecesInfo(
              piece: widget.model.piece,
            ),
            if (isBt) BtInfo(taskModel: widget.model)
          ],
        ));
  }

  String getTitle(int index) {
    switch (index) {
      case 1:
        return "文件列表";
      case 2:
        return "分块信息";
      case 3:
        return "种子信息";
      default:
        return "详情";
    }
  }
}
