import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/model/task.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/task_model.dart';
import 'package:aria2_client/ui/component/animation/my_animated_icon.dart';
import 'package:aria2_client/ui/component/form/my_form.dart';
import 'package:aria2_client/ui/pages/servers/detail/detail_page.dart';
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
                  title: S.of(context).files,
                  items: task.files!
                      .map(
                        (e) => FormItem<String>(
                          readOnly: true,
                          key: 'fileName',
                          type: FormItemType.input,
                          value: '',
                          contentBuilder: (context) {
                            final progress = Task.computedFilePercentage(e);
                            return Expanded(
                                child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              Task.getFileName(e) ?? "",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        const VerticalDivider(color: Colors.transparent,),
                                        if (task.status == TaskStatus.paused ||
                                            task.status == TaskStatus.active)
                                          MyAnimatedIcon(
                                              auto: true,
                                              onTap: (controller) {
                                                if (task.status ==
                                                    TaskStatus.paused) {
                                                  controller.forward();
                                                  changeFileSelected(e);
                                                }
                                              },
                                              icon: !e.selected!
                                                  ? Icons
                                                      .check_box_outline_blank
                                                  : Icons.check_box_outlined,
                                              duration: Const.duration300ms,
                                              color: e.selected! &&
                                                      task.status ==
                                                          TaskStatus.paused
                                                  ? Theme.of(context)
                                                      .indicatorColor
                                                  : Theme.of(context)
                                                      .splashColor),

                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.transparent,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              task.formatBytes(e.length),
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .indicatorColor),
                                            )),
                                        const SizedBox(width: 5),
                                        // const Padding(
                                        //   padding:  EdgeInsets.symmetric(horizontal: 5.0),
                                        //   child:  VerticalDivider(width: 1),
                                        // ),
                                        Container(
                                            constraints: const BoxConstraints(
                                              minWidth: 60,
                                            ),
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                                Task.computedFilePercentage(
                                                    e))),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ));
                          },
                          // trailingBuilder: (context) {
                          //   return Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(
                          //         padding: const EdgeInsets.symmetric(horizontal: 5),
                          //           constraints: const BoxConstraints(
                          //             minWidth: 50,
                          //           ),
                          //           decoration: BoxDecoration(
                          //             color: Theme.of(context).cardColor,
                          //             borderRadius: BorderRadius.circular(10),
                          //           ),
                          //           alignment: Alignment.centerRight,
                          //           child: Text(task.formatBytes(e.length))),
                          //       const SizedBox(width: 5),
                          //       // const Padding(
                          //       //   padding:  EdgeInsets.symmetric(horizontal: 5.0),
                          //       //   child:  VerticalDivider(width: 1),
                          //       // ),
                          //       Container(
                          //           constraints: const BoxConstraints(
                          //             minWidth: 60,
                          //           ),
                          //           alignment: Alignment.centerRight,
                          //           child:
                          //               Text(Task.computedFilePercentage(e))),
                          //     ],
                          //   );
                          // },
                          leadingBuilder: (context)=>Container()
                          // leadingBuilder: (task.status == TaskStatus.paused ||
                          //         task.status == TaskStatus.active)
                          //     ? (context) => MyAnimatedIcon(
                          //         auto: true,
                          //         onTap: (controller) {
                          //           if (task.status == TaskStatus.paused) {
                          //             controller.forward();
                          //             changeFileSelected(e);
                          //           }
                          //         },
                          //         icon: !e.selected!
                          //             ? Icons.check_box_outline_blank
                          //             : Icons.check_box_outlined,
                          //         duration: Const.duration300ms,
                          //         color: e.selected! &&
                          //                 task.status == TaskStatus.paused
                          //             ? Theme.of(context).indicatorColor
                          //             : Theme.of(context).splashColor)
                          //     : null,
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
