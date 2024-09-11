// import 'dart:math';
// import 'dart:ui' as ui;
// import 'package:aria2_client/providers/application.dart';
// import 'package:flutter/material.dart';
//
// class MyStarEffects extends StatefulWidget {
//   final double? width;
//   final double? height;
//   final int count;
//   final int starCount;
//   final double? speed;
//   final Widget? child;
//   final Alignment? alignment;
//   final Color? backgroundColor;
//   final double? pointWidth;
//   final double? pointHeight;
//   final Offset? originOffset;
//
//   // const MyStarEffects({super.key,
//   //   this.child,
//   //   this.width,
//   //   this.height,
//   //   this.count = 100,
//   //   this.starCount = 100,
//   //   this.speed,
//   //   this.radians = 0,
//   //   this.pointHeight,
//   //   this.pointWidth,
//   //   this.backgroundColor = Colors.transparent});
//
//   const MyStarEffects.liner(
//       {super.key,
//       this.width,
//       this.height,
//       required this.count,
//       required this.starCount,
//       this.speed,
//       this.child,
//       required this.alignment,
//       this.backgroundColor = Colors.transparent,
//       this.pointWidth,
//       this.pointHeight})
//       : originOffset = null;
//
//   const MyStarEffects.cycle(
//       {super.key,
//       this.width,
//       this.height,
//       this.originOffset,
//       required this.count,
//       required this.starCount,
//       this.speed,
//       this.child,
//       this.backgroundColor = Colors.transparent,
//       this.pointWidth,
//       this.pointHeight})
//       : alignment = null;
//
//   @override
//   State<StatefulWidget> createState() {
//     return _MyStarEffectsState();
//   }
// }
//
// class _Point {
//   Offset offset;
//   Color color;
//   double? sigma;
//
//   _Point({required this.offset, required this.color, this.sigma});
// }
//
// class _MyStarEffectsState extends State<MyStarEffects>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _animationController;
//   late final Animation<double> _animation;
//   late final List<_Point> points;
//   late final List<_Point> bgStars;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController =
//         AnimationController(vsync: this, duration: const Duration(seconds: 1));
//     _animation =
//         Tween<double>(begin: -1.0, end: 1.0).animate(_animationController);
//     _animationController.repeat();
//     points = [];
//     bgStars = [];
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final width = widget.width ?? constraints.maxWidth;
//         final height = widget.height ?? constraints.maxHeight;
//         double speed =
//             widget.speed ?? (width / (Application.instance.fps ?? 60));
//
//         initBgStarts(width, height);
//         initMovingStarts(width, height);
//
//         return AnimatedBuilder(
//           animation: _animation,
//           builder: (context, child) {
//             rebuildPoints(width, height, speed);
//             return CustomPaint(
//               painter: _StarPainter(
//                   animationValue: _animation.value,
//                   points: points,
//                   bgStars: bgStars,
//                   speed: speed,
//                   width: width,
//                   height: height,
//                   pointWidth: widget.pointWidth ?? 100,
//                   pointHeight: widget.pointHeight ?? 5),
//               child: Container(
//                 width: width,
//                 height: height,
//                 color: widget.backgroundColor,
//                 child: widget.child,
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   void rebuildPoints(double width, double height, double speed) {
//     for (var value in points) {
//       if (value.offset.dy > height) {
//         value.offset = Offset(
//             (Random.secure().nextInt(10000) / 10000) * width, -width / 4);
//       } else {
//         // value.offset =  Offset(value.offset.dx + speed, value.offset.dy);
//         value.offset = value.offset + Offset.fromDirection(pi / 4, speed);
//       }
//
//       // if (value.offset.dx < width / 2) {
//       //   value.color = value.color
//       //       .withOpacity(1 - (value.offset.dx - width / 2).abs() / width / 2);
//       // }
//     }
//   }
//
//   Offset randomOffset(
//       double minWidth, double maxWidth, double minHeight, double maxHeight) {
//     return Offset(
//         minWidth +
//             (Random.secure().nextInt(1000) / 1000) * (maxWidth - minWidth),
//         minHeight +
//             (Random.secure().nextInt(1000) / 1000) * (maxHeight - minHeight));
//   }
//
//   void initBgStarts(double width, double height) {
//     for (int i = 0; i < widget.count; i++) {
//       bgStars.add(_Point(
//           offset: randomOffset(width, height),
//           color: Colors.white.withOpacity(Random.secure().nextDouble()),
//           sigma: Random.secure().nextDouble() * 3));
//     }
//   }
//
//   void initMovingStarts(double width, double height) {
//     for (int i = 0; i < widget.count; i++) {
//       if (widget.originOffset != null) {
//         final originPoint =
//             widget.originOffset ?? Offset(width / 2, height / 2);
//         Offset offset =
//             randomOffset(-originPoint.dx, width, -originPoint.dy, height);
//       } else {}
//       Offset offset = randomOffset(width, width, height, height);
//
//       Offset baseOffset;
//
//       switch(widget.alignment){
//         case Alignment.centerRight:
//           baseOffset = Offset(0, offset.dy);
//           break;
//         case Alignment.centerLeft:
//           baseOffset = Offset(width,offset.dy);
//           break;
//         case Alignment.topRight:
//         case Alignment.topLeft:
//           baseOffset = Offset(offset.dx,height);
//           break;
//         case Alignment.bottomRight:
//         case Alignment.bottomLeft:
//           baseOffset = Offset(offset.dx,0);
//           break;
//         default : baseOffset = Offset.zero;
//       }
//
//       final randomColor = Color.fromRGBO(Random.secure().nextInt(255),
//               Random.secure().nextInt(255), Random.secure().nextInt(255), 1)
//           .withOpacity(offset - baseOffset);
//
//       points.add(_Point(offset: rf, color: randomColor));
//     }
//   }
// }
//
// class _StarPainter extends CustomPainter {
//   final double animationValue;
//   final List<_Point> points;
//   final List<_Point> bgStars;
//   final double speed;
//   final double width;
//   final double height;
//   final double pointWidth;
//   final double pointHeight;
//
//   _StarPainter(
//       {required this.animationValue,
//       required this.points,
//       required this.bgStars,
//       required this.speed,
//       required this.width,
//       required this.height,
//       required this.pointWidth,
//       required this.pointHeight});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()..style = PaintingStyle.fill;
//     canvas.clipRect(Offset.zero & size);
//     for (var value in points) {
//       canvas.save();
//       Offset lt = Offset(value.offset.dx - pointWidth / 2, value.offset.dy);
//       Offset br = Offset(
//           value.offset.dx + pointWidth / 2, value.offset.dy + pointHeight);
//       paint.shader = ui.Gradient.linear(
//           lt, br, [value.color.withOpacity(0.1), value.color]);
//       paint.color = value.color;
//       // canvas.drawCircle(Offset(value.offset.dx, value.offset.dy), 2, paint);
//       // canvas.translate( width/2, 0);
//       // canvas.rotate(pi/4);
//       paint.strokeWidth = 2;
//       // canvas.drawRRect(
//       //     RRect.fromRectAndRadius(
//       //         Rect.fromPoints(
//       //           lt,
//       //           br,
//       //         ),
//       //         const Radius.circular(30)),
//       //     paint);
//       lt = value.offset;
//       br = value.offset + Offset.fromDirection(pi / 4, pointWidth);
//       paint.shader = ui.Gradient.linear(
//           lt, br, [value.color.withOpacity(0.1), value.color]);
//       canvas.drawLine(lt, br, paint);
//       // canvas.drawLine(Offset(value.offset.dx - 50, value.offset.dy),
//       //     Offset(value.offset.dx + 50, value.offset.dy), paint);
//       canvas.restore();
//     }
//     canvas.save();
//     for (var star in bgStars) {
//       canvas.drawCircle(
//           star.offset,
//           2,
//           Paint()
//             ..color = star.color
//             ..style = PaintingStyle.fill
//             ..maskFilter = MaskFilter.blur(BlurStyle.normal, star.sigma!));
//     }
//     canvas.restore();
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }
