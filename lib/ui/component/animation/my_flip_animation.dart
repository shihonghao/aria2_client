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
  MyFlipAnimationController? flipController;

  MyFlipAnimation(
      {super.key,
      super.duration,
      required this.front,
      required this.back,
      this.onTap,
      this.beforeForward,
      this.beforeReverse,
      this.direction = MyAnimationDirection.leftRight,
      this.flipController});

  @override
  MyAnimationState createState() {
    return _MyFlipAnimationState();
  }
}

class _MyFlipAnimationState extends MyAnimationState<MyFlipAnimation, double> {
  // 定义一个翻转从左往右，为false，如果为true，则从右往左开始翻转
  late bool _flipReversal;
  late bool _isDisposed;

  late MyFlipAnimationController _flipController;

  @override
  initAnimation() {
    _isDisposed = false;
    _flipReversal = false;
    controller = AnimationController(
        vsync: this, duration: widget.duration);
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
    _flipController = widget.flipController ?? MyFlipAnimationController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          widget.onTap?.call();
          cardFlip(_flipReversal);
        },
        child: ValueListenableBuilder<MyFlipAnimationModel>(
          valueListenable: _flipController,
          builder: (BuildContext context, MyFlipAnimationModel value,
              Widget? child) {
            widget.onTap?.call();
            cardFlip(value.status);
            return child!;
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
          ),
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

class MyFlipAnimationModel {
  bool status;

  MyFlipAnimationModel() : status = true;
}

class MyFlipAnimationController extends ValueNotifier<MyFlipAnimationModel> {
  MyFlipAnimationController({MyFlipAnimationModel? value})
      : super(value ?? MyFlipAnimationModel());

  flip() {
    value.status = !value.status;
    notifyListeners();
  }
}
