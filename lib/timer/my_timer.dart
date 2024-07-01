import 'dart:async';

class MyTimer<T> {
  Timer? timer;

  int? savedSecond;

  T? savedValue;

  Function(Timer timer, T? value)? savedCallback;

  pause() {
      timer?.cancel();
  }

  bool resume() {
    if ( savedCallback != null && savedSecond != null){
      timer = Timer.periodic(Duration(seconds: savedSecond!), (timer) {
        savedCallback?.call(timer, savedValue);
      });
      return true;
    }
    return false;
  }

  reStart(int seconds,T? value, Function(Timer timer, T ? value) callback) {
    stop();
    savedValue = value;
    timer = Timer.periodic(Duration(seconds: seconds), (timer) {
      callback(timer, savedValue);
    });
    savedSecond = seconds;
    savedCallback = callback;
  }

  stop() {
    timer?.cancel();
    savedCallback = null;
    savedSecond = null;
    savedValue = null;
  }
}

