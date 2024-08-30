import 'dart:async';

import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/providers/server_model.dart';
import 'package:aria2_client/providers/task_model.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/timer/my_timer_manager.dart';
import 'package:aria2_client/ui/pages/servers/server_content.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:flutter/cupertino.dart';

import '../aria2/model/aria2.dart';
import '../aria2/model/aria2_server_config.dart';

class Application extends ChangeNotifier {
  Application._();

  static Application? _instance;

  static Application get instance {
    _instance ??= Application._();
    return _instance!;
  }

  final ValueNotifier<ViewType> serverViewType = ValueNotifier(ViewType.list);

  final ValueNotifier<ServerModel?> selectedServer = ValueNotifier(null);

  final ValueNotifier<TaskModel?> selectedTask = ValueNotifier(null);

  final Map<String, ServerModel> aria2s = {};

  init() async {
    aria2s.clear();
    for (Aria2Config config in IHive.aria2s.values) {
      if (!aria2s.containsKey(config.key)) {
        aria2s[config.key] = ServerModel(aria2: Aria2(config: config));
      }
    }
  }

  Future<void> addAria2(Aria2Config config) async {
    if (!aria2s.containsKey(config.key)) {
      aria2s[config.key] = ServerModel(aria2: Aria2(config: config));
      IHive.aria2s.put(config.key, config);
      notifyListeners();
    }
  }

  Future<void> removeAria2(Aria2Config config) async {
    if (selectedServer.value != null) {
      if (selectedServer.value!.key == config.key) {
        changeServer(null);
      }
    }

    if (aria2s.containsKey(config.key)) {
      aria2s.remove(config.key);
      IHive.aria2s.delete(config.key);
      notifyListeners();
    }
  }

  Future<bool> changeServer(ServerModel? model) async {
    if (model == null) {
      selectedServer.value = model;
      return true;
    }

    Aria2RpcClient.instance.switchServer(model.aria2.config);

    List<dynamic>? enabledFeatures;
    String? version;
    return await Aria2RpcClient.instance.connect().then((result) {
      if (result.success) {
        enabledFeatures = result.data["enabledFeatures"] as List<dynamic>?;
        version = result.data["version"];
        return Aria2RpcClient.instance.getGlobalOption();
      }
      throw Exception();
    }).then((result) {
      if (result.success) {
        result.data
            .addAll({"version": version, "enabledFeatures": enabledFeatures});
        Aria2ServerConfig serverConfig =
            Aria2ServerConfig.fromJson(result.data);
        model.aria2.serverConfig = serverConfig;
        selectedServer.value = model;
        return true;
      }
      throw Exception();
    }).catchError((error) {
      Util.showErrorToast(
          "Can not connect to server ${selectedServer.value!.aria2.config.name}");
      return false;
    });
  }

  Future<void> switchServerViewType() async {
    serverViewType.value =
        serverViewType.value == ViewType.list ? ViewType.card : ViewType.list;
  }
}
