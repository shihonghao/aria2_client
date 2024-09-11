import 'dart:ui';

import 'package:aria2_client/ui/component/animation/my_animation.dart';
import 'package:flutter/material.dart';

class MyClipOverlay extends MyAnimation {
  Widget? child;
  CustomClipper<Path>? clipper;
  MyAnimationCallback? onTap;
  Widget Function(
          Offset topLeft, Offset bottomRight, Animation<double> animation)?
      overlayContentBuilder;
  Widget Function(
      BuildContext context, Animation<double> animation, Widget? child) builder;

  MyClipOverlay(
      {super.key,
      this.clipper,
      this.child,
      this.onTap,
      this.overlayContentBuilder,
      required this.builder,
      super.duration});

  @override
  MyAnimationState createState() => MyClipOverlayState();
}

class MyClipOverlayState extends MyAnimationState<MyClipOverlay, double> {
  late OverlayEntry _entry;
  late bool _isDisplay;

  bool get isDisplay => _isDisplay;

  @override
  initAnimation() {
    controller = AnimationController(vsync: this, duration: widget.duration);
    //使用弹性曲线
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = animation.drive(Tween(begin: 0, end: 1.0));
  }

  @override
  void initState() {
    super.initState();
    _isDisplay = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: widget.builder(context, animation, widget.child));
  }

  display() {
    if (!_isDisplay) {
      MyClipper clipper = widget.clipper ?? buildClipper();
      _entry = OverlayEntry(builder: (context) {
        return GestureDetector(
            onTap: () {
              hidden();
            },
            child: SizedBox.expand(
              child: AnimatedBuilder(
                  animation: animation,
                  builder: (BuildContext context, Widget? child) {
                    return Stack(
                      children: [
                        ClipPath(
                            clipper: clipper,
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: 10 * animation.value,
                                  sigmaY: 10 * animation.value),
                              child: Container(
                                color: Colors.transparent,
                              ),
                            )),
                        FadeTransition(
                          opacity: animation,
                          child: CustomPaint(
                            painter: MyClipperPainter(clipper),
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        widget.overlayContentBuilder?.call(
                                Offset(clipper.left, clipper.top),
                                Offset(clipper.right, clipper.bottom),
                                animation) ??
                            Container()
                      ],
                    );
                  }),
            ));
      });
      Overlay.of(context).insert(_entry);
      controller.forward();
      _isDisplay = true;
    }
  }

  hidden() {
    controller.reverse().then((_) {
      _entry.remove();
    });

    _isDisplay = false;
  }

  buildClipper() {
    final RenderBox item = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        item.localToGlobal(const Offset(0, 0), ancestor: overlay),
        item.localToGlobal(item.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    return MyClipper(
        left: position.left,
        top: position.top,
        right: position.right,
        bottom: position.bottom,
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

class MyClipperPainter extends CustomPainter {
  MyClipper clipper;

  MyClipperPainter(this.clipper);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        Path()
          ..addRRect(RRect.fromRectAndRadius(
              Rect.fromPoints(
                  Offset(clipper.left, clipper.top),
                  Offset(size.width - clipper.right,
                      size.height - clipper.bottom)),
              clipper.radius))
          ..fillType = PathFillType.evenOdd,
        Paint()
          ..colorFilter =
              ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.srcIn)
          // ..strokeWidth = 1
          ..color = Colors.transparent
        // ..style = PaintingStyle.stroke
        );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
