import 'dart:async';
import 'dart:convert';

import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:aria2_client/aria2/model/aria2_global_status.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:aria2_client/timer/my_timer.dart';
import 'package:flutter/cupertino.dart';

import '../aria2/model/aria2.dart';
import '../aria2/model/aria2_server_config.dart';
import '../model/task.dart';
import '../util/SharedPreferencesUtil.dart';

class Aria2Model extends ChangeNotifier {
  final List<Aria2> aria2s = List.empty(growable: true);

  Aria2RpcClient rpcClient;

  Aria2? current;

  MyTimer taskTimer;

  MyTimer globalStatusTimer;

  TaskStatus? subscribeStatus;

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
        taskTimer = MyTimer(),
        globalStatusTimer = MyTimer();

  init() async {
    aria2s.clear();
    final config = await SharedPreferencesUtil.getData<String>("aria2");
    parseConfig(config);
    aria2s.add(Aria2(
        config: Aria2Config(
            name: 'hhsmtx',
            domain: 'hhsmtx.dynv6.net',
            port: 441,
            path: "/aria2/s/jsonrpc",
            secret: "Birthday19",
            protocol: "https",
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
    try {
      clear();
      current = aria2s.firstWhere((element) => element.config.name == name);
      rpcClient.updateServer(current!.config);
      var result = await rpcClient.connect();
      if (result == false) {
        return false;
      }
      var enabledFeatures = result["enabledFeatures"] as List<dynamic>?;
      var version = result["version"];
      var options = await rpcClient.getGlobalOption();
      options.addAll({"version": version, "enabledFeatures": enabledFeatures});
      Aria2ServerConfig serverConfig = Aria2ServerConfig.fromJson(options);
      current?.serverConfig = serverConfig;
      startGlobalStatusTimer();
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
    return true;
  }

  Future<bool> startTaskTimer(TaskStatus? status) async {
    if (current == null) {
      return false;
    }
    taskTimer.reStart(1, status, (timer, value) async {
      rpcClient.tell(value!).then((tasks) {
        updateTask(tasks, value!);
      });
    });
    return true;
  }

  Future<bool> startGlobalStatusTimer() async {
    if (current == null) {
      return false;
    }
    globalStatusTimer.reStart(1, null, (timer, value) async {
      rpcClient.getGlobalStatus().then((result) {
        globalStatus = Aria2GlobalStatus.fromJson(result);
      });
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
}
