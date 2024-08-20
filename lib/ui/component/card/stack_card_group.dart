import 'package:aria2_client/ui/component/card/stack_card_item.dart';
import 'package:aria2_client/ui/component/card/stack_card_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StackCardGroup<T extends CardModel> extends StatefulWidget {
  final bool keepState;
  final T Function(int index) createModel;
  final CardTransform Function(int index, int length)? initialCardTransform;
  final void Function(T model, CardGroup<T> group)? initialCardBehavior;
  final void Function(CardGroup<T> group, List<Widget> children)?
      initialGroupBehavior;
  final Widget Function(T model, Widget child)? cardBuilder;
  final List<Widget> children;

  const StackCardGroup(
      {super.key,
      required this.children,
      required this.createModel,
      this.initialCardTransform,
      this.initialCardBehavior,
      this.initialGroupBehavior,
      this.cardBuilder,
      this.keepState = false});

  StackCardGroup.builder({
    super.key,
    required int itemCount,
    required Widget Function(int index) itemBuilder,
    required this.createModel,
    this.initialCardTransform,
    this.initialCardBehavior,
    this.initialGroupBehavior,
    this.cardBuilder,
    bool reverse = false,
    required this.keepState,
  }) : children = buildChildren(itemCount, itemBuilder, reverse);

  @override
  State<StatefulWidget> createState() {
    return _StackCardGroupState<T>();
  }

  static List<Widget> buildChildren(
      int itemCount, Widget Function(int index) itemBuilder, bool reverse) {
    List<Widget> children = [];
    for (int index = 0; index < itemCount; index++) {
      children.add(itemBuilder.call(index));
    }
    return reverse ? children.reversed.toList() : children;
  }
}

class _StackCardGroupState<T extends CardModel>
    extends State<StackCardGroup<T>> {
  late CardGroup<T> _group;
  late Offset _dragStartOffset;

  @override
  void initState() {
    _group = CardGroup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragStart: (details) {
          if (_group.behavior.isDisabled(IAction.drag)) {
            return;
          }
          _group.behavior.onVerticalDragStart?.call(details);
        },
        onVerticalDragUpdate: (details) {
          if (_group.behavior.isDisabled(IAction.drag)) {
            return;
          }
          _group.behavior.onVerticalDragUpdate?.call(details);
        },
        onVerticalDragEnd: (details) {
          if (_group.behavior.isDisabled(IAction.drag)) {
            return;
          }
          _group.behavior.onVerticalDragEnd?.call(details);
        },
        onHorizontalDragStart: (details) {
          if (_group.behavior.isDisabled(IAction.drag)) {
            return;
          }
          _group.behavior.onHorizontalDragStart?.call(details);
        },
        onHorizontalDragUpdate: (details) {
          if (_group.behavior.isDisabled(IAction.drag)) {
            return;
          }
          _group.behavior.onHorizontalDragUpdate?.call(details);
        },
        onHorizontalDragEnd: (details) {
          if (_group.behavior.isDisabled(IAction.drag)) {
            return;
          }
          _group.behavior.onHorizontalDragEnd?.call(details);
        },
        onTap: () {
          if (_group.behavior.isDisabled(IAction.tap)) {
            return;
          }
          _group.behavior.onTap?.call();
        },
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return ValueListenableBuilder<bool>(
              valueListenable: _group.refresh,
              builder: (context, value, child) {
                rebuildGroup();
                return Stack(
                  children: rebuildItems(constraints),
                );
              });
        }));
  }

  void rebuildGroup() {
    _group.reset(widget.keepState);
    Map<Widget, T> map = {};
    final children = widget.children;
    for (int index = 0; index < children.length; index++) {
      Widget child = children[index];
      T? model = _group.findModelByChild(child);
      bool needReset = model == null;
      model ??= widget.createModel(index);
      CardTransform? transform =
          widget.initialCardTransform?.call(index, widget.children.length);
      model.transform.copyOrigin(transform);
      needReset ? model.transform.reset() : true;
      widget.initialCardBehavior?.call(model, _group);

      model.index = index;
      map[child] = model;
    }
    _group.modelMap = map;
    widget.initialGroupBehavior?.call(_group, widget.children);
  }

  List<StackCardWidget> rebuildItems(BoxConstraints constraints) {
    final items = <StackCardWidget>[];
    _group.modelMap.forEach((key, value) {
      final item = StackCardWidget(
          key: UniqueKey(),
          index: value.index,
          group: _group,
          stackConstraints: constraints,
          cardBuilder: widget.cardBuilder,
          model: value,
          child: key);
      items.add(item);
    });
    items.sort((a, b) => a.index.compareTo(b.index));
    return items;
  }
}
