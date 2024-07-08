import 'package:aria2_client/model/task.dart';
import 'package:aria2_client/providers/aria2_model.dart';
import 'package:aria2_client/ui/component/expandable_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'task_list_view.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DownloadPageState();
  }
}

class _DownloadPageState extends State<DownloadPage> {
  static const _actionTitles = ['Create Post', 'Upload Photo', 'Upload Video'];

  void _showAction(BuildContext context, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(_actionTitles[index]),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('CLOSE'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ExpandableFab(
          distance: 112,
          children: [
            ActionButton(
              onPressed: () => _showAction(context, 0),
              icon: const Icon(Icons.add),
            ),
            ActionButton(
              onPressed: () => _showAction(context, 1),
              icon: const Icon(Icons.play_arrow),
            ),
            ActionButton(
              onPressed: () => _showAction(context, 2),
              icon: const Icon(Icons.stop),
            ),
            ActionButton(
              onPressed: () => _showAction(context, 2),
              icon: const Icon(Icons.remove),
            ),
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
        body: DefaultTabController(
            length: 5,
            child: Scaffold(
                appBar: TabBar(
                    // 多个标签时滚动加载
                    tabAlignment: TabAlignment.center,
                    isScrollable: true,
                    // 标签指示器的颜色
                    indicatorColor: Colors.blue,
                    // 标签的颜色
                    labelColor: Colors.blue,
                    // 未选中标签的颜色
                    unselectedLabelColor: Colors.black,
                    // 指示器的大小
                    indicatorSize: TabBarIndicatorSize.label,
                    // 指示器的权重，即线条高度
                    indicatorWeight: 4.0,
                    onTap: (index) {
                      changeTaskSubscribe(context, index);
                    },
                    tabs: const [
                      Tab(text: "进行中"),
                      Tab(text: "等待中"),
                      Tab(text: "已暂停"),
                      Tab(text: "已完成"),
                      Tab(text: "错误"),
                      // Tab(text: "已删除"),
                    ]),
                // 标签页所对应的页面
                body: TabBarView(children: [
                  TaskListView(
                    status: TaskStatus.active,
                  ),
                  TaskListView(
                    status: TaskStatus.waiting,
                  ),
                  TaskListView(
                    status: TaskStatus.paused,
                  ),
                  TaskListView(
                    status: TaskStatus.complete,
                  ),
                  TaskListView(
                    status: TaskStatus.error,
                  ),
                  // TaskPage(
                  //   status: TaskStatus.removed,
                  // ),
                ]))));
  }

  void changeTaskSubscribe(BuildContext context, int index) {
    TaskStatus taskStatus = TaskStatus.active;
    switch (index) {
      case 0:
        taskStatus = TaskStatus.active;
        break;
      case 1:
        taskStatus = TaskStatus.waiting;
        break;
      case 2:
        taskStatus = TaskStatus.paused;
        break;
      case 3:
        taskStatus = TaskStatus.complete;
        break;
      case 4:
        taskStatus = TaskStatus.error;
        break;
      case 5:
        taskStatus = TaskStatus.removed;
    }
    context.read<Aria2Model>().startTaskTimer(taskStatus);
  }
}
