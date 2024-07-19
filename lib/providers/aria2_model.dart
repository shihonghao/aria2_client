import 'dart:async';
import 'dart:convert';

import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:aria2_client/aria2/model/aria2_global_status.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/net/rpc_result.dart';
import 'package:aria2_client/static/vars.dart';
import 'package:aria2_client/timer/my_timer.dart';
import 'package:aria2_client/util/Util.dart';
import 'package:flutter/cupertino.dart';

import '../aria2/model/aria2.dart';
import '../aria2/model/aria2_server_config.dart';
import '../model/task.dart';
import '../util/SharedPreferencesUtil.dart';

typedef RpcRequestCallBack = void Function(dynamic data);

class Aria2Model extends ChangeNotifier {
  final List<Aria2> aria2s = List.empty(growable: true);

  Aria2RpcClient rpcClient;

  Aria2? current;

  MyTimer taskTimer;

  MyTimer globalStatusTimer;

  TaskStatus? subscribeStatus;

  int disconnectCount = 0;

  Aria2GlobalStatus globalStatus = Aria2GlobalStatus(
      downloadSpeed: 0,
      uploadSpeed: 0,
      numActive: 0,
      numWaiting: 0,
      numStopped: 0,
      numStoppedTotal: 0);

  //活动的任务
  final List<Task> activeTasks = List.empty(growable: true);

  //等待的任务
  final List<Task> waitingTasks = List.empty(growable: true);

  //暂停的任务
  final List<Task> pausedTasks = List.empty(growable: true);

  //完成的任务
  final List<Task> completeTasks = List.empty(growable: true);

  //失败的任务
  final List<Task> errorTasks = List.empty(growable: true);

  //移除的任务
  final List<Task> removedTasks = List.empty(growable: true);

  Aria2Model()
      : rpcClient = Aria2RpcClient(),
        taskTimer = MyTimer.empty(),
        globalStatusTimer = MyTimer.empty();

  init() async {
    aria2s.clear();
    final config = await SharedPreferencesUtil.getData<String>("aria2");
    parseConfig(config);
    aria2s.add(Aria2(
        config: Aria2Config(
            name: 'localhost',
            domain: '10.2.5.216',
            port: 6800,
            path: "/jsonrpc",
            secret: "",
            protocol: "http",
            isDefault: true)));
    aria2s.add(Aria2(
        config: Aria2Config(
            name: 'hhsmtx1',
            domain: 'hhsmtx.dynv6.net',
            port: 441,
            path: "/aria2/s/jsonrpc",
            secret: "Birthday19",
            protocol: "https",
            isDefault: true)));
    aria2s.add(Aria2(
        config: Aria2Config(
            name: 'hhsmtx2',
            domain: 'hhsmtx.dynv6.net',
            port: 441,
            path: "/aria2/s/jsonrpc",
            secret: "Birthday19",
            protocol: "https",
            isDefault: true)));
    aria2s.add(Aria2(
        config: Aria2Config(
            name: 'hhsmtx2',
            domain: 'hhsmtx.dynv6.net',
            port: 441,
            path: "/aria2/s/jsonrpc",
            secret: "Birthday19",
            protocol: "https",
            isDefault: true)));
    aria2s.add(Aria2(
        config: Aria2Config(
            name: 'hhsmtx2',
            domain: 'hhsmtx.dynv6.net',
            port: 441,
            path: "/aria2/s/jsonrpc",
            secret: "Birthday19",
            protocol: "https",
            isDefault: true)));
    aria2s.add(Aria2(
        config: Aria2Config(
            name: 'hhsmtx2',
            domain: 'hhsmtx.dynv6.net',
            port: 441,
            path: "/aria2/s/jsonrpc",
            secret: "Birthday19",
            protocol: "https",
            isDefault: true)));
  }

  void parseConfig(config) {
    if (config == null) {
      return;
    }
    List<dynamic> list = json.decode(config);
    for (var element in list) {
      aria2s.add(Aria2(config: Aria2Config.fromJson(element["config"])));
    }
  }

