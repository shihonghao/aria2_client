import 'package:aria2_client/framework/lifecycle.dart';
import 'package:aria2_client/timer/my_timer.dart';
import 'package:aria2_client/timer/my_timer_manager.dart';
import 'package:flutter/material.dart';

abstract class MyTimerState<T extends StatefulWidget>
    extends LifecycleRouteState<T> with WidgetsBindingObserver {
  final String _timerKey;

  MyTimerState() : _timerKey = UniqueKey().toString();

  MyTimer initTimer();

  startTimer() {
    MyTimerManager.instance.startTimer(_timerKey);
  }

  pauseTimer() {
    MyTimerManager.instance.stopTimer(_timerKey);
  }

  removeTimer() {
    MyTimerManager.instance.removeTimer(_timerKey);
  }

  @override
  void onPause() {
    pauseTimer();
    super.onPause();
  }

  @override
  void onResume() {
    startTimer();
    super.onResume();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    MyTimerManager.instance.addTimer(_timerKey, initTimer());
  }

  @override
  void dispose() {
    removeTimer();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
