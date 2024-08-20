import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../aria2/aria2_constants.dart';
import '../../providers/aria2_model.dart';

class Aria2ServerAddDialog extends Dialog {
  final Aria2Config config = Aria2Config(key: "", name: "");

  Aria2ServerAddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: SizedBox(
          width: 700,
          height: 600,
          child: Center(
              child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 0.5, //宽度
                          color: Colors.red, //边框颜色
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Icon(Icons.add_box), Text("新增")],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(100, 10, 100, 10),
                            child: FormBuilderTextField(
                                name: 'name',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.text_fields),
                                  labelText: 'Aria2 别名',
                                  hintText: '',
                                  // border: OutlineInputBorder(),
                                ),
                                onChanged: (text) {
                                  config.name = text!;
                                }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(100, 10, 100, 10),
                            child: FormBuilderTextField(
                                name: 'domain',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.add_task),
                                  labelText: 'Aria2 地址',
                                  hintText: '127.0.0.1',
                                  // border: OutlineInputBorder(),
                                ),
                                onChanged: (text) {
                                  config.domain = text!;
                                }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(100, 10, 100, 10),
                            child: FormBuilderTextField(
                                name: 'port',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.crop_portrait),
                                  labelText: 'Aria2 端口',
                                  hintText: '6800',
                                  // border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (text) {
                                  config.port = int.parse(text!);
                                }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(100, 10, 100, 10),
                            child: FormBuilderTextField(
                                name: 'path',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.add_road),
                                  labelText: 'Aria2 路径',
                                  hintText: '/jsonrpc',
                                  // border: OutlineInputBorder(),
                                ),
                                onChanged: (text) {
                                  config.path = text!;
                                }),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(100, 10, 100, 10),
                            child: FormBuilderChoiceChip(
                              decoration: const InputDecoration(
                                labelText: 'Protocol',
                                icon: Icon(Icons.health_and_safety),
                              ),
                              name: 'protocol',
                              alignment: WrapAlignment.spaceBetween,
                              options: [
                                Aria2Constants.PROTOCOL_HTTP,
                                Aria2Constants.PROTOCOL_HTTPS,
                                Aria2Constants.PROTOCOL_WEBSOCKET,
                                Aria2Constants.PROTOCOL_WEBSOCKET_SECURE
                              ]
                                  .map((val) => FormBuilderChipOption(
                                        value: val,
                                        avatar:
                                            const Icon(Icons.ac_unit_outlined),
                                        child: SizedBox(
                                          width: 50,
                                          height: 30,
                                          child: Center(
                                              child: Text(val,
                                                  textAlign: TextAlign.center)),
                                        ),
                                      ))
                                  .toList(growable: false),
                              onChanged: (text) {
                                config.protocol = text!;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(100, 10, 100, 10),
                            child: FormBuilderTextField(
                                name: 'secretKey',
                                decoration: const InputDecoration(
                                  icon: Icon(Icons.key),
                                  labelText: 'Aria2 秘钥',
                                  hintText: '',
                                  // border: OutlineInputBorder(),
                                ),
                                onChanged: (text) {
                                  config.secret = text!;
                                }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Expanded(
                  //     child:
                  Container(
                    // margin: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                    width: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border(
                        right: BorderSide(
                          width: 0.5, //宽度
                          color: Colors.red, //边框颜色
                        ),
                      ),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () => {Navigator.pop(context)},
                        child: const Text("Close"),
                      ),
                    ),
                  ),
                  // ),
                  // Expanded(
                  //     child:
                  Container(
                    width: 200,
                    // margin: const EdgeInsets.fromLTRB(100, 10, 100, 10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border(
                        right: BorderSide(
                          width: 0.5, //宽度
                          color: Colors.red, //边框颜色
                        ),
                      ),
                    ),
                    child: Center(
                      child: TextButton(
                        onPressed: () => confirm(context),
                        child: const Text("Confirm"),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
        ));
  }

  confirm(BuildContext context) {
    config.uri();
    context.read<Aria2Model>().addAria2(config);
    Navigator.pop(context);
  }
}
