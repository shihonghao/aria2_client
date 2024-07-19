import 'dart:convert';
import 'dart:math';

import 'package:aria2_client/net/aria2_http_request.dart';
import 'package:aria2_client/net/aria2_websocket_request.dart';

import '../aria2/aria2_constants.dart';
import '../aria2/model/aria2_config.dart';


abstract class Aria2Request {

  connect(Aria2Config config);

  disconnect(Aria2Config config);

  call(Aria2Config config,String method, List<dynamic>? params);

  static buildRequest(protocol){
     switch (protocol) {
      case Aria2Constants.PROTOCOL_HTTP:
      case Aria2Constants.PROTOCOL_HTTPS:
        return Aria2HttpRequest();
      case Aria2Constants.PROTOCOL_WEBSOCKET:
      case Aria2Constants.PROTOCOL_WEBSOCKET_SECURE:
        return  Aria2WebSocketRequest();
      default:
        return Aria2HttpRequest();
    }
  }


}