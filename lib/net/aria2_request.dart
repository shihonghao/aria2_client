import 'dart:convert';
import 'dart:math';

import 'package:aria2_client/net/aria2_http_request.dart';
import 'package:aria2_client/net/aria2_websocket_request.dart';
import 'package:aria2_client/net/rpc_result.dart';
import 'package:aria2_client/util/Util.dart';

import '../aria2/aria2_constants.dart';
import '../aria2/model/aria2_config.dart';

abstract class Aria2Request {
  connect(Aria2Config config);

  disconnect(Aria2Config config);

  Future<RpcResult> call(
      Aria2Config config, String method, List<dynamic>? params);

  Future<RpcResult> multiCall(
      Aria2Config config, List<Pair<String, List<dynamic>>> methods);

  static final Map<String, Aria2Request> cachedRequest = {};

  static void register(String protocol, Aria2Request request) {
    Aria2Request.cachedRequest[protocol] = request;
  }

  static Aria2Request getRequest(Aria2Config config) {
    return cachedRequest[config.protocol] ?? Aria2HttpRequest();
  }
}
