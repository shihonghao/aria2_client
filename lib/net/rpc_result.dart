

class RpcResult {
  int status;

  dynamic body;

  Error? error;

  RpcResult({required this.status, this.body, this.error});
}
