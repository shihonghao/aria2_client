import 'package:json_annotation/json_annotation.dart';

import 'aria2_config.dart';
import 'aria2_server_config.dart';
part 'aria2.g.dart';

@JsonSerializable()
class Aria2 {
  //连接信息
  Aria2Config config;

  //服务端配置
  Aria2ServerConfig? serverConfig;

  Aria2({required this.config});


  factory Aria2.fromJson(Map<String, dynamic> json) =>
      _$Aria2FromJson(json);

  Map<String, dynamic> toJson() => _$Aria2ToJson(this);
}
