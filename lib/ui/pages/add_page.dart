import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../aria2/aria2_constants.dart';
import '../../aria2/model/aria2_config.dart';

class AddPage extends StatefulWidget {
  final Aria2Config config = Aria2Config(name: "");

  AddPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddPageState();
  }
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
          child: FormBuilderTextField(
              name: 'name',
              decoration: const InputDecoration(
                icon: Icon(Icons.text_fields),
                labelText: 'Aria2 别名',
                hintText: '',
                // border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                widget.config.name = text!;
              }),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
          child: FormBuilderTextField(
              name: 'domain',
              decoration: const InputDecoration(
                icon: Icon(Icons.add_task),
                labelText: 'Aria2 地址',
                hintText: '127.0.0.1',
                // border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                widget.config.domain = text!;
              }),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
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
                widget.config.port = int.parse(text!);
              }),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
          child: FormBuilderTextField(
              name: 'path',
              decoration: const InputDecoration(
                icon: Icon(Icons.add_road),
                labelText: 'Aria2 路径',
                hintText: '/jsonrpc',
                // border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                widget.config.path = text!;
              }),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
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
                      avatar: const Icon(Icons.ac_unit_outlined),
                      child: SizedBox(
                        width: 50,
                        height: 30,
                        child: Center(
                            child: Text(val, textAlign: TextAlign.center)),
                      ),
                    ))
                .toList(growable: false),
            onChanged: (text) {
              widget.config.protocol = text!;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
          child: FormBuilderTextField(
              name: 'secretKey',
              decoration: const InputDecoration(
                icon: Icon(Icons.key),
                labelText: 'Aria2 秘钥',
                hintText: '',
                // border: OutlineInputBorder(),
              ),
              onChanged: (text) {
                widget.config.secret = text!;
              }),
        ),
      ],
    ));
  }
}
