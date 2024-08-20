import 'package:hive/hive.dart';
import '../aria2_constants.dart';

part 'aria2_config.g.dart';

@HiveType(typeId: 1)
class Aria2Config {
  @HiveField(0)
  final String key;
  @HiveField(1)
  String name;
  @HiveField(2)
  String protocol;
  @HiveField(3)
  String domain;
  @HiveField(4)
  int port;
  @HiveField(5)
  String? secret;
  @HiveField(6)
  String path;
  Uri? _uri;
  bool isDefault = false;

  Aria2Config(
      {required this.key,
      required this.name,
      this.protocol = Aria2Constants.PROTOCOL_HTTP,
      String? domain,
      int? port,
      this.secret,
      String? path,
      isDefault = false})
      : path = path ?? "/jsonrpc",
        port = port ?? 6800,
        domain = domain ?? "127.0.0.1";

  Uri uri() {
    _uri = Uri.parse("$protocol"
        "://"
        "$domain"
        ":"
        "$port$path");
    return _uri!;
  }
}
