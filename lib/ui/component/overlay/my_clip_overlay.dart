import 'package:flutter/cupertino.dart';

class MyClipOverlay extends StatelessWidget {
  Widget child;
  CustomClipper<Path> clipper;

  MyClipOverlay({super.key, required this.clipper, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: clipper,
      child: child,
    );
  }
}
