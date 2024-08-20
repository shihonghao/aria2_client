import 'dart:async';

import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/net/rpc_result.dart';
import 'package:aria2_client/providers/server_model.dart';
import 'package:aria2_client/providers/task_model.dart';
import 'package:aria2_client/store/IHive.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:flutter/cupertino.dart';

import '../aria2/model/aria2.dart';
import '../aria2/model/aria2_server_config.dart';
import '../model/task.dart';

typedef RpcRequestCallBack = void Function(dynamic data);

class Aria2Model extends ChangeNotifier {
  Aria2Model._() {
    aria2s = {};
  }

  static Aria2Model? _instance;

  static Aria2Model get instance {
    _instance ??= Aria2Model._();
    return _instance!;
  }

  late final Map<String, ServerModel> aria2s;

  ServerModel? currentServer;

  TaskModel? currentTask;

  TaskStatus? subscribeStatus;

  int disconnectCount = 0;

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
      await IHive.aria2s.put(config.key, config).then((_) => notifyListeners());
    }
  }

  Future<void> removeAria2(Aria2Config config) async {
    if (currentServer != null) {
      if (currentServer!.key == config.key) {
        setCurrentServer(null);
      }
    }
    if (aria2s.containsKey(config.key)) {
      aria2s.remove(config.key);
      await IHive.aria2s.delete(config.key).then((_) => notifyListeners());
    }
  }

  Future<bool> changeServer() async {
    if (currentServer == null) {
      return true;
    }
    Aria2RpcClient.instance.updateServer(currentServer!.aria2.config);
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
        currentServer?.aria2.serverConfig = serverConfig;
        notifyListeners();
        return true;
      }
      throw Exception();
    }).catchError((error) {
      Util.showErrorToast(
          "Can not connect to server ${currentServer!.aria2.config.name}");
      return false;
    });
  }

  bool processRpcRequest(RpcResult result, RpcRequestCallBack callback) {
    if (result.success) {
      disconnectCount = 0;
      callback(result.data);
      return true;
    }
    disconnectCount++;
    if (disconnectCount > 3) {
      Util.showErrorToast(
          "Can not connect to server ${currentServer?.aria2.config.uri}");
    }
    return false;
  }

  setCurrentServer(ServerModel? model) {
    currentServer = model;
    changeServer();
    notifyListeners();
  }
}
