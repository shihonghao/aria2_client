import 'dart:ui';

import 'package:flutter/material.dart';

class MyTransparentPageRoute extends PageRoute {
  Duration duration;
  final WidgetBuilder builder;

  MyTransparentPageRoute(
      {required this.builder,
      this.duration = const Duration(milliseconds: 500)});

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget content = builder(context);
    return Material(
      color: const Color.fromRGBO(255, 255, 255, 0),
      child: FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(animation),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: content),
          )
      ),
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;
}
