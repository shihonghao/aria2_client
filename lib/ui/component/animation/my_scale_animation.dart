import 'dart:ui';

import 'package:aria2_client/ui/component/animation/my_animation.dart';
import 'package:flutter/material.dart';

class MyScaleAnimation extends MyAnimation {
  final Widget child;
  final MyAnimationCallback? onLongPress;
  final MyAnimationCallback<RelativeRect> supplyPosition;

  const MyScaleAnimation(
      {super.key,
      super.duration,
      required this.child,
      required this.supplyPosition,
      this.onLongPress});

  @override
  State<StatefulWidget> createState() {
    return _MyScaleAnimationState();
  }
}

class _MyScaleAnimationState
    extends MyAnimationState<MyScaleAnimation, double> {
  late OverlayEntry entry;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        widget.onLongPress?.call();
        handleAction();
      },
      child: widget.child

      // Transform(
      //     alignment: Alignment.center,
      //     transform: Matrix4.identity()..scale(animation.value * 0.1 + 1),
      //   child:
      //     ),
    );
  }

  @override
  initAnimation() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    //使用弹性曲线
    animation = CurvedAnimation(parent: super.controller, curve: Curves.linear);
    animation = Tween(begin: 0.0, end: 1.0).animate(super.controller);

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    super.controller.addStatusListener((status) {
      if (status == lastStatus) return;
      var tmp = lastStatus;
      lastStatus = status;
      if (status == AnimationStatus.forward) {
        // if (tmp == AnimationStatus.forward) {
        entry = OverlayEntry(builder: (context) {
          return FadeTransition(
            opacity: CurvedAnimation(
              parent: controller,
              curve: Curves.easeIn,
            ),
            child: GestureDetector(
                onTap: () {
                  controller.reverse().then((value) {
                    entry.remove();
                  });
                },
                child: SizedBox.expand(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Material(
                        color: const Color.fromRGBO(0, 0, 0, 0),
                        child: Stack(children: [
                          buildChildPosition(),
                        ]),
                      )),
                )),
          );
        });
        Overlay.of(context).insert(entry);
      }
      // }
      lastStatus = status;
    });
  }

  void handleAction() {
    if (super.controller.isAnimating) {
      return;
    } else {
      super.controller.forward();
    }
  }

  buildChildPosition() {
    RelativeRect position = widget.supplyPosition.call();
    return Positioned(
        left: position.left,
        top: position.top,
        right: position.right,
        bottom: position.bottom,
        child: widget.child);
  }
}
