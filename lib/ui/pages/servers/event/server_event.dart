import '../../../../event/base_event.dart';

enum ServerEventType {
  CHECK_AVAILABLE,
  CHANGE_CURRENT;
}

class ServerEvent<T> extends BaseEvent {
  ServerEventType eventType;

  ServerEvent(
      {super.key,
        super.scope,
        super.value,
        super.callBack,
        required this.eventType});
}
