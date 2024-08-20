import 'package:flutter/cupertino.dart';

typedef MyAnimationCallback<T> = T Function();

enum MyAnimationDirection {
  upDown,
  leftRight,
}

enum MyAnimationAction { tap, longPress, hover }

abstract class MyAnimation extends StatefulWidget {
  final Duration duration;
  final Curve curve;
  final bool auto;
  final bool repeat;

  const MyAnimation({
    super.key,
    this.duration = const Duration(seconds: 1),
    this.curve = Curves.linear,
    this.auto = false,
    this.repeat = false
  });

  @override
  MyAnimationState createState();
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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  initAnimation();
}