  addAria2(Aria2Config config) {
    aria2s.add(Aria2(config: config));
    SharedPreferencesUtil.saveData("aria2", json.encode(aria2s));
    notifyListeners();
  }

  clear() {
    globalStatusTimer.stop();
    taskTimer.stop();
    current = null;
    activeTasks.clear();
    waitingTasks.clear();
    pausedTasks.clear();
    completeTasks.clear();
    errorTasks.clear();
    removedTasks.clear();
    notifyListeners();
  }

  Future<bool> changeServer(String name) async {
    clear();
    current = aria2s.firstWhere((element) => element.config.name == name);
    rpcClient.updateServer(current!.config);
    List<dynamic>? enabledFeatures;
    String? version;
    return await rpcClient.connect().then((result) {
      if (result.success) {
        enabledFeatures = result.data["enabledFeatures"] as List<dynamic>?;
        version = result.data["version"];
        return rpcClient.getGlobalOption();
      }
      throw Exception();
    }).then((result) {
      if (result.success) {
        result.data
            .addAll({"version": version, "enabledFeatures": enabledFeatures});
        Aria2ServerConfig serverConfig =
            Aria2ServerConfig.fromJson(result.data);
        current?.serverConfig = serverConfig;
        startGlobalStatusTimer();
        notifyListeners();
        return true;
      }
      throw Exception();
    }).catchError((error) {
      Util.showErrorToast("Can not connect to server $name");
      return false;
    });
  }

  Future<bool> startTaskTimer(TaskStatus? status) async {
    if (current == null) {
      return false;
    }
    taskTimer.reBuild(duration1s, (timer, status) async {
      return rpcClient.tell(status!).then((result) {
        if (result.success) {
          updateTask(result.data, status!);
        }
        return result.success;
      });
    }, () {
      Util.showErrorToast("Can not connect to server ${current?.config.uri}");
    }, status);
    return true;
  }

  Future<bool> startGlobalStatusTimer() async {
    if (current == null) {
      return false;
    }

    globalStatusTimer.reBuild(duration1s, (timer, status) async {
      return rpcClient.tell(status!).then((result) {
        if (result.success) {
          globalStatus = Aria2GlobalStatus.fromJson(result.data);
        }
        return result.success;
      });
    }, () {
      Util.showErrorToast("Can not connect to server ${current?.config.uri}");
    });

    return true;
  }

  List<Task> getTaskList(TaskStatus status) {
    switch (status) {
      case TaskStatus.active:
        return activeTasks;
      case TaskStatus.waiting:
        return waitingTasks;
      case TaskStatus.paused:
        return pausedTasks;
      case TaskStatus.complete:
        return completeTasks;
      case TaskStatus.error:
        return errorTasks;
      case TaskStatus.removed:
        return removedTasks;
    }
  }

  void addTask(Task task) {
    List<Task> taskList = getTaskList(task.status);
    taskList.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    List<Task> taskList = getTaskList(task.status);
    taskList.remove(task);
    notifyListeners();
  }

  void updateTask(List<Task> tasks, TaskStatus status) {
    List<Task> taskList = getTaskList(status);
    for (int i = taskList.length - 1; i >= 0; i--) {
      Task value = taskList[i];
      int index = tasks.indexWhere((test) {
        return test.gid == value.gid;
      });
      if (index == -1) {
        taskList.remove(value);
      } else {
        value.update(tasks[index]);
        tasks.removeAt(index);
      }
    }
    for (Task task in tasks) {
      task.analysisTaskName();
      taskList.add(task);
    }
    notifyListeners();
  }

  bool processRpcRequest(RpcResult result, RpcRequestCallBack callback) {
    if (result.success) {
      disconnectCount = 0;
      callback(result.data);
      return true;
    }
    disconnectCount++;
    if (disconnectCount > 3) {
      Util.showErrorToast("Can not connect to server ${current?.config.uri}");
    }
    return false;
  }
}
