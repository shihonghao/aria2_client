import 'package:aria2_client/timer/my_timer.dart';

class MyTimerManager {
  MyTimerManager._();

  static MyTimerManager? _instance;

  static MyTimerManager get instance {
    _instance ??= MyTimerManager._();
    return _instance!;
  }

  final Map<String, MyTimer> _timers = {};

  Future<void> addTimer(String key, MyTimer timer) async {
    _timers[key] = timer;
  }

  Future<void> removeTimer(String key) async {
    _timers.remove(key)?.stop();
  }

  Future<void> startTimer(String key) async {
    _timers[key]?.resume();
  }

  Future<void> stopTimer(String key) async {
    _timers[key]?.stop();
  }

  Future<void> stopAll() async {
    _timers.forEach((key, timer) {
      timer.stop();
    });
  }
}
