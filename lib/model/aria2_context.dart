import 'dart:convert';

import 'package:aria2_client/util/SharedPreferencesUtil.dart';

import 'aria2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Aria2Context {
  static Aria2Context? _instance;

  Aria2Context._internal();

  static Aria2Context getInstance() {
    _instance ??= Aria2Context._internal();
    return _instance!;
  }

  Map<String, Aria2> aria2Map = {};

  Aria2? currentAria2;

  Aria2 getAria2(String key) {
    return aria2Map[key]!;
  }

  void addAria2(String key, Aria2 aria2) {
    aria2Map[key] = aria2;
  }

  void removeAria2(String key) {
    aria2Map.remove(key);
  }

  switchAria2(String key) {
    currentAria2 = aria2Map[key];
  }

  Aria2Context();

  void loadLocalConfig() async {
    aria2Map.clear();
    SharedPreferencesUtil.getData("aria2_servers").then((value) {
      if (value != null) {
        var serverJsonStr = value as String;
        var serverJson = jsonDecode(serverJsonStr);
        for (var server in serverJson) {
          var protocol = server["protocol"] == "http"
              ? Protocol.http
              : server["protocol"] == "https"
                  ? Protocol.https
                  : server["protocol"] == "websocket"
                      ? Protocol.websocket
                      : Protocol.websocketSecure;
          var aria2 = Aria2(
              domain: server["domain"],
              port: server["port"],
              secret: server["secret"],
              protocol: protocol,
              path: server["path"],
              isDefault: server["isDefault"]);
          aria2Map[server["name"]] = aria2;
          if(aria2.isDefault){

          }
        }
      }
    });
  }
}
