import 'dart:async';
import 'dart:developer' as developer;
import 'package:aria2_client/model/task.dart';
import 'package:flutter/material.dart';
import 'package:aria2_client/ui/expandable_fab.dart';
import 'package:aria2_client/ui/task_card.dart';

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
                appBar: const TabBar(
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
                    tabs: [
                      Tab(text: "进行中"),
                      Tab(text: "等待中"),
                      Tab(text: "已暂停"),
                      Tab(text: "已完成"),
                      Tab(text: "错误/移除")
                    ]),
                // 标签页所对应的页面
                body: TabBarView(children: [
                  TaskPage(
                    status: const [TaskStatus.active],
                  ),
                  TaskPage(
                    status: const [TaskStatus.waiting],
                  ),
                  TaskPage(
                    status: const [TaskStatus.paused],
                  ),
                  TaskPage(
                    status: const [TaskStatus.complete],
                  ),
                  TaskPage(
                    status: const [TaskStatus.error, TaskStatus.removed],
                  ),
                ]))));
  }
}
