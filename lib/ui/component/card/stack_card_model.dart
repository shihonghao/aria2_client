import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Direction { left, right, top, bottom }

enum IAction { hover, exit, tap, doubleTap, drag, longPress, scale, pan, none }

enum IStatus { hovered, taped, doubleTaped, exited }

typedef StackCardCallback<T extends CardModel> = void Function(
    CardGroup<T> group, T model);

class CardGroup<T extends CardModel> extends ChangeNotifier {
  CardGroup()
      : _refresh = ValueNotifier(false),
        modelMap = {},
        behavior = GroupBehavior(),
        eventBus = StackCardEventBus();

  final StackCardEventBus<T> eventBus;

  final GroupBehavior behavior;

  T? lastSelectedModel;

  T? selectedModel;

  Map<Widget, T> modelMap;

  final ValueNotifier<bool> _refresh;

  ValueNotifier<bool> get refresh => _refresh;

  void reset(bool keepState) {
    if (!keepState) {
      modelMap.clear();
      lastSelectedModel = null;
      selectedModel = null;
    }
  }

  refreshUI() {
    _refresh.value = !_refresh.value;
  }

  T? findModelByChild(Widget child) {
    return modelMap[child];
  }

  findModelByIndex(int index) {
    return modelMap.values.firstWhere((ele) => ele.index == index);
  }
}

class IStack<T> {
  final List<T> _items = [];

  IStack.builder({List<T>? items}) {
    if (items != null) {
      _items.addAll(items);
    }
  }

  /// Adds an item to the top of the stack.
  void push(T item) {
    _items.add(item);
  }

  /// Removes and returns the top item from the stack.
  T pop() {
    if (isEmpty) throw Exception('Stack is empty');
    return _items.removeLast();
  }

  /// Returns the top item from the stack without removing it.
  T peek() {
    if (isEmpty) throw Exception('Stack is empty');
    return _items.last;
  }

  /// Checks if the stack is empty.
  bool get isEmpty => _items.isEmpty;

  /// Returns the number of items in the stack.
  int get length => _items.length;

  /// Clears all items from the stack.
  void clear() {
    _items.clear();
  }
}

class Transformed<T> {
  T _origin;
  IStack<T> history;
  T _value;

  get origin => _origin;

  get value => _value;

  Transformed.clone(Transformed<T> origin)
      : _value = origin.value,
        history = origin.history,
        _origin = origin.origin;

  Transformed.from(origin)
      : _value = origin,
        history = IStack.builder(),
        _origin = origin;

  back() {
    if (history.isEmpty) return;
    _value = history.pop();
  }

  transform(T value) {
    this.history.push(value);
    this._value = value;
  }

  reset() {
    _value = _origin;
    history.clear();
  }

  void copyOrigin(T value) {
    _origin = value;
  }
}

class CardTransform {
  final Transformed<Size> _size;
  final Transformed<Size> _cardSize;
  final Transformed<Offset> _offset;
  final Transformed<double> _angle;
  final Transformed<double> _opacity;
  final Transformed<double> _colorOpacity;
  final Transformed<double> _sigmaX;
  final Transformed<double> _sigmaY;
  final Transformed<double> _scale;
  final Transformed<double> _rotate;

  Transformed<Size> get size => _size;

  Transformed<Size> get cardSize => _cardSize;

  Transformed<Offset> get offset => _offset;

  Transformed<double> get angle => _angle;

  Transformed<double> get opacity => _opacity;

  Transformed<double> get colorOpacity => _colorOpacity;

  Transformed<double> get sigmaX => _sigmaX;

  Transformed<double> get sigmaY => _sigmaY;

  Transformed<double> get scale => _scale;

  Transformed<double> get rotate => _rotate;

  CardTransform.clone({required CardTransform other})
      : _size = Transformed.clone(other.size),
        _cardSize = Transformed.clone(other.cardSize),
        _offset = Transformed.clone(other.offset),
        _angle = Transformed.clone(other.angle),
        _opacity = Transformed.clone(other.opacity),
        _colorOpacity = Transformed.clone(other.colorOpacity),
        _sigmaX = Transformed.clone(other.sigmaX),
        _sigmaY = Transformed.clone(other.sigmaY),
        _scale = Transformed.clone(other.scale),
        _rotate = Transformed.clone(other.rotate);

  CardTransform reset() {
    final transformed = CardTransform.clone(other: this);
    size.reset();
    cardSize.reset();
    offset.reset();
    angle.reset();
    opacity.reset();
    colorOpacity.reset();
    sigmaX.reset();
    sigmaY.reset();
    scale.reset();
    rotate.reset();
    return transformed;
  }

