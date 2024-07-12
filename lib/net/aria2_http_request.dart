import 'dart:convert';

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
  Future<dynamic> call(Aria2Config config, String method, List<dynamic>? params) async {
    List<dynamic> args = [];
    if (config.secret != null) {
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
    try {
      final response =
          await http.post(config.uri, headers: headers, body: body);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['result'];
      } else {
        throw Exception('Failed to connect to server: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to server: $e');
    }
  }

  @override
  Future<dynamic> connect(Aria2Config config) async {
    return call(config, "aria2.getVersion", []);
  }
}
