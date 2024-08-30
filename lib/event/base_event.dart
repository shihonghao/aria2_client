enum EventScope { Single, All }

typedef EventValueCallBack<T> = Function(T value);

abstract class BaseEvent<T> {
  String key;
  T? value;

  BaseEvent({required this.key, this.value});
}

class CheckAvailableEvent extends BaseEvent {
  CheckAvailableEvent() : super(key: 'CHECK_AVAILABLE');
}
