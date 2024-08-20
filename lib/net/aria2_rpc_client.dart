import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:aria2_client/model/task.dart';
import 'package:aria2_client/net/rpc_result.dart';
import 'package:aria2_client/util/Util.dart';

import 'aria2_request.dart';

class Aria2RpcClient {
  Aria2RpcClient._();

  static Aria2RpcClient? _instance;

  static Aria2RpcClient get instance {
    _instance ??= Aria2RpcClient._();
    return _instance!;
  }

  bool connected = false;
  late Aria2Config config;

  updateServer(Aria2Config config) {
    this.config = config;
  }

  disconnect() {
    Aria2Request.getRequest(config).disconnect(config).then((value) {
      connected = value;
    });
  }

  Future<RpcResult> connect([Aria2Config? config]) async {
    config ??= this.config;
    return await Aria2Request.getRequest(config).connect(config);
  }

  Future<RpcResult> getGlobalOption([Aria2Config? config]) async {
    config ??= this.config;
    return Aria2Request.getRequest(config)
        .call(config, "aria2.getGlobalOption", []);
  }

  Future<RpcResult> tell(TaskStatus status, [Aria2Config? config]) async {
    config ??= this.config;
    String method = "aria2.tellActive";
    List<dynamic> params = List.empty(growable: true);
    switch (status) {
      case TaskStatus.active:
        method = "aria2.tellActive";
        break;
      case TaskStatus.waiting:
        method = "aria2.tellWaiting";
        params.add(0);
        params.add(1000);
        break;
      case TaskStatus.paused:
        method = "aria2.tellWaiting";
        params.add(0);
        params.add(1000);
        break;
      case TaskStatus.complete:
        method = "aria2.tellStopped";
        params.add(0);
        params.add(1000);
        break;
      case TaskStatus.error:
        method = "aria2.tellStopped";
        params.add(0);
        params.add(1000);
        break;
      case TaskStatus.removed:
        method = "aria2.tellStopped";
        params.add(0);
        params.add(1000);
        break;
    }
    params.add([
      "gid",
      "totalLength",
      "completedLength",
      "uploadSpeed",
      "downloadSpeed",
      "connections",
      "numSeeders",
      "seeder",
      "status",
      "errorCode",
      "verifiedLength",
      "verifyIntegrityPending",
      "files",
      // "dir",
      // "bitfield",
      // "numPieces",
      // "pieceLength",
      "bittorrent",
      // "infoHash"
    ]);
    RpcResult rpcResult =
        await Aria2Request.getRequest(config).call(config, method, params);

    if (rpcResult.success) {
      List<Task> tasks = List.empty(growable: true);
      rpcResult.data.forEach((element) {
        Task task = Task.fromJson(element);
        if (task.status == status) {
          tasks.add(task);
        }
      });
      return RpcResult.ok(tasks);
    }

    return rpcResult;
  }

  Future<RpcResult> getGlobalStatus([Aria2Config? config]) async {
    config ??= this.config;
    return Aria2Request.getRequest(config)
        .call(config, "aria2.getGlobalStat", []);
  }

  Future<RpcResult> pauseTask(String gid, [Aria2Config? config]) async {
    config ??= this.config;
    return Aria2Request.getRequest(config)
        .call(config, "aria2.forcePause", [gid]);
  }

  Future<RpcResult> unpauseTask(String gid, [Aria2Config? config]) async {
    config ??= this.config;
    return Aria2Request.getRequest(config)
        .call(config, "aria2.unpause", [gid]);
  }

  Future<RpcResult> removeTask(String gid, [Aria2Config? config]) async {
    config ??= this.config;
    return Aria2Request.getRequest(config)
        .call(config, "aria2.forceRemove", [gid]);
  }

  Future<RpcResult> unpauseAll([Aria2Config? config]) async {
    config ??= this.config;

    return Aria2Request.getRequest(config).call(config, "aria2.unpauseAll", []);
  }

  Future<RpcResult> pauseAll([Aria2Config? config]) async {
    config ??= this.config;
    return Aria2Request.getRequest(config)
        .call(config, "aria2.forcePauseAll", []);
  }

  Future<RpcResult> changeGlobalOption(String option, String value,
      [Aria2Config? config]) async {
    config ??= this.config;
    return Aria2Request.getRequest(config)
        .call(config, "aria2.changeGlobalOption", [
      {option: value}
    ]);
  }

  Future<RpcResult> changeTaskOption(String gid, Map<String,String> options,
      [Aria2Config? config]) async {
    config ??= this.config;
    return Aria2Request.getRequest(config)
        .call(config, "aria2.changeOption", [gid, options]);
  }



  Future<RpcResult> createTask(List<String> urls, Map<String, String> options,
      [Aria2Config? config]) async {
    config ??= this.config;
    return Aria2Request.getRequest(config)
        .call(config, "aria2.addUri", [urls, options]);
  }

  Future<RpcResult> getPeers(String gid, [Aria2Config? config]) async {
    config ??= this.config;
    return Aria2Request.getRequest(config)
        .call(config, "aria2.getPeers", [gid]);
  }

  Future<RpcResult> tellStatusAndPeers(String gid) async {
    return Aria2Request.getRequest(config).multiCall(config, [
      Pair(first: "aria2.tellStatus", second: [gid]),
      Pair(first: "aria2.getPeers", second: [gid]),
    ]);
  }

  Future<RpcResult> tellStatus(String gid) async {
    return Aria2Request.getRequest(config)
        .call(config, "aria2.tellStatus", [gid]);
  }
}
