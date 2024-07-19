import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:aria2_client/model/task.dart';
import 'package:aria2_client/net/rpc_result.dart';
import 'aria2_request.dart';

class Aria2RpcClient {
  bool connected = false;
  Aria2Config? config;
  Aria2Request? request;

  Aria2RpcClient({this.config})
      : request = Aria2Request.buildRequest(config?.protocol);

  updateServer(Aria2Config config) {
    this.config = config;
    request = Aria2Request.buildRequest(config.protocol);
  }

  disconnect() {
    request!.disconnect(config!).then((value) {
      connected = !value;
    });
  }

  Future<RpcResult> connect() async {
    return await request!.connect(config!);
  }

  Future<RpcResult> getGlobalOption() {
    return request!.call(config!, "aria2.getGlobalOption", []);
  }

  Future<RpcResult> tell(TaskStatus status) async {
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
      "files"
    ]);
    RpcResult rpcResult = await request!.call(config!, method, params);

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

  Future<RpcResult> getGlobalStatus() async {
    return request!.call(config!, "aria2.getGlobalStat", []);
  }
}
