import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/task.dart';

class TaskDetailCard extends StatefulWidget {
  TaskDetailCard({super.key, required this.task});

  Task task;

  @override
  State<StatefulWidget> createState() {
    return _TaskDetailCardState();
  }
}

class _TaskDetailCardState extends State<TaskDetailCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}


class TaskDetailDrawer extends StatelessWidget{

  const TaskDetailDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    return const Drawer(
        elevation: 16.0,
        child:  Text("TaskDetailDrawer"));
  }
}