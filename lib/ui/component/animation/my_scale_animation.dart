import 'dart:ui';

import 'package:aria2_client/ui/component/animation/my_animation.dart';
import 'package:flutter/material.dart';

class MyScaleAnimation extends MyAnimation {
  final Widget child;
  final MyAnimationCallback? onLongPress;

  const MyScaleAnimation(
      {super.key, super.duration, required this.child, this.onLongPress});

  @override
  MyAnimationState createState() {
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
        child:
        Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(animation.value * 0.1 + 1),
            child: widget.child)
    );
  }

  @override
  initAnimation() {
    controller = AnimationController(
        vsync: this, duration: widget.duration);
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
      if (tmp == AnimationStatus.forward && status ==AnimationStatus.completed) {
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
    final RenderBox card = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        card.localToGlobal(const Offset(0, 0), ancestor: overlay),
        card.localToGlobal(card.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    return Positioned(
        left: position.left,
        top: position.top,
        right: position.right,
        bottom: position.bottom,
        child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(1.1),
            child: widget.child));
  }
}
