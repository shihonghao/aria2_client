import 'dart:math';

import 'package:flutter/cupertino.dart';

class AnimatedRotationPlus extends AnimatedRotation {
  AxisPlus axis;

  AnimatedRotationPlus({
    super.key,
    required this.axis,
    super.child,
    required super.turns,
    super.alignment = Alignment.center,
    super.filterQuality,
    super.curve,
    required super.duration,
    super.onEnd,
  });

  @override
  ImplicitlyAnimatedWidgetState<AnimatedRotation> createState() =>
      _AnimatedRotationStateX();
}

class _AnimatedRotationStateX
    extends ImplicitlyAnimatedWidgetState<AnimatedRotationPlus> {
  Tween<double>? _turns;
  late Animation<double> _turnsAnimation;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _turns = visitor(_turns, widget.turns,
            (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
  }

  @override
  void didUpdateTweens() {
    _turnsAnimation = animation.drive(_turns!);
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransitionPlus(
      axis: widget.axis,
      turns: _turnsAnimation,
      alignment: widget.alignment,
      filterQuality: widget.filterQuality,
      child: widget.child,
    );
  }
}

enum AxisPlus { x, y, z }

class RotationTransitionPlus extends MatrixTransition {
  AxisPlus axis;

  /// Creates a rotation transition.
  RotationTransitionPlus({
    required this.axis,
    super.key,
    required Animation<double> turns,
    super.alignment = Alignment.center,
    super.filterQuality,
    super.child,
  }) : super(animation: turns, onTransform: buildTransForm(axis));

  /// The animation that controls the rotation of the child.
  Animation<double> get turns => animation;

  static buildTransForm(AxisPlus axis) {
    switch (axis) {
      case AxisPlus.x:
        return (double value) => Matrix4.identity()..setEntry(3, 2, 0.001)..rotateX(value * pi );
      case AxisPlus.y:
        return (double value) => Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(value * pi );
      case AxisPlus.z:
        return (double value) => Matrix4.identity()..setEntry(3, 2, 0.001)..rotateZ(value * pi );
    }
  }
}
