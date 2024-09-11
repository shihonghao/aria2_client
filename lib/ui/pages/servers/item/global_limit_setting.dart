import 'package:animations/animations.dart';
import 'package:aria2_client/aria2/model/aria2_server_config.dart';
import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class GlobalLimitSetting extends StatefulWidget {
  final ValueNotifier<bool> isSelected;
  final Aria2ServerConfig serverConfig;

  const GlobalLimitSetting(
      {super.key, required this.isSelected, required this.serverConfig});

  @override
  State<StatefulWidget> createState() {
    return _GlobalLimitSetting();
  }
}

class _GlobalLimitSetting extends State<GlobalLimitSetting> {
  late double _uploadLimitSpeed;
  late double _downloadLimitSpeed;
  late DataUnit _uploadUnit;
  late DataUnit _downloadUnit;

  @override
  void initState() {
    super.initState();
    final serverConfig = widget.serverConfig;
    final uploadLimit = Util.formatBytes(serverConfig.maxOverallUploadLimit);
    final downloadLimit =
        Util.formatBytes(serverConfig.maxOverallDownloadLimit);

    _uploadLimitSpeed = uploadLimit.first;
    _uploadUnit = uploadLimit.second;
    _downloadLimitSpeed = downloadLimit.first;
    _downloadUnit = downloadLimit.second;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.isSelected,
        builder: (context, value, child) {
          final labelTexStyle = TextStyle(
              color: !value
                  ? Theme.of(context).splashColor
                  : Theme.of(context).indicatorColor);
          final texStyle =
              TextStyle(color: value ? null : Theme.of(context).splashColor);

          return Container(
            constraints: const BoxConstraints(minHeight: 50),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.fromLTRB(25, 15, 25, 15),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 0, 40, 0),
                        child: Column(
                          children: [
                            Text(
                              S.of(context).global_limit,
                              style: labelTexStyle,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${S.of(context).download} ：",
                                  style: texStyle,
                                ),
                                Expanded(
                                    child: SpeedLimit(
                                        speed: _downloadLimitSpeed,
                                        unit: _downloadUnit,
                                        active: value))
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("${S.of(context).upload} ： ",
                                    style: texStyle),
                                Expanded(
                                    child: SpeedLimit(
                                        speed: _uploadLimitSpeed,
                                        unit: _uploadUnit,
                                        active: value))
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class SpeedLimit extends StatefulWidget {
  final void Function(String value, DataUnit unit)? onChange;
  final double speed;
  final DataUnit unit;
  final bool active;

  const SpeedLimit(
      {super.key,
      this.onChange,
      required this.speed,
      required this.unit,
      required this.active});

  @override
  State<StatefulWidget> createState() {
    return _SpeedLimitState();
  }
}

class _SpeedLimitState extends State<SpeedLimit> {
  late final List<DropdownMenuItem<String>> _unitOptions;
  late final Map<String, String> _limits;
  late final ValueNotifier<bool> _enableInput;
  late final TextEditingController _controller;
  late ValueNotifier<double> _speed;
  late ValueNotifier<DataUnit> _unit;
  late ValueNotifier<DataUnit> _tmpUnit;
  late int initIndex;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.speed.toString();
    _tmpUnit = ValueNotifier(widget.unit);
    _speed = ValueNotifier(widget.speed);
    _unit = ValueNotifier(widget.unit);

    _unitOptions = DataUnit.values
        .map((e) => DropdownMenuItem<String>(
              alignment: AlignmentDirectional.center,
              value: e.name,
              child: Text(
                "${e.name}/s",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ))
        .toList();

    _limits = {
      "500": DataUnit.KB.name,
      "1": DataUnit.MB.name,
      "5": DataUnit.MB.name,
      "10": DataUnit.MB.name,
      "20": DataUnit.MB.name,
      "50": DataUnit.MB.name,
      "100": DataUnit.MB.name,
      "无限制": "",
      "自定义": "",
    };
    _enableInput = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    final texStyle =
        TextStyle(color: widget.active ? null : Theme.of(context).splashColor);
    return InkWell(
        onTap: () {
          if (_speed.value == 0) {
            initIndex = 7;
          } else {
            final tmpIndex = _limits.entries.toList().indexWhere((entry) =>
                double.parse(entry.key) == _speed.value &&
                entry.value == _unit.value.name);
            initIndex = tmpIndex == -1 ? 8 : tmpIndex;
          }
          _controller.text = _speed.value.toString();
          showModal(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("限速"),
                  content: buildContent(context),
                  actions: buildActions(context),
                );
              });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: [
              ValueListenableBuilder(
                valueListenable: _speed,
                builder: (BuildContext context, double value, Widget? child) {
                  return Text(
                    value.toString(),
                    style: texStyle,
                  );
                },
              ),
              const SizedBox(
                width: 10,
              ),
              ValueListenableBuilder(
                valueListenable: _unit,
                builder: (BuildContext context, DataUnit value, Widget? child) {
                  return Text(
                    "${value.name} /s",
                    style: texStyle,
                  );
                },
              ),
            ],
          ),
        ));
  }

  buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () {
          final converted = _tmpUnit.value
              .convertData(double.parse(_controller.text), DataUnit.B);
          Aria2RpcClient.instance
              .changeGlobalOption(
                  "max-overall-upload-limit", converted.toString())
              .then((rpcResult) {
            if (rpcResult.success) {
              _speed.value = double.parse(_controller.text);
              _unit.value = _tmpUnit.value;
              if (mounted) {
                Navigator.of(context).pop();
              }
            }
          });
        },
        child: const Text('确定'),
      ),
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('取消'),
      ),
    ];
  }

  buildContent(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 500,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: MyCardGroup(
                  initialSelectedIndex: initIndex,
                  onChange: (index) {
                    if (index == 7) {
                      _enableInput.value = false;
                      _controller.text = "0";
                      _tmpUnit.value = DataUnit.B;
                    } else if (index == 8) {
                      _enableInput.value = true;
                      _controller.text = "0";
                      _tmpUnit.value = DataUnit.B;
                    } else {
                      _enableInput.value = false;
                      _controller.text = _limits.keys.toList()[index];
                      _tmpUnit.value =
                          DataUnit.fromName(_limits.values.toList()[index]);
                    }
                  },
                  axis: Axis.horizontal,
                  mainAxisNum: 3,
                  children: _limits.entries
                      .map((e) => Text(
                          "${e.key} ${e.value == "" ? "" : "${e.value} /s"}"))
                      .toList(),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ValueListenableBuilder(
              valueListenable: _enableInput,
              builder: (context, value, child) {
                return TextField(
                  enabled: value,
                  decoration: InputDecoration(
                    suffix: DropdownButtonHideUnderline(
                      child: ValueListenableBuilder(
                        valueListenable: _tmpUnit,
                        builder: (BuildContext context, DataUnit value,
                            Widget? child) {
                          return DropdownButton2<String>(
                            hint: child,
                            items: _unitOptions,
                            value: value.name,
                            onChanged: (String? value) {
                              _tmpUnit.value = DataUnit.fromName(value!);
                            },
                          );
                        },
                        child: Text(
                          '请选择',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    _controller.text = value;
                  },
                  controller: _controller,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MyCardGroup extends StatefulWidget {
  final Axis axis;
  final int mainAxisNum;
  final List<Widget> children;
  final void Function(int index)? onChange;
  final int? initialSelectedIndex;

  const MyCardGroup(
      {super.key,
      required this.axis,
      required this.mainAxisNum,
      required this.children,
      this.initialSelectedIndex,
      this.onChange});

  @override
  State<StatefulWidget> createState() {
    return _MyCardGroupState();
  }
}

class _MyCardGroupState extends State<MyCardGroup> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    List<Widget> groups = [];

    for (int i = 0; i < widget.children.length / widget.mainAxisNum; i++) {
      List<Widget> items = [];
      int startIndex = i * widget.mainAxisNum;
      for (int j = 0; j < widget.mainAxisNum; j++) {
        int index = startIndex + j;
        if (index > widget.children.length - 1) {
          break;
        }
        items.add(Expanded(
          child: Card(
            color: Theme.of(context).splashColor,
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                _selectedIndex = index;
                widget.onChange?.call(index);
                setState(() {});
              },
              child: AnimatedContainer(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: (_selectedIndex ?? widget.initialSelectedIndex) ==
                            index
                        ? Border.all(color: Theme.of(context).indicatorColor)
                        : null),
                duration: Const.duration300ms,
                child: Center(
                  child: widget.children[index],
                ),
              ),
            ),
          ),
        ));
      }
      groups.add(widget.axis == Axis.horizontal
          ? Row(children: items)
          : Column(
              children: items,
            ));
    }

    return widget.axis == Axis.horizontal
        ? Column(children: groups)
        : Row(children: groups);
  }
}
