enum EventScope { Single, All }

typedef EventValueCallBack<T> = Function(T value);

abstract class BaseEvent<T> {
  String? key;
  EventScope scope;
  T? value;
  EventValueCallBack<T?>? callBack;

  executeCallback() {
    callBack?.call(value);
  }

  BaseEvent(
      {this.key, this.value, this.scope = EventScope.Single, this.callBack})
      : assert(scope == EventScope.Single ? key != null : true,
            "event key can not be null with Single scope");
}
