import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/net/rpc_result.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/ui/component/animation/my_animated_icon.dart';
import 'package:aria2_client/ui/component/form/my_form.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../../aria2/model/aria2_server_config.dart';
import '../../../../const/Const.dart';
import '../../../../util/Util.dart';

part 'advanced.dart';
part 'basic.dart';
part 'bt.dart';
part 'hfs.dart';
part 'http.dart';
part 'meta_link.dart';
part 'option_item.dart';
part 'rpc.dart';
part 'sftp.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  late Aria2ServerConfig _config;
  bool firstTime = true;
  Widget? _form;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RpcResult>(
        future: loadGlobalOptions(),
        builder: (BuildContext context, AsyncSnapshot<RpcResult> snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.success) {
              _config = Aria2ServerConfig.fromJson(snapshot.data!.data);
              if (firstTime) {
                _form = buildForm(context, _config);
              }
              return Scaffold(
                  appBar: AppBar(
                    title: Text(S.of(context).settings),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        firstTime = false;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  body: _form);
            } else {
              return Scaffold(
                  appBar: AppBar(
                    title: Text(S.of(context).settings),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  body: const Center(child: Text("aaaaaaaaaaaaaa")));
            }
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text(S.of(context).settings),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: const CircularProgressIndicator(),
            );
          }
        });
  }

  Future<RpcResult> loadGlobalOptions() async {
    if (!firstTime) {
      return RpcResult(success: true, data: <String, dynamic>{});
    } else {
      return Aria2RpcClient.instance.getGlobalOption();
    }
  }

  Widget? buildForm(BuildContext context, Aria2ServerConfig config) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: Column(
            children: [
              MyForm(groups: [
                buildBasic(context, _config),
                buildHSF(context, _config),
                buildHttp(context, _config),
                buildSFTP(context, _config),
                buildBT(context, _config),
                buildMetaLink(context, _config),
                buildRpc(context, _config),
                buildAdvanced(context, _config)
              ])
            ],
          ),
        ),
      ),
    );
  }
}
