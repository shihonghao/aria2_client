import 'package:aria2_client/net/rpc_result.dart';
import 'package:aria2_client/util/Util.dart';

import '../aria2/model/aria2_config.dart';
import 'aria2_request.dart';

class Aria2WebSocketRequest extends Aria2Request {
  @override
  disconnect(Aria2Config config) {
    // TODO: implement disconnect
    throw UnimplementedError();
  }

  @override
  Future<RpcResult> call(
      Aria2Config config, String method, List<dynamic>? params) {
    // TODO: implement call
    throw UnimplementedError();
  }

  @override
  Future connect(Aria2Config config) {
    // TODO: implement connect
    throw UnimplementedError();
  }

  @override
  Future<RpcResult> multiCall(
      Aria2Config config, List<Pair<String, List<dynamic>>> methods) {
    // TODO: implement multiCall
    throw UnimplementedError();
  }
}
