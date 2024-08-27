import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/task_model.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/timer/my_timer.dart';
import 'package:aria2_client/timer/my_timer_state.dart';
import 'package:aria2_client/ui/pages/download/task_overview_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/task.dart';
import '../../../providers/aria2_model.dart';
import '../../../util/Util.dart';

class TaskListView extends StatefulWidget {
  TaskStatus status;

  TaskListView({super.key, required this.status});

  @override
  State<StatefulWidget> createState() {
    return _TaskListViewState();
  }
}

class _TaskListViewState extends MyTimerState<TaskListView> {
  late final GlobalKey<AnimatedListState> _listKey;
  late List<TaskModel> _models;

  @override
  void initState() {
    super.initState();
    _listKey = GlobalKey<AnimatedListState>();
    _models = [];
  }

  @override
  void onResume() {
    if (Aria2Model.instance.currentServer != null) {
      Aria2RpcClient.instance.tell(widget.status).then((result) {
        if (result.success) {
          List<TaskModel> newModels = [];
          result.data.forEach((element) {
            newModels.add(TaskModel(task: element));
          });
          updateModels(newModels);
          startTimer();
        } else {
          Util.showErrorToast("Can not connect to server !!");
        }
      });
    }
  }

  @override
  MyTimer initTimer() {
    return MyTimer(
        duration: Duration(
            seconds: IHive.settings
                .get(SettingsHiveKey.taskRefreshInterval, defaultValue: 1)),
        onTime: (timer, _) async {
          return Aria2RpcClient.instance.tell(widget.status).then((result) {
            if (result.success) {
              List<TaskModel> newModels = [];
              result.data.forEach((element) {
                newModels.add(TaskModel(task: element));
              });
              updateModels(newModels);
            }
            return result.success;
          });
        },
        onError: () {
          Util.showErrorToast("Can not connect to server !!");
        });
  }

  void updateModels(List<TaskModel> newModels) {
    Util.compareListAndFetch(_models, newModels,
        compare: (o1, o2) => o1.task.gid == o2.task.gid,
        onRemove: (list,removedItem) {
          final removedIndex = _models.indexOf(removedItem);
          _listKey.currentState!.removeItem(removedIndex, (context, animation) {
            final item = buildItem(context, removedIndex, animation);
            list.remove(removedItem);
            return item;
          }, duration: const Duration(milliseconds: 500));
        },
        fetch: (o1, o2) {
          o1.update(o2.task);
        },
        onInsert: (list,item) {
          list.add(item);
          _listKey.currentState!.insertItem(_models.length - 1,
              duration: const Duration(milliseconds: 500));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<Aria2Model, String?>(
        selector: (context, model) => model.currentServer?.aria2.config.name,
        shouldRebuild: (oldVal, newVal) {
          return oldVal != newVal;
        },
        builder: (BuildContext context, String? value, Widget? child) {
          return Scaffold(
              body: AnimatedList(
            key: _listKey,
            itemBuilder: buildItem,
            initialItemCount: _models.length,
          ));
        });
  }

  Widget buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return SlideTransition(
        position: animation.drive(CurveTween(curve: Curves.easeOutBack)).drive(
            Tween<Offset>(begin: const Offset(1, 0), end: const Offset(0, 0))),
        child: ChangeNotifierProvider.value(
          value: _models[index],
          child: TaskOverviewCard(
            status: widget.status,
            height: 140,
            onSelected: (selected) {
              _models[index].isSelected = selected;
            },
          ),
        ));
  }
}
