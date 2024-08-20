import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/aria2_model.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:aria2_client/util/url_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

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
    if (context.read<Aria2Model>().currentServer != null &&
        context.read<Aria2Model>().currentServer!.aria2.serverConfig.dir !=
            null) {
      _downloadPathController.text =
          context.read<Aria2Model>().currentServer!.aria2.serverConfig.dir!;
    }

    return AlertDialog(
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
            TextButton(
              onPressed: () => toggle(),
              child: const Text('返回'),
            ),
          ]
        : [
            TextButton(
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
                    Navigator.of(context).pop();
                  });
                }
              },
              child: const Text('确定'),
            ),
            TextButton(
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
      return Container(
        key: UniqueKey(),
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            QuillEditor.basic(
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
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  scrollable: true,
                  maxHeight: 200,
                  minHeight: 200),
            ),
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
            //   child: Row(
            //     children: [
            //       Text("下载链接数 : 3"),
            //     ],
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
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
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => toggle(),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0)),
                    child: const Text("高级"),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  toggle() {
    _showSettings = !_showSettings;
    setState(() {});
  }
}
