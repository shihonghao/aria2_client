import 'package:aria2_client/ui/component/task_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/task.dart';
import '../../providers/aria2_model.dart';

class TaskListView extends StatefulWidget {
  // List<TaskStatus> status;
  TaskStatus status;

  TaskListView({super.key, required this.status});

  late List<Task> taskList;

  @override
  State<StatefulWidget> createState() {
    return _TaskListViewState();
  }
}

class _TaskListViewState extends State<TaskListView> {
  @override
  void dispose() {
    debugPrint("移除${widget.status}任务监听");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<Aria2Model, String?>(
        selector: (context, model) => model.current?.config.name,
        shouldRebuild: (oldVal, newVal) {
          debugPrint("$oldVal - $newVal");
          return oldVal != newVal;
        },
        builder: (BuildContext context, String? value, Widget? child) {
          context
              .read<Aria2Model>()
              .startTaskTimer(widget.status)
              .then((value) {
            debugPrint("开启${widget.status}任务监听:${value.toString()}");
          });
          return Scaffold(
              body: Selector<Aria2Model, int>(
                  selector: (context, model) =>
                      model.getTaskList(widget.status).length,
                  shouldRebuild: (oldVal, newVal) =>
                      widget.status == TaskStatus.active
                          ? true
                          : oldVal != newVal,
                  builder: (BuildContext context, int value, Widget? child) {
                    List<Task> tasks =
                        context.read<Aria2Model>().getTaskList(widget.status);
                    return ListView.builder(
                        itemExtent: 140,
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return TaskOverviewCard(task: tasks[index]);
                        });
                  }));
        });
  }
}
