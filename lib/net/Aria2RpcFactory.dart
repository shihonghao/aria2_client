import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:aria2_client/net/aria2_rpc_client.dart';

class Aria2RpcFactory {
  static Aria2RpcClient create(Aria2Config config) {
    Aria2RpcClient client = Aria2RpcClient(config: config);
    return client;
  }
}
