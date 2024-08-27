import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/model/task.dart';
import 'package:aria2_client/providers/task_model.dart';
import 'package:aria2_client/ui/component/form/my_form.dart';
import 'package:aria2_client/ui/pages/settings/settings_item.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatefulWidget {
  final TaskModel taskModel;

  const BasicInfo({super.key, required this.taskModel});

  @override
  State<StatefulWidget> createState() {
    return _BasicInfoState();
  }
}

class _BasicInfoState extends State<BasicInfo> {
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
    final totalLength = Util.formatBytes(task.totalLength);
    return Card(
      margin: EdgeInsets.zero,
      color: Theme.of(context).highlightColor,
      child: SingleChildScrollView(
        child: ListenableBuilder(
          listenable: widget.taskModel,
          builder: (context, child) {
            task = widget.taskModel.task;
            final downloadSpeed = Util.formatBytes(task.downloadSpeed);
            final uploadSpeed = Util.formatBytes(task.uploadSpeed);
            return MyForm(
              groups: [
                FormGroup(
                  style: FormGroupStyle(
                    backgroundColor: Theme.of(context).splashColor,
                    collapsedBackgroundColor: Theme.of(context).highlightColor,
                    textColor: Theme.of(context).primaryColor,
                    elevation: 3,
                  ),
                  expanded: true,
                  showDivider: false,
                  title: S.of(context).baseInfo,
                  items: [
                    FormItem<String>(
                        readOnly: true,
                        key: 'task_name',
                        type: FormItemType.input,
                        value: task.taskName),
                    FormItem<String>(
                        readOnly: true,
                        key: 'task_size',
                        type: FormItemType.input,
                        value: "${totalLength.first}",
                        trailingBuilder: (context) => buildUnitTrailing(
                            context, totalLength.second.name,
                            color: Theme.of(context).cardColor)),
                    FormItem<String>(
                        readOnly: true,
                        key: 'task_status',
                        type: FormItemType.input,
                        value: '',
                        trailingBuilder: (context) => buildUnitTrailing(
                            context, task.status.name,
                            color: Theme.of(context).cardColor)),
                    //进度
                    FormItem<String>(
                      readOnly: true,
                      key: 'task_process',
                      type: FormItemType.input,
                      value: task.computedPercentage(),
                    ),
                    if (task.status == TaskStatus.active)
                      FormItem<String>(
                        readOnly: true,
                        key: 'download_speed',
                        type: FormItemType.input,
                        value: downloadSpeed.first.toString(),
                        trailingBuilder: (context) {
                          return buildUnitTrailing(
                              context, "${downloadSpeed.second.name}/s",
                              color: Theme.of(context).cardColor);
                        },
                      ),
                    if (task.isBitTorrent())
                      FormItem<String>(
                        readOnly: true,
                        key: 'upload_speed',
                        type: FormItemType.input,
                        value: uploadSpeed.first.toString(),
                        trailingBuilder: (context) {
                          return buildUnitTrailing(
                              context, "${uploadSpeed.second.name}/s",
                              color: Theme.of(context).cardColor);
                        },
                      ),
                    if (task.isBitTorrent())
                      FormItem<String>(
                        readOnly: true,
                        key: 'share_ratio',
                        type: FormItemType.input,
                        value: task.getShareRatio(),
                      ),
                    if (task.isBitTorrent() && task.status == TaskStatus.active)
                      FormItem<String>(
                        readOnly: true,
                        key: 'seedersAndConnections',
                        type: FormItemType.input,
                        value: "${task.numSeeders} / ${task.connections}",
                      ),
                    if (task.isBitTorrent() && task.bittorrent!.creationDate!=null)
                      FormItem<String>(
                        readOnly: true,
                        key: 'creationDate',
                        type: FormItemType.input,
                        value: DateTime.fromMillisecondsSinceEpoch(
                                task.bittorrent!.creationDate! * 1000)
                            .toString(),
                      ),
                    if (task.isBitTorrent())
                      FormItem<String>(
                          readOnly: true,
                          key: 'info_hash',
                          type: FormItemType.input,
                          value: task.infoHash),
                    if (task.status == TaskStatus.active)
                      FormItem(
                        readOnly: true,
                        key: 'remain_time',
                        type: FormItemType.input,
                        value: task.getRemainTime(),
                      ),
                    //连接数
                    if (!task.isBitTorrent() &&
                        task.status == TaskStatus.active)
                      FormItem(
                        readOnly: true,
                        key: 'connections',
                        type: FormItemType.input,
                        value: task.connections.toString(),
                      ),
                    //下载地址
                    if (!task.isBitTorrent())
                      FormItem<String>(
                          readOnly: true,
                          key: 'download_url',
                          type: FormItemType.input,
                          value: task.getUri()),
                    //下载路径
                    FormItem<String>(
                        readOnly: true,
                        key: 'download_path',
                        type: FormItemType.input,
                        showDivider: false,
                        value: task.dir),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
