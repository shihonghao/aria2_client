import 'aria2_config.dart';
import 'aria2_server_config.dart';

class Aria2 {
  //连接信息
  final Aria2Config config;

  //服务端配置
  Aria2ServerConfig serverConfig;

  Aria2({required this.config}) : serverConfig = Aria2ServerConfig.fromJson({});
}
