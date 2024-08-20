import 'package:aria2_client/generated/l10n.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/ui/component/animation/my_animated_icon.dart';
import 'package:aria2_client/ui/component/form/my_form.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../aria2/model/aria2_server_config.dart';
import '../../../../const/Const.dart';
import '../../../../providers/aria2_model.dart';
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
  late final Aria2ServerConfig _config;

  @override
  void initState() {
    super.initState();
    _config = context.read<Aria2Model>().currentServer!.aria2.serverConfig;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:  Text(S.of(context).settings),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
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
        ));
  }
}
