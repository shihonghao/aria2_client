import 'dart:async';

class MyTimer<T> {
  Timer? timer;

  int savedSecond;

  T? savedValue;

  Function(Timer timer, T? value) savedCallback;

  MyTimer(
      {required this.savedCallback,
      required this.savedSecond,
      this.savedValue});

  static MyTimer Empty() {
    return MyTimer(savedCallback: (_, __) {}, savedSecond: 0);
  }

  pause() {
    timer?.cancel();
  }

  bool resume() {
    timer = Timer.periodic(Duration(seconds: savedSecond), (timer) {
      savedCallback.call(timer, savedValue);
    });
    return true;
  }

  restart() {
    stop();
    timer = Timer.periodic(Duration(seconds: savedSecond), (timer) {
      savedCallback(timer, savedValue);
    });
  }

  reBuild(int seconds, T? value, Function(Timer timer, T? value) callback) {
    stop();
    savedValue = value;
    timer = Timer.periodic(Duration(seconds: seconds), (timer) {
      callback(timer, savedValue);
    });
    savedSecond = seconds;
    savedCallback = callback;
    resume();
  }

  stop() {
    timer?.cancel();
  }
}
