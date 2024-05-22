import 'dart:async';
import 'dart:js_interop';
import 'package:aria2_client/model/Aria2Context.dart';
import 'dart:developer' as developer;
import 'package:aria2_client/model/task.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  TaskCard({super.key, required this.taskNotifier}) : task = taskNotifier.value;

  TaskNotifier taskNotifier;

  Task task;

  @override
  State<StatefulWidget> createState() {
    return _TaskCardState();
  }
}

class _TaskCardState extends State<TaskCard> {
  VoidCallback cb = () {};

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
                const Expanded(
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text("xxx.ISO"))),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              tooltip: "开始",
                              iconSize: 20,
                              icon: const Icon(Icons.play_arrow),
                              onPressed: () {}),
                          IconButton(
                              tooltip: "重新下载",
                              iconSize: 20,
                              icon: const Icon(Icons.restart_alt),
                              onPressed: cb),
                          IconButton(
                              tooltip: "复制链接",
                              iconSize: 20,
                              icon: const Icon(Icons.link),
                              onPressed: cb),
                          IconButton(
                              tooltip: "详情",
                              iconSize: 20,
                              icon: const Icon(Icons.info_outline),
                              onPressed: cb),
                        ],
                      ),
                    )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ValueListenableBuilder<Task>(
                            valueListenable: widget.taskNotifier,
                            builder: (context, task, child) {
                              return TweenAnimationBuilder(
                                builder: (ctx, value, cd) {
                                  return LinearProgressIndicator(
                                    backgroundColor: Colors.grey,
                                    valueColor: AlwaysStoppedAnimation(
                                        task.status == TaskStatus.active
                                            ? Colors.blue
                                            : Colors.amber),
                                    value: value / task.totalLength,
                                  );
                                },
                                tween: IntTween(
                                    begin: task.lastCompletedLength,
                                    end: task.completedLength),
                                duration: const Duration(seconds: 1),
                              );
                            }))),
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
                                  "${widget.task.formatBytes(
                                      widget.task.completedLength)}/${widget
                                      .task.formatBytes(
                                      widget.task.totalLength)}",
                                  style: const TextStyle(color: Colors.grey),
                                )),
                            SizedBox(
                                width: 20,
                                height: 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),

                                  child: ValueListenableBuilder<Task>(
                                      valueListenable: widget.taskNotifier,
                                      builder: (context, task, child) {
                                        return TweenAnimationBuilder(
                                          builder: (ctx, value, cd) {
                                            return CircularProgressIndicator(
                                              backgroundColor: Colors.white,
                                              strokeWidth: 3,
                                              valueColor:
                                              AlwaysStoppedAnimation(
                                                  task.status ==
                                                      TaskStatus.active
                                                      ? Colors.blue
                                                      : Colors.amber),
                                              value: value / task.totalLength,
                                            );
                                          },
                                          tween: IntTween(
                                              begin: task.lastCompletedLength,
                                              end: task.completedLength),
                                          duration: const Duration(seconds: 1),
                                        );
                                      }),
                                  // child: CircularProgressIndicator(
                                  //   strokeWidth: 3,
                                  //   backgroundColor: Colors.white,
                                  //   valueColor: const AlwaysStoppedAnimation(
                                  //       Colors.blue),
                                  //   value: widget.task.completedLength /
                                  //       widget.task.totalLength,
                                  // )
                                )),
                            ValueListenableBuilder<Task>(
                                valueListenable: widget.taskNotifier,
                                builder:  (context, task, child) {
                                  return Text(
                                      "${(task.completedLength /
                                          task.totalLength * 100)
                                          .toStringAsFixed(2)} %",
                                      style: const TextStyle(
                                          color: Colors.grey));
                                })
                          ])),
                ),
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                    "${widget.task.formatBytes(
                                        widget.task.uploadSpeed)}/s",
                                    style: const TextStyle(color: Colors.grey)),
                              ),
                              const Icon(
                                size: 20,
                                Icons.arrow_downward_outlined,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                    "${widget.task.formatBytes(
                                        widget.task.downloadSpeed)}/s",
                                    style: const TextStyle(color: Colors.grey)),
                              ),
                              const Icon(
                                size: 20,
                                Icons.schedule,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(widget.task.getRemainTime(),
                                    style: const TextStyle(color: Colors.grey)),
                              ),
                            ])))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TaskPage extends StatefulWidget {
  List<TaskStatus> status;

  TaskPage({super.key, required this.status});

  List<TaskNotifier> taskList = List.empty(growable: true);

  @override
  State<StatefulWidget> createState() {
    return _TaskPageState();
  }
}

class _TaskPageState extends State<TaskPage> {
  // 刷新任务列表
  @override
  void initState() {
    developer.log("init");
    super.initState();
    widget.taskList.add(TaskNotifier(Task(
        gid: "1",
        status: TaskStatus.active,
        totalLength: 1024,
        completedLength: 128,
        downloadSpeed: 10,
        uploadSpeed: 10,
        uploadLength: 10)));
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      widget.taskList.first.value.completedLength =
          widget.taskList.first.value.completedLength + 100;
      widget.taskList.first.update(widget.taskList.first.value);

      if (widget.taskList.first.value.completedLength >
          widget.taskList.first.value.totalLength) {
        widget.taskList.first.value.status = TaskStatus.complete;
      } else {}
    });
    // Timer.periodic(const Duration(milliseconds: 1), (timer) {
    //   Map taskMap = {for (var e in widget.taskList) e.value.gid: e};
    //   for (TaskStatus stat in widget.status) {
    //     for (Task val in Aria2Context.getInstance().currentAria2!.tell(stat)) {
    //       taskMap[val.gid].update(val);
    //       taskMap.remove(val.gid);
    //     }
    //   }
    //   widget.taskList
    //       .removeWhere((task) => taskMap.containsKey(task.value.gid));
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    developer.log("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemExtent: 140,
          itemCount: widget.taskList.length,
          itemBuilder: (context, index) {
            return TaskCard(taskNotifier: widget.taskList[index]);
          }),
    );
  }
}