  back() {
    size.back();
    offset.back();
    angle.back();
    opacity.back();
    colorOpacity.back();
    sigmaX.back();
    sigmaY.back();
    scale.back();
    rotate.back();
  }

  copyOrigin(CardTransform? other) {
    if (other == null) {
      return;
    }
    size.copyOrigin(other.size.origin);
    cardSize.copyOrigin(other.cardSize.origin);
    offset.copyOrigin(other.offset.origin);
    angle.copyOrigin(other.angle.origin);
    opacity.copyOrigin(other.opacity.origin);
    colorOpacity.copyOrigin(other.colorOpacity.origin);
    sigmaX.copyOrigin(other.sigmaX.origin);
    sigmaY.copyOrigin(other.sigmaY.origin);
    scale.copyOrigin(other.scale.origin);
    rotate.copyOrigin(other.rotate.origin);
  }

  CardTransform(
      {Size size = Size.zero,
      Size cardSize = Size.zero,
      Offset offset = Offset.zero,
      double angle = 0.0,
      double opacity = 1.0,
      double colorOpacity = 1.0,
      double sigmaX = 0.0,
      double sigmaY = 0.0,
      double scale = 1.0,
      double rotate = 0.0})
      : _size = Transformed.from(size),
        _cardSize = Transformed.from(cardSize),
        _offset = Transformed.from(offset),
        _angle = Transformed.from(angle),
        _sigmaX = Transformed.from(sigmaX),
        _sigmaY = Transformed.from(sigmaY),
        _colorOpacity = Transformed.from(colorOpacity),
        _opacity = Transformed.from(opacity),
        _scale = Transformed.from(scale),
        _rotate = Transformed.from(rotate);
}

class IQueueEntry<T> {
  final ValueChanged<T> fn;
  final Duration duration;
  final bool refreshUI;

  IQueueEntry(
      {required this.fn, required this.duration, required this.refreshUI});
}

class UIBuilder<T> {
  final Queue<IQueueEntry<T>> _queue;
  final T _value;
  final Duration _duration;

  // final ValueChanged<ValueChanged<Duration>> _onRefresh;
  final Function(Duration duration, VoidCallback onFinish) _onRefresh;

  UIBuilder(
      {ValueChanged<T>? first,
      bool? firstAutoRefresh,
      required Duration duration,
      required T value,
      required Function(Duration duration, VoidCallback onFinish) onRefresh})
      : _value = value,
        _duration = duration,
        _onRefresh = onRefresh,
        _queue = Queue.from(first != null
            ? [
                IQueueEntry(
                  fn: first,
                  duration: duration,
                  refreshUI: firstAutoRefresh ?? true,
                )
              ]
            : []);

  UIBuilder<T> then(ValueChanged<T> fn,
      {Duration? duration, bool? autoRefresh}) {
    _queue.add(IQueueEntry(
        fn: fn,
        duration: duration ?? _duration,
        refreshUI: autoRefresh ?? true));
    return this;
  }

  execute() async {
    if (_queue.isEmpty) {
      return;
    }
    final entry = _queue.removeFirst();
    entry.fn.call(_value);
    _onRefresh.call(entry.duration, () {
      execute();
    });
  }
}

class INotify {
  Duration duration;
  VoidCallback? onFinish;

  INotify(this.duration, {this.onFinish});
}

abstract class IBehavior {
  final Set<IAction> disabledActions;

  GestureTapCallback? onTap;

  GestureTapDownCallback? onTapDown;

  GestureTapUpCallback? onTapUp;

  GestureTapCallback? onDoubleTap;

  GestureLongPressCallback? onLongPress;

  GestureDragDownCallback? onVerticalDragDown;

  GestureDragStartCallback? onVerticalDragStart;

  GestureDragUpdateCallback? onVerticalDragUpdate;

  GestureDragEndCallback? onVerticalDragEnd;

  GestureDragDownCallback? onHorizontalDragDown;

  GestureDragStartCallback? onHorizontalDragStart;

  GestureDragUpdateCallback? onHorizontalDragUpdate;

  GestureDragEndCallback? onHorizontalDragEnd;

  GestureDragDownCallback? onPanDown;

  GestureDragStartCallback? onPanStart;

  GestureDragUpdateCallback? onPanUpdate;

  GestureDragEndCallback? onPanEnd;

  IBehavior({
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onDoubleTap,
    this.onLongPress,
    this.onVerticalDragDown,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onHorizontalDragDown,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onPanDown,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
  }) : disabledActions = <IAction>{};

