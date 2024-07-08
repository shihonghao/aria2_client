import 'package:aria2_client/model/task.dart';
import 'package:flutter/material.dart';

class TaskOverviewCard extends StatefulWidget {
  TaskOverviewCard({super.key, required this.task});

  Task task;

  @override
  State<StatefulWidget> createState() {
    return _TaskOverviewCardState();
  }
}

class _TaskOverviewCardState extends State<TaskOverviewCard> {
  VoidCallback cb = () {};
  List<Widget> options = List.empty(growable: true);

  @override
  void initState() {
    initOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: openDetailPopup(),
        child: Card(
      color: Colors.white,
      // shape:const BeveledRectangleBorder(),
      margin: const EdgeInsets.all(10.0),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: const BorderSide(width: 1.0, color: Colors.black)),
      elevation: 8.0,
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(widget.task.taskName!))),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: options,
                    ),
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TweenAnimationBuilder(
                            builder: (ctx, value, cd) {
                              return LinearProgressIndicator(
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation(
                                    widget.task.status == TaskStatus.active
                                        ? Colors.blue
                                        : Colors.amber),
                                value: widget.task.totalLength == null
                                    ? 0.0
                                    : value / widget.task.totalLength!,
                              );
                            },
                            tween: IntTween(
                                begin: widget.task.lastCompletedLength,
                                end: widget.task.completedLength),
                            duration: const Duration(seconds: 1),
                          ))),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                size: 20,
                                Icons.equalizer,
                                color: Colors.grey,
                              ),
                              Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(
                                    "${widget.task.formatBytes(widget.task.completedLength)} / ${widget.task.formatBytes(widget.task.totalLength)}",
                                    style: const TextStyle(color: Colors.grey),
                                  )),
                              SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: TweenAnimationBuilder(
                                      builder: (ctx, value, cd) {
                                        return CircularProgressIndicator(
                                          backgroundColor: const Color.fromRGBO(
                                              84, 84, 84, 1.0),
                                          strokeWidth: 3,
                                          valueColor: AlwaysStoppedAnimation(
                                              widget.task.status ==
                                                      TaskStatus.active
                                                  ? Colors.blue
                                                  : Colors.amber),
                                          value: widget.task.totalLength == null
                                              ? 0.0
                                              : value /
                                                  widget.task.totalLength!,
                                        );
                                      },
                                      tween: IntTween(
                                          begin:
                                              widget.task.lastCompletedLength,
                                          end: widget.task.completedLength),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(widget.task.computedPercentage(),
                                    style: const TextStyle(color: Colors.grey)),
                              )
                            ])),
                  ),
                  widget.task.status == TaskStatus.active
                      ? Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      size: 20,
                                      Icons.arrow_upward_outlined,
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                          "${widget.task.formatBytes(widget.task.uploadSpeed)}/s",
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                    const Icon(
                                      size: 20,
                                      Icons.arrow_downward_outlined,
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                          "${widget.task.formatBytes(widget.task.downloadSpeed)}/s",
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                    const Icon(
                                      size: 20,
                                      Icons.schedule,
                                      color: Colors.grey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(widget.task.getRemainTime(),
                                          style: const TextStyle(
                                              color: Colors.grey)),
                                    ),
                                  ])))
                      : const SizedBox(width: 0, height: 0),
                ],
              )
            ],
          )
          // }),
          ),
    ));
  }

  void initOptions() {
    switch (widget.task.status) {
      case TaskStatus.waiting:
      case TaskStatus.active:
        options.add(IconButton(
            tooltip: "暂停",
            iconSize: 20,
            icon: const Icon(Icons.pause),
            onPressed: cb));
        break;
      case TaskStatus.paused:
        options.add(IconButton(
            tooltip: "开始",
            iconSize: 20,
            icon: const Icon(Icons.play_arrow),
            onPressed: cb));
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
        onPressed: cb));
    options.add(IconButton(
        tooltip: "详情",
        iconSize: 20,
        icon: const Icon(Icons.info_outline),
        onPressed: cb));
  }

  openDetailPopup() {

  }
}
