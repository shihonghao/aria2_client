import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/model/task.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/task_model.dart';
import 'package:aria2_client/ui/component/animation/my_animated_icon.dart';
import 'package:aria2_client/ui/component/form/my_form.dart';
import 'package:flutter/material.dart';

class FileList extends StatefulWidget {
  final TaskModel taskModel;

  const FileList({super.key, required this.taskModel});

  @override
  State<StatefulWidget> createState() {
    return _FileListState();
  }
}

class _FileListState extends State<FileList> {
  late Task task;

  @override
  void initState() {
    task = widget.taskModel.task;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: Theme.of(context).highlightColor,
      child: SingleChildScrollView(
        child: ListenableBuilder(
          listenable: widget.taskModel,
          builder: (context, child) {
            task = widget.taskModel.task;
            return MyForm(
              groups: [
                FormGroup(
                  expanded: true,
                  showDivider: false,
                  style: FormGroupStyle(
                    backgroundColor: Theme.of(context).splashColor,
                    collapsedBackgroundColor: Theme.of(context).highlightColor,
                    textColor: Theme.of(context).primaryColor,
                    elevation: 3,
                  ),
                  title: '文件列表',
                  items: task.files!
                      .map(
                        (e) => FormItem<String>(
                          readOnly: true,
                          key: 'fileName',
                          type: FormItemType.input,
                          value: '',
                          leadingBuilder: (context) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Text(Task.getFileName(e) ?? ""),
                              ),
                            );
                          },
                          contentBuilder: (context) {
                            return InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () {},
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    alignment: Alignment.centerRight,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(task.formatBytes(e.length)),
                                        const SizedBox(width: 10),
                                        Text(Task.computedFilePercentage(e)),
                                      ],
                                    )));
                          },
                          trailingBuilder: (task.status == TaskStatus.paused ||
                                  task.status == TaskStatus.active)
                              ? (context) => MyAnimatedIcon(
                                  auto: true,
                                  onTap: (controller) {
                                    if (task.status == TaskStatus.paused) {
                                      controller.forward();
                                      changeFileSelected(e);
                                    }
                                  },
                                  icon: !e.selected!
                                      ? Icons.check_box_outline_blank
                                      : Icons.check_box_outlined,
                                  duration: Const.duration300ms,
                                  color: e.selected! &&
                                          task.status == TaskStatus.paused
                                      ? Theme.of(context).indicatorColor
                                      : Theme.of(context).splashColor)
                              : null,
                        ),
                      )
                      .toList(),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void changeFileSelected(TaskFile file) {
    file.selected = !file.selected!;
    List<int> selected = [];
    for (var element in task.files!) {
      if (element.selected!) {
        selected.add(element.index!);
      }
    }
    Aria2RpcClient.instance.changeTaskOption(
        task.gid, {"select-file": selected.join(",")}).then((_) {
      setState(() {});
    });
  }
}
