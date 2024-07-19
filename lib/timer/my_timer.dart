import 'dart:async';
import 'dart:ui';

import 'package:aria2_client/static/vars.dart';

class MyTimer<T> {
  Timer? timer;

  Duration duration;

  T? data;

  Future<bool> Function(Timer timer, T? value) onTime;

  VoidCallback? onError;

  int failedCount = 0;

  int maxFailedCount;

  MyTimer(
      {required this.onTime,
      this.onError,
      required this.duration,
      this.data,
      this.maxFailedCount = 3});

  factory MyTimer.empty() {
    return MyTimer(
        onTime: (_, __) async {
          return true;
        },
        duration: duration100ms);
  }

  pause() {
    timer?.cancel();
  }

  bool resume() {
    timer = _buildTimer();
    return true;
  }

  restart() {
    stop();
    resume();
  }

  Timer _buildTimer() {
    return Timer.periodic(duration, (timer) {
      onTime.call(timer, data).then((success) {
        if (success) {
          failedCount = 0;
        } else {
          failedCount++;
        }
        if (failedCount > maxFailedCount) {
          stop();
          onError?.call();
        }
      });
    });
  }

  reBuild(
      Duration duration, Future<bool> Function(Timer timer, T? value) onTime,
      [VoidCallback? onError, T? data, int? maxFailedCount]) {
    stop();
    this.data = data;
    this.duration = duration;
    this.onTime = onTime;
    this.onError = onError;
    if (maxFailedCount != null) {
      this.maxFailedCount = maxFailedCount;
    }
    timer = _buildTimer();
  }

  stop() {
    timer?.cancel();
  }
}
