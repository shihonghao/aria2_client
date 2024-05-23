import 'package:aria2_client/model/task.dart';

enum Protocol { http, https, websocket, websocketSecure }

class Aria2 {
  Protocol? protocol;
  String domain;
  int port;
  String? secret;
  String? path;
  bool isDefault;

  Aria2({
    this.protocol = Protocol.http,
    required this.domain,
    required this.port,
    this.secret,
    this.path = "/jsonrpc",
    this.isDefault = false
  });

  List<Task> tell(TaskStatus status) {
    switch (status) {
      case TaskStatus.active:
        return tellActive();
        break;
      case TaskStatus.waiting:
        return tellWaiting();
        break;
      case TaskStatus.paused:
        return tellStopped();
        break;
      case TaskStatus.complete:
        return tellComplete();
        break;
      default:
        return [];
    }
  }

  List<Task> tellActive() {
    return [];
  }

  List<Task> tellWaiting() {
    return [];
  }

  List<Task> tellStopped() {
    return [];
  }

  List<Task> tellComplete() {
    return [];
  }
}
