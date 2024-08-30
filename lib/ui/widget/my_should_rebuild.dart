import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef MyShouldRebuildFunction<T> = bool Function(T oldValue, T newValue);
typedef MyShouldRebuildChildBuilder<T> = Widget Function(
    BuildContext context, T value,Widget? child);

class MyShouldRebuild<T> extends StatefulWidget {
  final MyShouldRebuildFunction<T>? shouldRebuild;
  final MyShouldRebuildChildBuilder<T> builder;
  final ValueListenable<T> listenable;
  final Widget? child;

  const MyShouldRebuild(
      {super.key,
      required this.listenable,
      required this.builder,
      this.shouldRebuild,
      this.child});

  @override
  State<StatefulWidget> createState() => _MyShouldRebuildState<T>();
}

class _MyShouldRebuildState<T> extends State<MyShouldRebuild> {
  Widget? oldWidget;
  late T oldValue;

  @override
  void initState() {
    super.initState();
    oldValue = widget.listenable.value;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.listenable,
        builder: (context, value, child) {
          if (this.oldWidget == null ||
              (widget.shouldRebuild == null
                  ? true
                  : widget.shouldRebuild!(oldValue, value))) {
            this.oldValue = value;
            this.oldWidget = widget.builder.call(context, value,widget.child);
          }
          return oldWidget!;
        });
  }
}
