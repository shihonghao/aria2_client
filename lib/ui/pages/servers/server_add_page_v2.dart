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
  const ServerAddPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ServerAddPageState();
  }
}

class _ServerAddPageState extends State<ServerAddPage> {
  late final GlobalKey<FormBuilderState> _formKey;
  late ValueNotifier<bool> _isConnecting;
  late bool _isAvailable;
  late Aria2Config _config;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormBuilderState>();
    _isConnecting = ValueNotifier(false);
    _isAvailable = false;
    _config = Aria2Config(key: Util.generateId("ARIA2"), name: 'new');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("新增"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [ElevatedButton(onPressed: () {}, child: const Text("确认"))],
      ),
      body: FormBuilder(
        onChanged: () {
          _isConnecting.value = false;
          _isAvailable = false;
        },
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Card(
            //   elevation: 5,
            //   child: Column(
            //     children: [
            //
            //     ],
            //   ),
            // ),
            Padding(
                padding: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 10.h),
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
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 10.h),
              child: FormBuilderTextField(
                name: 'domain',
                initialValue: "127.0.0.1",
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  icon: const Icon(Icons.add_task),
                  labelText: S.of(context).aria2_rpc_url,
                  hintText: '127.0.0.1',
                  // border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 10.h),
              child: FormBuilderTextField(
                initialValue: "6800",
                name: 'port',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(errorText: "invalid port"),
                  FormBuilderValidators.max(65535, errorText: "invalid port"),
                  FormBuilderValidators.min(1, errorText: "invalid port")
                ]),
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  icon: const Icon(Icons.crop_portrait),
                  labelText: S.of(context).aria2_rpc_port,
                  hintText: '6800',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 10.h),
              child: FormBuilderTextField(
                name: 'path',
                initialValue: "/jsonrpc",
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  icon: const Icon(Icons.add_road),
                  labelText: S.of(context).aria2_rpc_path,
                  hintText: '/jsonrpc',
                  // border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 10.h),
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
                padding: EdgeInsets.all(3.w),
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
                    width: 70.w,
                    height: 30.h,
                    child: Center(
                        child: Text(val, textAlign: TextAlign.center)),
                  ),
                ))
                    .toList(growable: false),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 10.h),
              child: FormBuilderTextField(
                name: 'secret',
                decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  icon: const Icon(Icons.key),
                  labelText: S.of(context).aria2_rpc_secret,
                  hintText: '',
                  // border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.h, 20.h, 10.h, 10.h),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10
                          // backgroundColor: Theme.of(context).splashColor
                      ),
                      onPressed: () {
                        if (validateAndSaveValue()) {
                          _isConnecting.value = true;
                          Future.delayed(Const.duration2s,(){
                            Aria2RpcClient.instance
                                .connect(_config)
                                .then((result) {
                              if (result.success) {
                                _isAvailable = true;
                              } else {
                                Util.showErrorToast(result.message!);
                                _isAvailable = false;
                              }
                              _isConnecting.value = false;
                            });
                          });

                        }
                      },
                      child: Text(S.of(context).test),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 10.h),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _isConnecting,
                    builder: (BuildContext context, bool value, Widget? child) {
                      return AnimatedSwitcher(
                        duration: Const.duration500ms,
                        child: !value
                            ? (_isAvailable
                                ? IconButton(
                                    color: Theme.of(context).indicatorColor,
                                    icon:
                                        const Icon(Icons.check_circle_outline),
                                    iconSize: 100.w,
                                    onPressed: () {
                                      Application.instance
                                          .addAria2(_config)
                                          .then((_) {
                                        if (mounted) {
                                          _config = Aria2Config(
                                              key: Util.generateId("ARIA2"),
                                              name: 'new');
                                          _formKey.currentState!.reset();
                                          Navigator.pop(context);
                                        }
                                      });
                                    },
                                  )
                                : Container())
                            : LoadingAnimationWidget.beat(
                                size: 100.w,
                                color: Colors.orange,
                              ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSaveValue() {
    final FormBuilderState form = _formKey.currentState!;
    if (form.saveAndValidate()) {
      final values = form.value;
      _config.name = values["name"];
      _config.domain = values["domain"];
      _config.path = values["path"];
      _config.port = int.parse(values["port"]);
      _config.secret = values["secret"];
      _config.protocol = values["protocol"];
      return true;
    }
    return false;
  }
}
