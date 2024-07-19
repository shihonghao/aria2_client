import 'package:aria2_client/net/rpc_result.dart';
import 'package:flutter/cupertino.dart';

void main() async {
  var result = test1().then((result) {
    if (result.success) {
      debugPrint(result.data.toString());
      return test3(() async {
        return true;
      });
    }
    throw Exception();
  }).catchError((error) {
    debugPrint(error.toString());
    return false;
  });

  debugPrint("result : $result");
}

Future<RpcResult> test1() async {
  return RpcResult.ok("aaaaaaaaaaaaaaa");
}

Future<RpcResult> test2() async {
  return RpcResult.error("bbbbbbbbbb");
}

bool test3(Future<bool> Function() savedCallback) {
  savedCallback();
  return false;
}

Future<RpcResult> test4() async {
  return RpcResult.ok("ccccccccccccc");
}
