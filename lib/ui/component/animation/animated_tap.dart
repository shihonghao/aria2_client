import 'package:aria2_client/const/Const.dart';
import 'package:aria2_client/ui/component/animation/my_animation.dart';
import 'package:flutter/material.dart';

class AnimatedTap extends MyAnimation {
  final Widget? child;
  final GestureTapCallback? onTap;

  const AnimatedTap({
    super.key,
    this.child,
    this.onTap,
  });

  @override
  MyAnimationState<StatefulWidget, dynamic> createState() {
    return _AnimatedTap();
  }
}

class _AnimatedTap extends MyAnimationState<AnimatedTap, dynamic> {

  @override
  initAnimation() {
    controller = AnimationController(vsync: this, duration: Const.duration200ms);
    animation = Tween<double>(begin: 1.0, end: 0.8).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.forward().then((_){
          controller.reverse().then((_){
            widget.onTap?.call();
          });
        });
      },
      child: ScaleTransition(scale: animation as Animation<double>, child: widget.child),
    );
  }
}
