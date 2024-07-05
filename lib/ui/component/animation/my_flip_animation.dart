import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'my_animation.dart';

class MyFlipAnimation extends MyAnimation {
  final Widget front;
  final Widget back;
  final MyAnimationCallback? onTap;
  final MyAnimationCallback? beforeForward;
  final MyAnimationCallback? beforeReverse;
  final MyAnimationDirection direction;

  const MyFlipAnimation({
    super.key,
    super.duration = 500,
    required this.front,
    required this.back,
    this.onTap,
    this.beforeForward,
    this.beforeReverse,
    this.direction = MyAnimationDirection.leftRight,
  });

  @override
  State<StatefulWidget> createState() {
    return _MyFlipAnimationState();
  }
}

class _MyFlipAnimationState extends MyAnimationState<MyFlipAnimation, double> {
  // 定义一个翻转从左往右，为false，如果为true，则从右往左开始翻转
  bool _flipReversal = false;
  bool _isDisposed = false;

  @override
  initAnimation() {
    _isDisposed = false;
    _flipReversal = false;
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    controller.addStatusListener((status) {
      if (status == lastStatus) return;
      lastStatus = status;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onTap?.call();
          cardFlip(_flipReversal);
        },
        child: Transform(
          alignment: Alignment.center,
          transform: buildTransform(),
          child: IndexedStack(
              sizing: StackFit.expand,
              textDirection: TextDirection.rtl,
              index: animation.value * pi < pi / 2.0 ? 0 : 1,
              children: [
                widget.front,
                Transform(
                    alignment: Alignment.center,
                    transform: buildReverseTransform(),
                    child: widget.back),
              ]),
        ));
  }

  void cardFlip(bool reverse) {
    if (_isDisposed == true) {
      return;
    }

    if (controller.isAnimating) return;
    if (reverse) {
      widget.beforeReverse?.call();
      controller.reverse();
    } else {
      widget.beforeForward?.call();
      controller.forward();
    }
    _flipReversal = !_flipReversal;
  }

  @override
  void dispose() {
    controller.dispose();
    _isDisposed = true;
    super.dispose();
  }

  buildTransform() {
    if (widget.direction == MyAnimationDirection.upDown) {
      return Matrix4.identity()..rotateX(animation.value * pi);
    } else {
      return Matrix4.identity()..rotateY(animation.value * pi);
    }
  }

  buildReverseTransform() {
    if (widget.direction == MyAnimationDirection.upDown) {
      return Matrix4.identity()..rotateX(pi);
    } else {
      return Matrix4.identity()..rotateY(pi);
    }
  }
}
