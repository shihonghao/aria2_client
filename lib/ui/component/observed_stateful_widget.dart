import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ObservedStatefulWidget extends StatefulWidget {
  final FrameCallback? onPostFrame;
  final Widget child;

  const ObservedStatefulWidget(
      {super.key, required this.child, this.onPostFrame});

  @override
  State<StatefulWidget> createState() {
    return _ObservedStatefulWidgetState();
  }
}

class _ObservedStatefulWidgetState extends State<ObservedStatefulWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback(widget.onPostFrame ?? (_) {});
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
