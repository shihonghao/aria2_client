import 'package:aria2_client/ui/component/card/stack_card_model.dart';
import 'package:flutter/material.dart';

import '../animation/animated_backdrop_filter.dart';
import '../animation/animated_rotation_plus.dart';

class StackCardWidget<T extends CardModel> extends StatefulWidget {
  final int index;
  final Widget child;
  final BoxConstraints stackConstraints;
  final Widget Function(T model, Widget child)? cardBuilder;
  final T model;
  final CardGroup<T> group;

  const StackCardWidget(
      {super.key,
      required this.model,
      required this.index,
      required this.child,
      required this.group,
      this.cardBuilder,
      required this.stackConstraints});

  @override
  State<StatefulWidget> createState() {
    return StackCardWidgetState<T>();
  }
}

@protected
class StackCardWidgetState<T extends CardModel>
    extends State<StackCardWidget<T>> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    Duration duration = Duration(milliseconds: (1500 - (1000 ~/ widget.group.modelMap.length) * widget.index));
    if (widget.model.behavior.dualAnimationDuration != null) {
      duration =
          widget.model.behavior.dualAnimationDuration!.call(widget.model.index);
    }
    controller = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));

    if (widget.model.firstTime) {
      controller.forward().then((onValue) {
        widget.group.eventBus
            .notify("onFirstTimeEnd", widget.group, widget.model);
      });
      widget.model.firstTime = false;
    } else {
      controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    controller.reverse();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<INotify>(
        valueListenable: widget.model.refresh,
        builder: (BuildContext context, INotify value, Widget? child) {
          final model = widget.model;
          final transform = model.transform;
          final duration = value.duration;
          final size = getSize(transform.size.value);
          final cardSize = getSize(transform.cardSize.value);
          final cardChild = AnimatedBackdropFilter(
              curve: Curves.decelerate,
              duration: duration,
              sigmaX: transform.sigmaX.value,
              sigmaY: transform.sigmaY.value,
              onEnd: value.onFinish,
              child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  onTap: () {
                    if (model.behavior.isDisabled(IAction.tap)) {
                      return;
                    }
                    model.behavior.onTap?.call();
                  },
                  onDoubleTap: () {
                    if (model.behavior.isDisabled(IAction.doubleTap)) {
                      return;
                    }
                    model.behavior.onDoubleTap?.call();
                  },
                  onHover: (hovered) {
                    if (model.behavior.isDisabled(IAction.hover)) {
                      return;
                    }
                    model.behavior.onHover?.call(hovered);
                  },
                  child: child));
          Widget card;
          final themeData = Theme.of(context);
          if (widget.cardBuilder == null) {
            card = Card(
                color: Color.fromRGBO(36, 34, 39, transform.colorOpacity.value),
                elevation: 5,
                shadowColor: Colors.white38,
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: cardChild);
          } else {
            card = widget.cardBuilder!.call(model, cardChild);
          }
          return AnimatedPositioned(
            duration: duration,
            left: calculateLeft(size.width),
            top: calculateTop(size.height),
            onEnd: value.onFinish,
            child: AnimatedRotation(
              turns: transform.angle.value,
              alignment: Alignment.bottomRight,
              duration: duration,
              onEnd: value.onFinish,
              child: AnimatedRotationPlus(
                  axis: AxisPlus.y,
                  alignment: Alignment.centerLeft,
                  curve: Curves.decelerate,
                  turns: transform.rotate.value,
                  duration: duration,
                  onEnd: value.onFinish,
                  child:
                  AnimatedOpacity(
                    curve: Curves.decelerate,
                    duration: duration,
                    opacity: transform.opacity.value,
                    onEnd: value.onFinish,
                    child: AnimatedScale(
                      curve: Curves.decelerate,
                      scale: transform.scale.value,
                      duration: duration,
                      onEnd: value.onFinish,
                      child: AnimatedContainer(
                        curve: Curves.decelerate,
                        duration: duration,
                        width: size.width,
                        height: size.height,
                        onEnd: value.onFinish,
                        child: Center(
                          child: AnimatedContainer(
                            curve: Curves.decelerate,
                            duration: duration,
                            width: cardSize.width,
                            height: cardSize.height,
                            child: DualTransitionBuilder(
                              animation:
                                  model.behavior.dualAnimation ?? animation,
                              forwardBuilder:
                                  model.behavior.dualForwardTransitionBuilder ??
                                      defaultDualForwardTransitionBuilder(),
                              reverseBuilder:
                                  model.behavior.dualReverseTransitionBuilder ??
                                      defaultDualReverseTransitionBuilder(),
                              child: GestureDetector(
                                  onPanStart: (details) {
                                    if (model.behavior
                                        .isDisabled(IAction.pan)) {
                                      return;
                                    }
                                    model.behavior.onPanStart?.call(details);
                                  },
                                  onPanUpdate: (details) {
                                    if (model.behavior
                                        .isDisabled(IAction.pan)) {
                                      return;
                                    }
                                    model.behavior.onPanUpdate?.call(details);
                                  },
                                  onPanEnd: (details) {
                                    if (model.behavior
                                        .isDisabled(IAction.pan)) {
                                      return;
                                    }
                                    model.behavior.onPanEnd?.call(details);
                                  },
                                  child: card),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
          );
        },
        child: widget.child);
  }

  calculateLeft(double width) {
    final model = widget.model;
    switch (model.alignment) {
      case Alignment.topLeft:
      case Alignment.centerLeft:
      case Alignment.bottomLeft:
        return model.transform.offset.value.dx;
      case Alignment.topCenter:
      case Alignment.center:
      case Alignment.bottomCenter:
        return model.transform.offset.value.dx +
            (widget.stackConstraints.maxWidth / 2 - width / 2);
      case Alignment.topRight:
      case Alignment.centerRight:
      case Alignment.bottomRight:
        return widget.stackConstraints.maxWidth -
            width -
            model.transform.offset.value.dx;
    }
  }

  calculateTop(double height) {
    final model = widget.model;
    switch (model.alignment) {
      case Alignment.topLeft:
      case Alignment.topCenter:
      case Alignment.topRight:
        return model.transform.offset.value.dy;
      case Alignment.centerLeft:
      case Alignment.center:
      case Alignment.centerRight:
        return model.transform.offset.value.dy +
            (widget.stackConstraints.maxHeight / 2 - height / 2);
      case Alignment.bottomLeft:
      case Alignment.bottomCenter:
      case Alignment.bottomRight:
        return widget.stackConstraints.maxHeight -
            height -
            model.transform.offset.value.dy;
    }
  }

  defaultDualForwardTransitionBuilder() {
    return (BuildContext context, Animation<double> animation, Widget? child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    };
  }

  defaultDualReverseTransitionBuilder() {
    return (BuildContext context, Animation<double> animation, Widget? child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(animation),
        child: child,
      );
    };
  }

  getSize(Size size) {
    final width = size.width > widget.stackConstraints.maxWidth
        ? widget.stackConstraints.maxWidth
        : size.width;
    final height = size.height > widget.stackConstraints.maxHeight
        ? widget.stackConstraints.maxHeight
        : size.height;
    return Size(width, height);
  }
}