  void disable([List<IAction>? actions]) {
    disabledActions.addAll(actions ?? IAction.values);
  }

  void enable([List<IAction>? actions]) {
    disabledActions.removeAll(actions ?? IAction.values);
  }

  bool isDisabled(IAction actions) {
    return disabledActions.contains(actions);
  }

  void reset() {
    disabledActions.clear();
  }
}

class CardBehavior extends IBehavior {
  ValueChanged<bool>? onHover;

  Animation<double>? dualAnimation;

  AnimatedTransitionBuilder? dualForwardTransitionBuilder;

  AnimatedTransitionBuilder? dualReverseTransitionBuilder;

  Duration Function(int index)? dualAnimationDuration;

  CardBehavior({
    super.onTap,
    super.onTapDown,
    super.onTapUp,
    super.onDoubleTap,
    super.onLongPress,
    this.onHover,
    this.dualAnimation,
    this.dualForwardTransitionBuilder,
    this.dualReverseTransitionBuilder,
    this.dualAnimationDuration,
  });
}

class GroupBehavior extends IBehavior {
  GroupBehavior({
    super.onTap,
    super.onHorizontalDragStart,
    super.onHorizontalDragEnd,
    super.onVerticalDragStart,
    super.onVerticalDragEnd,
    super.onPanStart,
    super.onPanUpdate,
    super.onPanEnd,
  });
}

abstract class CardModel {
  CardModel(
      {this.alignment = Alignment.center,
      this.duration = const Duration(milliseconds: 500)})
      : transform = CardTransform(),
        firstTime = true,
        id = generateId("model"),
        behavior = CardBehavior(),
        _refresh = ValueNotifier(INotify(const Duration(milliseconds: 500)));

  final String id;

  late int index;

  final CardTransform transform;

  final CardBehavior behavior;

  final ValueNotifier<INotify> _refresh;

  final Duration duration;

  final Alignment alignment;

  ValueNotifier<INotify> get refresh => _refresh;

  bool firstTime;

  int compareTo(CardModel selectedModel) =>
      index.compareTo(selectedModel.index);

  UIBuilder<CardTransform> updateUI(ValueChanged<CardTransform> fn,
      [Duration? duration]) {
    return UIBuilder<CardTransform>(
        first: fn,
        duration: duration ?? this.duration,
        onRefresh: refreshUI,
        value: transform);
  }

  static generateId(String prefix) {
    var round = (DateTime.now().millisecond / 1000).round();
    String sourceId = '${prefix}_'
        '$round'
        '_${Random().nextInt(1000000000)}';
    var hashedId = base64Encode(utf8.encode(sourceId));
    return hashedId;
  }

  refreshUI(Duration? duration, VoidCallback? onFinish) {
    _refresh.value = INotify(duration ?? this.duration, onFinish: onFinish);
  }

  void reset() {
    transform.reset();
    behavior.reset();
  }
}

class MyDefaultItemModel extends CardModel {
  int doubleTapCount;
  int tapCount;
  bool isHovered;
  bool isExpend;

  MyDefaultItemModel({super.alignment})
      : tapCount = 0,
        doubleTapCount = 0,
        isHovered = false,
        isExpend = false,
        super();

  @override
  void reset() {
    super.reset();
    tapCount = 0;
    isHovered = false;
    isExpend = false;
  }
}

class StackCardEventBus<T extends CardModel> {
  StackCardEventBus()
      : _listeners = {},
        _localListeners = {};

  final Map<String, List<StackCardCallback<T>>> _listeners;

  final Map<T, Map<String, List<StackCardCallback<T>>>> _localListeners;

  void addListener(String key, StackCardCallback<T> listener) {
    _listeners[key] ??= [];
    _listeners[key]!.add(listener);
  }

  void addLocalListener(T model, String key, StackCardCallback<T> listener) {
    _localListeners[model] ??= {};
    _localListeners[model]![key] ??= [];
    _localListeners[model]![key]!.add(listener);
  }

  void removeLocalListener(T model, String key, StackCardCallback<T> listener) {
    _localListeners[model]?[key]?.remove(listener);
  }

  void removeListener(String key, StackCardCallback<T> listener) {
    _listeners[key]?.remove(listener);
  }

  void notifyLocal(T model, String key, CardGroup<T> group) {
    _localListeners[model]?[key]?.forEach((listener) {
      listener(group, model);
    });
  }

  void notify(String key, CardGroup<T> group, T model) {
    _listeners[key]?.forEach((listener) {
      listener(group, model);
    });
  }

  void dispose() {
    _listeners.clear();
  }
}
