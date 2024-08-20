import 'dart:convert';

import 'package:aria2_client/net/rpc_result.dart';
import 'package:http/http.dart' as http;

import '../aria2/aria2_constants.dart';
import '../aria2/model/aria2_config.dart';
import '../util/Util.dart';
import 'aria2_request.dart';

class Aria2HttpRequest extends Aria2Request {
  @override
  disconnect(Aria2Config config) async {
    return true;
  }

  @override
  Future<RpcResult> call(
      Aria2Config config, String method, List<dynamic>? params,
      {bool needSecret = true}) async {
    List<dynamic> args = [];
    if (config.secret != null && needSecret) {
      args.add("token:${config.secret}");
    }
    args.addAll(params as Iterable<dynamic>);
    final headers = {'content-type': 'application/json'};
    final body = jsonEncode({
      'jsonrpc': '2.0',
      'method': method,
      'params': args,
      'id': Util.generateId(Aria2Constants.APP_PREFIX),
      // Unique identifier for the request
    });
    final uri = config.uri();
    try {
      final response = await http.post(uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return RpcResult.ok(jsonDecode(
            const Utf8Decoder().convert(response.bodyBytes))['result']);
      } else {
        throw Exception();
      }
    } catch (e) {
      return RpcResult.error('Failed to connect to server ${config.uri}');
    }
  }

  @override
  Future<RpcResult> connect(Aria2Config config) async {
    return call(config, "aria2.getVersion", []);
  }

  @override
  Future<RpcResult> multiCall(
      Aria2Config config, List<Pair<String, List<dynamic>>> methods) {
    List<dynamic> params = [];
    for (var value in methods) {
      List<dynamic> args = [];
      if (config.secret != null) {
        args.add("token:${config.secret}");
      }
      args.addAll(value.second as Iterable<dynamic>);
      params.add({"methodName": value.first, "params": args});
    }
    return call(config, "system.multicall", [params], needSecret: false);
  }
}
