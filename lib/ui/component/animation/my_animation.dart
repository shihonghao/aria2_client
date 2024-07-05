import 'package:flutter/cupertino.dart';

typedef MyAnimationCallback<T> = T Function();

enum MyAnimationDirection {
  upDown,
  leftRight,
}

enum MyAnimationAction { tap, longPress, hover }

abstract class MyAnimation extends StatefulWidget {
  final int duration;

  const MyAnimation({
    super.key,
    this.duration = 500,
  });
}

abstract class MyAnimationState<T extends StatefulWidget, R> extends State<T>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<R> animation;
  AnimationStatus lastStatus = AnimationStatus.dismissed;

  @override
  initState() {
    super.initState();
    initAnimation();
  }

  initAnimation();
}
