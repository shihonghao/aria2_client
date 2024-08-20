import 'package:aria2_client/net/aria2_rpc_client.dart';
import 'package:flutter/cupertino.dart';

import '../aria2/model/aria2.dart';
import '../aria2/model/aria2_global_status.dart';
import '../util/Util.dart';

class ServerModel extends ChangeNotifier {
  final String key;
  bool isMonitoring = false;
  bool isAvailable = false;
  bool isTesting = false;
  bool isCurrent = false;
  bool keepNetWorking = false;
  Aria2 aria2;
  bool shouldDispose = true;
  DateTime? lastTimestamps;

  ServerModel({required this.aria2})
      : key = Util.generateId("serverCard");

  Aria2GlobalStatus globalStatus = Aria2GlobalStatus(
      downloadSpeed: 0,
      uploadSpeed: 0,
      numActive: 0,
      numWaiting: 0,
      numStopped: 0,
      numStoppedTotal: 0);

  setAvailable(bool available) {
    isAvailable = available;
    if (isAvailable == false) {
      setMonitoring(false);
    }
    notifyListeners();
  }

  setTesting(bool testing) {
    isTesting = testing;
    notifyListeners();
  }

  setCurrent(bool current) {
    if (isCurrent != current) {
      isCurrent = current;
      notifyListeners();
    }
  }

  setKeepNetWorking(bool keepNetWorking) {
    keepNetWorking = keepNetWorking;
    notifyListeners();
  }

  setMonitoring(bool monitoring) {
    isMonitoring = monitoring;
    notifyListeners();
  }

  updateGlobalStatus(Aria2GlobalStatus info) {
    globalStatus = info;
    notifyListeners();
  }

  void resetGlobalStatus() {
    globalStatus = Aria2GlobalStatus(
        downloadSpeed: 0,
        uploadSpeed: 0,
        numActive: 0,
        numWaiting: 0,
        numStopped: 0,
        numStoppedTotal: 0);
  }

  Future<bool> checkServerAvailable([bool force = false]) async {
    DateTime currentTimestamp = DateTime.timestamp();
    if (force ||
        lastTimestamps == null ||
        currentTimestamp.difference(lastTimestamps!).inMinutes > 5) {
      setTesting(true);
      lastTimestamps = currentTimestamp;
      await Future.delayed(const Duration(seconds: 1));
      var available = false;
      return await Aria2RpcClient.instance.connect(aria2.config).then((result) {
        if (result.success) {
          return true;
        }
        throw Exception();
      }).catchError((error) {
        Util.showErrorToast(
            "Can not connect to Aria2 ${aria2.config.uri.toString()}");
        return false;
      }).then((isAvailable) {
        available = isAvailable;
        return available;
      }).whenComplete(() {
        setTesting(false);
        setAvailable(available);
      });
    } else {
      return isAvailable;
    }
  }

  @override
  void dispose() {
    if (!shouldDispose) {
      shouldDispose = true;
      return;
    }
    super.dispose();
  }
}
