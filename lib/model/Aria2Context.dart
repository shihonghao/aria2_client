import 'aria2.dart';

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
}
