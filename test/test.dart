import 'package:aria2_client/aria2/aria2_constants.dart';
import 'package:aria2_client/aria2/model/aria2_config.dart';
import 'package:aria2_client/net/aria2_http_request.dart';
import 'package:aria2_client/net/aria2_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('', () async {
    Aria2Request req = Aria2HttpRequest();

   await req.call(
        Aria2Config(
            key: "111",
            name: "aa",
            protocol: Aria2Constants.PROTOCOL_HTTPS,
            domain: "hhsmtx.dynv6.net",
            port: 441,
            secret: "Birthday19",
            path: "/aria2/s/jsonrpc"),
        "aria2.getVersion",
        []).then((result) {
      debugPrint(result.data.toString());
    });
  });
}
