import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../aria2/aria2_constants.dart';
import '../../../aria2/model/aria2_config.dart';
import '../../../generated/l10n.dart';
import '../../../util/Util.dart';

class ServerAddPage extends StatefulWidget {
  final VoidCallback? onCancel;
  final ValueChanged? onConfirm;

  const ServerAddPage({super.key, this.onCancel, this.onConfirm});

  @override
  State<StatefulWidget> createState() {
    return _ServerAddPageState();
  }
}

class _ServerAddPageState extends State<ServerAddPage> {
  late final GlobalKey<FormBuilderState> _formKey;
  late ValueNotifier<bool> _isConnecting;

  Aria2Config? _config;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormBuilderState>();
    _isConnecting = ValueNotifier(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30.h,
        backgroundColor: Colors.transparent,
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent),
          child: const Icon(Icons.arrow_back),
          onPressed: () {
            widget.onCancel?.call();
          },
        ),
        title: Center(
          child: ValueListenableBuilder(
              valueListenable: _isConnecting,
              builder: (BuildContext context, bool value, Widget? child) {
                return FutureBuilder(
                  future: test(),
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.requireData) {
                        return const Text("ok");
                      } else {
                        return const Text("无法连接");
                      }
                    } else {
                      return LoadingAnimationWidget.staggeredDotsWave(
                        size: 30.w,
                        color: const Color(0xFF1A1A3F),
                      );
                    }
                  },
                );
              },
              child: const Text("")),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    backgroundColor: Colors.transparent),
                onPressed: () {
                  validateAndSaveValue();
                },
                child: const Text("确认")),
          )
        ],
      ),
      body: Column(
        children: [
          const Divider(),
          FormBuilder(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
                    child: FormBuilderTextField(
                        name: 'name',
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        decoration: InputDecoration(
                          fillColor: Colors.transparent,
                          icon: const Icon(Icons.text_fields),
                          labelText: S.of(context).aria2_alias,
                          hintText: '',
                          // border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          _isConnecting.value = false;
                        }),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                              name: 'domain',
                              validator: FormBuilderValidators.compose(
                                  [FormBuilderValidators.required()]),
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                icon: const Icon(Icons.add_task),
                                labelText: S.of(context).aria2_rpc_url,
                                // border: OutlineInputBorder(),
                              ),
                              onChanged: (text) {
                                _isConnecting.value = false;
                              }),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          child: FormBuilderTextField(
                              initialValue: "6800",
                              name: 'port',
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.numeric(
                                    errorText: "invalid port"),
                                FormBuilderValidators.max(65535,
                                    errorText: "invalid port"),
                                FormBuilderValidators.min(1,
                                    errorText: "invalid port")
                              ]),
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                icon: const Icon(Icons.crop_portrait),
                                labelText: S.of(context).aria2_rpc_port,
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                _isConnecting.value = false;
                              }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                              name: 'path',
                              initialValue: "/jsonrpc",
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                icon: const Icon(Icons.add_road),
                                labelText: S.of(context).aria2_rpc_path,
                                // border: OutlineInputBorder(),
                              ),
                              onChanged: (text) {
                                _isConnecting.value = false;
                              }),
                        ),
                        const VerticalDivider(),
                        Expanded(
                          child: FormBuilderTextField(
                              name: 'secret',
                              decoration: InputDecoration(
                                fillColor: Colors.transparent,
                                icon: const Icon(Icons.key),
                                labelText: S.of(context).aria2_rpc_secret,
                                hintText: '',
                                // border: OutlineInputBorder(),
                              ),
                              onChanged: (text) {
                                _isConnecting.value = false;
                              }),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.w, horizontal: 10.w),
                    child: FormBuilderChoiceChip(
                      decoration: InputDecoration(
                          labelText: S.of(context).aria2_rpc_protocol,
                          icon: const Icon(Icons.health_and_safety),
                          fillColor: Colors.transparent,
                          border: InputBorder.none),
                      name: 'protocol',
                      initialValue: Aria2Constants.PROTOCOL_HTTP,
                      alignment: WrapAlignment.spaceBetween,
                      labelPadding: EdgeInsets.zero,

                      options: [
                        Aria2Constants.PROTOCOL_HTTP,
                        Aria2Constants.PROTOCOL_HTTPS,
                        // Aria2Constants.PROTOCOL_WEBSOCKET,
                        // Aria2Constants.PROTOCOL_WEBSOCKET_SECURE
                      ]
                          .map((val) => FormBuilderChipOption(
                                value: val,
                                avatar: Icon(
                                  Icons.ac_unit_outlined,
                                  size: 14.r,
                                ),
                                child: SizedBox(
                                  width: 30.w,
                                  height: 30.h,
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child:
                                          Text(val, textAlign: TextAlign.left)),
                                ),
                              ))
                          .toList(growable: false),
                      onChanged: (text) {
                        _isConnecting.value = false;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSaveValue() {
    final FormBuilderState form = _formKey.currentState!;
    if (form.saveAndValidate()) {
      _config =
          _config ?? Aria2Config(key: Util.generateId("ARIA2"), name: "NEW");
      final values = form.value;
      _config!.name = values["name"];
      _config!.domain = values["domain"];
      _config!.path = values["path"];
      _config!.port = int.parse(values["port"]);
      _config!.secret = values["secret"];
      _config!.protocol = values["protocol"];
      _isConnecting.value = true;
      return true;
    }
    return false;
  }

  Future<bool> test() async {
    if (_config == null) {
      return false;
    }
    await Future.delayed(Const.duration2s);
    return Aria2RpcClient.instance.connect(_config).then((result) {
      if (result.success) {
        Application.instance.addAria2(_config!);
        _config = null;
        _formKey.currentState!.reset();
        return true;
      } else {
        _config = null;
        Util.showErrorToast(result.message!);
        return false;
      }
    }).whenComplete(() {
      _isConnecting.value = false;
    });
  }
}
