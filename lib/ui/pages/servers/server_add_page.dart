import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/aria2_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../../../aria2/aria2_constants.dart';
import '../../../aria2/model/aria2_config.dart';
import '../../../util/Util.dart';

class ServerAddPage extends StatefulWidget {
  final Aria2Config config =
      Aria2Config(key: Util.generateId("ARIA2"), name: 'new');

  ServerAddPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ServerAddPageState();
  }
}

class _ServerAddPageState extends State<ServerAddPage> {
  late final GlobalKey<FormBuilderState> _formKey;
  late ValueNotifier<bool> isConnecting;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormBuilderState>();
    isConnecting = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
          child: FormBuilder(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: FormBuilderTextField(
                    name: 'name',
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required()]),
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      icon: Icon(Icons.text_fields),
                      labelText: 'Aria2 别名',
                      hintText: '',
                      // border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      isConnecting.value = false;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: FormBuilderTextField(
                    name: 'domain',
                    initialValue: "127.0.0.1",
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      icon: Icon(Icons.add_task),
                      labelText: 'Aria2 地址',
                      hintText: '127.0.0.1',
                      // border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      isConnecting.value = false;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: FormBuilderTextField(
                    initialValue: "6800",
                    name: 'port',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(errorText: "invalid port"),
                      FormBuilderValidators.max(65535,
                          errorText: "invalid port"),
                      FormBuilderValidators.min(1, errorText: "invalid port")
                    ]),
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      icon: Icon(Icons.crop_portrait),
                      labelText: 'Aria2 端口',
                      hintText: '6800',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      isConnecting.value = false;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: FormBuilderTextField(
                    name: 'path',
                    initialValue: "/jsonrpc",
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      icon: Icon(Icons.add_road),
                      labelText: 'Aria2 路径',
                      hintText: '/jsonrpc',
                      // border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      isConnecting.value = false;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: FormBuilderChoiceChip(
                  decoration: const InputDecoration(
                      labelText: 'Protocol',
                      icon: Icon(Icons.health_and_safety),
                      fillColor: Colors.transparent,
                      border: InputBorder.none),
                  name: 'protocol',
                  initialValue: Aria2Constants.PROTOCOL_HTTP,
                  alignment: WrapAlignment.spaceBetween,
                  options: [
                    Aria2Constants.PROTOCOL_HTTP,
                    Aria2Constants.PROTOCOL_HTTPS,
                    Aria2Constants.PROTOCOL_WEBSOCKET,
                    Aria2Constants.PROTOCOL_WEBSOCKET_SECURE
                  ]
                      .map((val) => FormBuilderChipOption(
                            value: val,
                            avatar: const Icon(Icons.ac_unit_outlined),
                            child: SizedBox(
                              width: 50,
                              height: 30,
                              child: Center(
                                  child:
                                      Text(val, textAlign: TextAlign.center)),
                            ),
                          ))
                      .toList(growable: false),
                  onChanged: (text) {
                    isConnecting.value = false;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: FormBuilderTextField(
                    name: 'secret',
                    decoration: const InputDecoration(
                      fillColor: Colors.transparent,
                      icon: Icon(Icons.key),
                      labelText: 'Aria2 秘钥',
                      hintText: '',
                      // border: OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      isConnecting.value = false;
                    }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).splashColor),
                        onPressed: () {
                          if (validateAndSaveValue()) {
                            Aria2RpcClient.instance
                                .connect(widget.config)
                                .then((result) {
                              if (result.success) {
                                isConnecting.value = true;
                              } else {
                                Util.showErrorToast(result.message!);
                                isConnecting.value = false;
                              }
                            });
                          }
                        },
                        child: const Text("测试"),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).splashColor),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("取消"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isConnecting,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return IconButton(
                        color: !value
                            ? Theme.of(context).splashColor
                            : Theme.of(context).indicatorColor,
                        icon: const Icon(Icons.check_circle_outline),
                        iconSize: 100,
                        onPressed: !value
                            ? null
                            : () {
                                context
                                    .read<Aria2Model>()
                                    .addAria2(widget.config)
                                    .then((_) {
                                  Navigator.pop(context);
                                });
                              },
                      );
                    },
                  )),
            ],
          ),
        ),
      )),
    );
  }

  bool validateAndSaveValue() {
    final FormBuilderState form = _formKey.currentState!;
    if (form.saveAndValidate()) {
      final values = form.value;
      widget.config.name = values["name"];
      widget.config.domain = values["domain"];
      widget.config.path = values["path"];
      widget.config.port = int.parse(values["port"]);
      widget.config.secret = values["secret"];
      widget.config.protocol = values["protocol"];
      return true;
    }
    return false;
  }
}
