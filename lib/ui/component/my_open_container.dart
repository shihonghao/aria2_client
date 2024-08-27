import 'package:animations/animations.dart';
import 'package:aria2_client/const/Const.dart';
import 'package:flutter/material.dart';

class MyOpenContainer extends StatefulWidget {
  final CloseContainerBuilder closedBuilder;
  final OpenContainerBuilder openBuilder;
  final ShapeBorder closedShape;

  const MyOpenContainer({
    super.key,
    required this.closedBuilder,
    required this.openBuilder,
    this.closedShape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  });

  @override
  State<StatefulWidget> createState() {
    return _MyOpenContainerState();
  }
}

class _MyOpenContainerState extends State<MyOpenContainer> {
  Widget? closeWidget;
  Widget? openWidget;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedShape: widget.closedShape,
      closedBuilder: closeBuilderProxy,
      openBuilder: openBuilderProxy,
      closedColor: Colors.transparent,
      openColor: Colors.transparent,
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: Const.duration2s,
      tappable: false,
    );
  }

  Widget closeBuilderProxy(context, action) {
    if (closeWidget == null) {
      closeWidget = widget.closedBuilder(context, action);
    } else {
      widget.closedBuilder(context, action);
    }
    return closeWidget!;
  }

  Widget openBuilderProxy(context, action) {
    if (openWidget == null) {
      openWidget = widget.openBuilder(context, action);
    } else {
      widget.openBuilder(context, action);
    }
    return openWidget!;
  }
}
