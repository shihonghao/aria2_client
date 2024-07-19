class RpcResult {
  bool success;

  dynamic data;

  String? message;

  factory RpcResult.ok([Object? data]) {
    return RpcResult(success: true, data: data);
  }

  factory RpcResult.error([String? message]) {
    return RpcResult(success: false, message: message);
  }

  RpcResult({required this.success, this.data, this.message});
}
