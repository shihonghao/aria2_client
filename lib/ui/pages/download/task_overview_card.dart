import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/model/task.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/task_model.dart';
import 'package:aria2_client/ui/pages/download/detail/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../util/Util.dart';

class TaskOverviewCard extends StatefulWidget {
  const TaskOverviewCard(
      {super.key, required this.height, this.onSelected, required this.status});

  final double height;
  final TaskStatus status;
  final void Function(bool selected)? onSelected;

  @override
  State<StatefulWidget> createState() {
    return _TaskOverviewCardState();
  }
}

class _TaskOverviewCardState extends State<TaskOverviewCard> {
  VoidCallback cb = () {};
  List<Widget> options = List.empty(growable: true);
  late double padding;
  late bool isSelected;
  late Task task;
  BoxBorder? border;
  late VoidCallback action;
  late TaskModel model;
  Widget? _detailWidget;
  Widget? _overviewWidget;

  @override
  void initState() {
    padding = 0;
    isSelected = false;
    initOptions();
    model = context.read<TaskModel>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(blurRadius: isSelected ? 10 : 0)]),
      height: widget.height,
      padding: EdgeInsets.all(padding),
      duration: Const.duration300ms,
      child: Stack(
        children: [
          Card(
              margin: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              // elevation: 8.0,
              child: Selector<TaskModel, Task>(
                shouldRebuild: (oldVal, newVal) => newVal.isChanged(),
                builder: (BuildContext context, Task task, Widget? child) {
                  this.task = task;
                  return OpenContainer(
                    closedBuilder:
                        (BuildContext context, void Function() action) {
                      this.action = action;
                      return buildOverview();
                    },
                    openBuilder: (BuildContext context,
                        void Function({Object? returnValue}) action) {
                      return buildDetail();
                    },
                    closedColor: Theme.of(context).cardColor,
                    openColor: Theme.of(context).cardColor,
                    // transitionType: ContainerTransitionType.fadeThrough,
                    transitionDuration: Const.duration1s,
                    tappable: false,
                  );
                },
                selector: (context, model) => model.task,
              )),
        ],
      ),
    );
  }

  void initOptions() {
    switch (widget.status) {
      case TaskStatus.waiting:
      case TaskStatus.active:
        options.add(IconButton(
            tooltip: "暂停",
            iconSize: 20,
            icon: const Icon(Icons.pause),
            onPressed: () {
              Aria2RpcClient.instance.pauseTask(task.gid);
            }));
        break;
      case TaskStatus.paused:
        options.add(IconButton(
            tooltip: "开始",
            iconSize: 20,
            icon: const Icon(Icons.play_arrow),
            onPressed: () {
              Aria2RpcClient.instance.unpauseTask(task.gid);
            }));
        break;
      case TaskStatus.error:
      case TaskStatus.complete:
      case TaskStatus.removed:
        options.add(IconButton(
            tooltip: "重新下载",
            iconSize: 20,
            icon: const Icon(Icons.restart_alt),
            onPressed: cb));
    }

    options.add(IconButton(
        tooltip: "复制链接",
        iconSize: 20,
        icon: const Icon(Icons.link),
        onPressed: () {
          String? uri = context.read<TaskModel>().task.getUri();
          if (uri == null) {
            Util.showErrorToast("无法获取下载链接");
          } else {
            Clipboard.setData(ClipboardData(text: uri));
          }
        }));
    options.add(IconButton(
        tooltip: "移除",
        iconSize: 20,
        icon: const Icon(Icons.delete),
        onPressed: () {
          Aria2RpcClient.instance.removeTask(task.gid);
        }));
  }

  Widget buildOverview() {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: InkWell(
            onTap: () {
              isSelected = !isSelected;
              widget.onSelected?.call(isSelected);
              setState(() {});
            },
            onDoubleTap: () {
              action.call();
            },
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Hero(
                              tag: "test",
                              child: Text(
                                task.taskName ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 25),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: options,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        size: 20,
                                        Icons.arrow_upward_outlined,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                            "${task.formatBytes(task.uploadSpeed)}/s",
                                            style: const TextStyle(
                                                color: Colors.grey)),
                                      ),
                                      Icon(
                                        size: 20,
                                        Icons.arrow_downward_outlined,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                            "${task.formatBytes(task.downloadSpeed)}/s",
                                            style: const TextStyle(
                                                color: Colors.grey)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        size: 20,
                                        Icons.equalizer,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            "${task.formatBytes(task.completedLength)} / ${task.formatBytes(task.totalLength)}",
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          )),
                                    ],
                                  )
                                ],
                              )
                            ])),
                    Row(
                      children: [
                        Expanded(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: TweenAnimationBuilder(
                                  builder: (ctx, value, cd) {
                                    return LinearProgressIndicator(
                                      minHeight: 10,
                                      borderRadius: BorderRadius.circular(50),
                                      backgroundColor: Colors.grey,
                                      valueColor: AlwaysStoppedAnimation(
                                          task.status == TaskStatus.active
                                              ? Colors.blue
                                              : Colors.amber),
                                      value: task.totalLength == null ||
                                              task.totalLength == 0
                                          ? 0.0
                                          : task.completedLength! /
                                              task.totalLength!,
                                    );
                                  },
                                  tween: IntTween(
                                      begin: task.lastCompletedLength,
                                      end: task.completedLength),
                                  duration: Const.duration1s,
                                ))),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: task.status != TaskStatus.active
                                          ? TweenAnimationBuilder(
                                              builder: (ctx, value, cd) {
                                                return CircularProgressIndicator(
                                                  backgroundColor:
                                                      const Color.fromRGBO(
                                                          84, 84, 84, 1.0),
                                                  strokeWidth: 3,
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          task.status ==
                                                                  TaskStatus
                                                                      .active
                                                              ? Colors.blue
                                                              : Colors.amber),
                                                  value: task.totalLength ==
                                                              null ||
                                                          task.totalLength == 0
                                                      ? 0.0
                                                      : value /
                                                          task.totalLength!,
                                                );
                                              },
                                              tween: IntTween(
                                                  begin:
                                                      task.lastCompletedLength,
                                                  end: task.completedLength),
                                              duration: Const.duration1s,
                                            )
                                          : CircularProgressIndicator(
                                              backgroundColor:
                                                  const Color.fromRGBO(
                                                      84, 84, 84, 1.0),
                                              strokeWidth: 3,
                                              valueColor:
                                                  AlwaysStoppedAnimation(
                                                      task.status ==
                                                              TaskStatus.active
                                                          ? Colors.blue
                                                          : Colors.amber),
                                            ),
                                    )),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(task.computedPercentage(),
                                      style:
                                          const TextStyle(color: Colors.grey)),
                                )
                              ]),
                          task.status == TaskStatus.active
                              ? Expanded(
                                  child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                      Icon(
                                        size: 20,
                                        Icons.schedule,
                                        color: Theme.of(context).indicatorColor,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(task.getRemainTime(),
                                            style: const TextStyle(
                                                color: Colors.grey)),
                                      ),
                                    ]))
                              : const SizedBox(width: 0, height: 0),
                        ],
                      ),
                    )
                  ],
                )
                // }),
                )),
      ),
    );
  }

  Widget buildDetail() {
    return TaskDetailCard(model: context.read<TaskModel>());
  }
}
