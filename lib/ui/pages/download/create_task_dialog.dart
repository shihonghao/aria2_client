import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/application.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:aria2_client/util/url_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateTaskDialog extends StatefulWidget {
  const CreateTaskDialog({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateTaskDialogState();
  }
}

class _CreateTaskDialogState extends State<CreateTaskDialog> {
  late QuillController _controller;
  late TextEditingController _downloadPathController;
  late bool _showSettings;

  @override
  void initState() {
    super.initState();
    _controller = QuillController.basic();
    _downloadPathController = TextEditingController();
    _showSettings = false;
  }

  @override
  Widget build(BuildContext context) {
    if (Application.instance.selectedServer.value != null &&
        Application.instance.selectedServer.value!.aria2.serverConfig.dir !=
            null) {
      _downloadPathController.text =
          Application.instance.selectedServer.value!.aria2.serverConfig.dir!;
    }

    return AlertDialog(
        elevation: 10,
        backgroundColor: Theme.of(context).cardColor,
        title: Text(
          _showSettings ? "下载设置" : "新建",
        ),
        content: AnimatedContainer(
          width: 400,
          height: _showSettings ? 600 : 300,
          duration: Const.duration500ms,
          child: AnimatedSwitcher(
              duration: Const.duration500ms, child: buildContent()),
        ),
        actions: buildActions());
  }

  List<Widget> buildActions() {
    return _showSettings
        ? [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onPressed: () => toggle(),
              child: const Text('返回'),
            ),
          ]
        : [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onPressed: () {
                String text = _controller.document.toPlainText();
                final lines = text.split("\n");
                List<String> downloadUrls = [];
                for (var value in lines) {
                  if (value.trim().isEmpty) {
                    continue;
                  }
                  UrlType type = UrlUtil.determineLinkType(value.trim());
                  if (type == UrlType.unknown) {
                    Util.showErrorToast("$value is not a valid url");
                    continue;
                  }
                  downloadUrls.add(value.trim());
                }
                if (downloadUrls.isNotEmpty) {
                  Aria2RpcClient.instance.createTask(downloadUrls, {
                    "dir": _downloadPathController.text,
                  }).then((_) {
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  });
                }
              },
              child: const Text('确定'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('取消'),
            ),
          ];
  }

  Widget buildContent() {
    if (_showSettings) {
      return Container(
        key: UniqueKey(),
        color: Theme.of(context).cardColor,
        child: const Column(
          children: [
            Row(
              children: [
                Text("aaaaaaaaaaaaaa"),
              ],
            )
          ],
        ),
      );
    } else {
      return Column(
        children: [
          Expanded(
            flex: 4,
            child: QuillEditor.basic(
              controller: _controller,
              configurations: QuillEditorConfigurations(
                  builder: (context, editor) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Theme.of(context).splashColor,
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: editor,
                    );
                  },
                  customStyleBuilder: (Attribute<dynamic> attribute) {
                    debugPrint(attribute.key);
                    if (attribute.key.toLowerCase() == 'magnet') {
                      return TextStyle(color: Theme.of(context).indicatorColor);
                    }
                    return const TextStyle();
                  },
                  placeholder: "支持多个链接，每个链接占一行",
                  padding: EdgeInsets.fromLTRB(5.w, 10.h, 10.w, 5.h),
                  scrollable: true,
                  maxHeight: 200,
                  minHeight: 200),
            ),
          ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
          //   child: Row(
          //     children: [
          //       Text("下载链接数 : 3"),
          //     ],
          //   ),
          // ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 10.h),
              child: Row(
                children: [
                  const Text("下载路径 : "),
                  Expanded(
                      child: TextField(
                    controller: _downloadPathController,
                    style: const TextStyle(fontSize: 10),
                    decoration: const InputDecoration(
                        isCollapsed: true, contentPadding: EdgeInsets.all(7)),
                  )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => toggle(),
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                  child: const Text("高级"),
                )
              ],
            ),
          ),
        ],
      );
    }
  }

  toggle() {
    _showSettings = !_showSettings;
    setState(() {});
  }
}
