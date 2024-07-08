import 'dart:ui';

import 'package:aria2_client/ui/component/animation/my_animation.dart';
import 'package:flutter/material.dart';

class MyClipOverlay extends MyAnimation {
  Widget? overlayContent;
  Widget child;
  CustomClipper<Path> clipper;
  MyAnimationCallback? onTap;

  MyClipOverlay(
      {super.key,
      required this.clipper,
      required this.child,
      this.overlayContent,
      this.onTap,
      super.duration});

  @override
  State<MyClipOverlay> createState() => _MyClipOverlayState();
}

class _MyClipOverlayState extends MyAnimationState<MyClipOverlay, double> {
  late OverlayEntry entry;

  @override
  initAnimation() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration));
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  display() {
    MyClipper clipper = buildClipper();
    Widget content = widget.overlayContent ?? Container();
    entry = OverlayEntry(builder: (context) {
      return FadeTransition(
        opacity: CurvedAnimation(
          parent: controller,
          curve: Curves.easeIn,
        ),
        child: GestureDetector(
            onTap: () {
              hidden();
            },
            child: SizedBox.expand(
              child: ClipPath(
                clipper: clipper,
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Material(
                      color: const Color.fromRGBO(0, 0, 0, 0),
                      child: content,
                    )),
              ),
            )),
      );
    });
    Overlay.of(context).insert(entry);
  }

  hidden() {
    controller.reverse().then((value) {
      entry.remove();
    });
  }

  buildClipper() {
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
    return MyClipper(
        left: position.left + 10,
        top: position.top + 10,
        right: position.right + 10,
        bottom: position.bottom + 10,
        radius: const Radius.circular(30));
  }
}

class MyClipper extends CustomClipper<Path> {
  double left;
  double top;
  double right;
  double bottom;
  Radius radius;

  MyClipper(
      {required this.left,
      required this.top,
      required this.right,
      required this.bottom,
      required this.radius});

  @override
  Path getClip(Size size) {
    debugPrint("$left, $top, $right, $bottom");
    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromPoints(Offset(left, top),
              Offset(size.width - right, size.height - bottom)),
          radius))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
