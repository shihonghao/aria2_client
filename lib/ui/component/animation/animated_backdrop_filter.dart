import 'dart:ui';

import 'package:flutter/cupertino.dart';

class AnimatedBackdropFilter extends ImplicitlyAnimatedWidget {
  double sigmaX;
  double sigmaY;
  Widget? child;

  AnimatedBackdropFilter(
      {super.key,
      required this.sigmaX,
      required this.sigmaY,
      this.child,
      super.curve,
      super.onEnd,
      required super.duration});

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedBackdropFilterState();
  }
}

class _AnimatedBackdropFilterState
    extends AnimatedWidgetBaseState<AnimatedBackdropFilter> {
  Tween<double>? _sigmaX;
  Tween<double>? _sigmaY;

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = this.animation;
    // return ClipRRect(
    //     borderRadius: const BorderRadius.all(Radius.circular(30)),
    //     child: BackdropFilter(
    //         filter: ImageFilter.blur(
    //             sigmaX: _sigmaX!.evaluate(animation),
    //             sigmaY: _sigmaY!.evaluate(animation)),
    //         child: widget.child));
    return BackdropFilter(
        filter: ImageFilter.blur(
            sigmaX: _sigmaX!.evaluate(animation),
            sigmaY: _sigmaY!.evaluate(animation)),
        child: widget.child);
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _sigmaX = visitor(_sigmaX, widget.sigmaX,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
    _sigmaY = visitor(_sigmaY, widget.sigmaY,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
  }
}
