import 'package:json_annotation/json_annotation.dart';

import '../aria2_constants.dart';
part 'aria2_config.g.dart';
@JsonSerializable()
class Aria2Config {
  String name;
  String protocol;
  String domain;
  int port;
  String? secret;
  String? path;
  Uri uri;
  bool isDefault = false;

  Aria2Config(
      {required this.name,
      this.protocol = Aria2Constants.PROTOCOL_HTTP, this.domain = "127.0.0.1",
      this.port = 6800,
      this.secret,
      this.path = "/jsonrpc",
      isDefault = false})
      : uri = Uri.parse("$protocol"
            "://"
            "$domain"
            ":"
            "$port$path");

  buildUri() {
    uri = Uri.parse("$protocol"
        "://"
        "$domain"
        ":"
        "$port$path");
  }

  factory Aria2Config.fromJson(Map<String, dynamic> json) =>
      _$Aria2ConfigFromJson(json);

  Map<String, dynamic> toJson() => _$Aria2ConfigToJson(this);
}
