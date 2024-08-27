import 'package:aria2_client/ui/component/animation/my_animation.dart';
import 'package:flutter/material.dart';

import '../../../const/Const.dart';

typedef MyAnimatedIconTransitionBuilder = Widget Function(
    Widget child, AnimationController controller, Animation<double> animation);

class MyAnimatedIcon extends MyAnimation {
  final IconData icon;
  final MyAnimatedIconTransitionBuilder transitionBuilder;
  final Color? color;
  final double? size;
  final void Function(AnimationController controller)? onTap;

  const MyAnimatedIcon(
      {super.key,
      super.duration,
      super.curve,
      super.auto,
      super.repeat,
      required this.icon,
      this.transitionBuilder = defaultTransactionBuilder,
      this.size,
      this.color,
      this.onTap});

  @override
  MyAnimationState createState() {
    return _MyAnimatedIconState();
  }

  static Widget defaultTransactionBuilder(Widget child,
      AnimationController controller, Animation<double> animation) {
    animation.addListener(() {

      if (animation.value >0.5) {
        controller.animateTo(0);
      }

    });
    return ScaleTransition(
      scale: animation
          .drive(CurveTween(curve: const Interval(0.0,0.5)))
          .drive(Tween(begin: 1.0, end: 0.8)),
      child: child,
    );
  }
}

class _MyAnimatedIconState extends MyAnimationState<MyAnimatedIcon, double> {
  @override
  void initState() {
    super.initState();
    if (widget.repeat) {
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    }
    if (widget.auto) {
      controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap?.call(controller);
      },
      child: widget.transitionBuilder(
          Icon(
            widget.icon,
            size: widget.size,
            color: widget.color,
          ),
          controller,
          animation),
    );
  }

  @override
  initAnimation() {
    controller = AnimationController(vsync: this, duration: widget.duration);
    animation = CurvedAnimation(parent: controller, curve: widget.curve);
  }
}
