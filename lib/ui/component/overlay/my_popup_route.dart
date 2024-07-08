import 'package:flutter/material.dart';

class MyPopupRoute extends PopupRoute {
  final Widget child;
  Duration duration;
  final String tag;

  MyPopupRoute(
      {required this.tag,
      required this.child,
      this.duration = const Duration(milliseconds: 100)});

  @override
  Color? get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                // 设置一个容器组件，是整屏幕的。
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent, // 它的颜色为透明色
              ),
              Positioned(
                  child: SizedBox(
                width: 300,
                height: 300,
                child: Hero(
                  tag: tag,
                  child: child,
                ),
              ))
            ],
          ),
        ));
  }

  @override
  // TODO: implement transitionDuration
  Duration get transitionDuration => duration;
}
