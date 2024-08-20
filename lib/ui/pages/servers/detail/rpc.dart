part of 'detail_page.dart';

buildRpc(BuildContext context, Aria2ServerConfig config) {
  return FormGroup(
      title: 'RPC',
      style: FormGroupStyle(
        backgroundColor: Theme.of(context).splashColor,
        collapsedBackgroundColor: Theme.of(context).highlightColor,
        textColor: Theme.of(context).primaryColor,
        elevation: 3,
      ),
      leading: const CircleAvatar(
        backgroundColor: Colors.lightGreen,
        child: Text(
          'R',
          style: TextStyle(color: Colors.white),
        ),
      ),
      items: [
        //启用 JSON-RPC/XML-RPC 服务器(enable-rpc)
        FormItem<bool>(
            label: '启用 RPC',
            type: FormItemType.switch_,
            value: config.enableRpc,
            key: 'enable-rpc',
            readOnly: true,
            tooltip:
                "启用 JSON-RPC/XML-RPC 服务器. 此选项仅影响 JSON-RPC/XML-RPC 服务器, 不影响 WebSocket 服务器. 此选项仅影响 JSON-RPC/XML-RPC 服务器, 不影响 WebSocket 服务器. 此选项仅影响JSON-RPC/XML-RPC 服务器, 不影响 WebSocket 服务器."),
        //种子文件下载完后暂停(pause-metadata) tooltip:'当种子文件下载完成后暂停后续的下载. 在 aria2 中有 3 种种子文件的下载类型: (1) 下载 .torrent 文件. (2) 通过磁链下载的种子文件. (3) 下载 Metalink 文件. 这些种子文件下载完后会根据文件内容继续进行下载. 此选项会暂停这些后续的下载. 此选项仅当 --enable-rpc 选项启用时生效.'
        FormItem<bool>(
            label: '种子文件下载完后暂停',
            type: FormItemType.switch_,
            value: config.pauseMetadata,
            key: 'pause-metadata',
            tooltip:
                "当种子文件下载完成后暂停后续的下载. 在 aria2 中有 3 种种子文件的下载类型: (1) 下载 .torrent 文件. (2) 通过磁链下载的种子文件. (3) 下载 Metalink 文件. 这些种子文件下载完后会根据文件内容继续进行下载. 此选项会暂停这些后续的下载. 此选项仅当 --enable-rpc 选项启用时生效."),
        //接受所有远程请求(rpc-allow-origin-all) tooltip:'在 RPC 响应头增加 Access-Control-Allow-Origin 字段, 值为 * .'
        FormItem<bool>(
            label: '接受所有远程请求',
            type: FormItemType.switch_,
            value: config.rpcAllowOriginAll,
            key: 'rpc-allow-origin-all',
            readOnly: true,
            tooltip: "在 RPC 响应头增加 Access-Control-Allow-Origin 字段, 值为 * ."),
        //在所有网卡上监听(rpc-listen-all) tooltip:'在所有网络适配器上监听 JSON-RPC/XML-RPC 的请求, 如果设置为"否", 仅监听本地网络的请求.'
        FormItem<bool>(
            label: '在所有网卡上监听',
            type: FormItemType.switch_,
            value: config.rpcListenAll,
            key: 'rpc-listen-all',
            readOnly: true,
            tooltip:
                "在所有网络适配器上监听 JSON-RPC/XML-RPC 的请求, 如果设置为\"否\", 仅监听本地网络的请求."),
        //监听端口(rpc-listen-port)
        FormItem<int>(
          label: '监听端口',
          type: FormItemType.input,
          value: config.rpcListenPort,
          readOnly: true,
          key: 'rpc-listen-port',
        ),
        //最大请求大小(rpc-max-request-size) tooltip:'设置 JSON-RPC/XML-RPC 最大的请求大小. 如果 aria2 检测到请求超过设定的字节数, 会直接取消连接.'
        FormItem<int>(
            label: '最大请求大小',
            type: FormItemType.input,
            value: config.rpcMaxRequestSize,
            key: 'rpc-max-request-size',
            readOnly: true,
            tooltip:
                "设置 JSON-RPC/XML-RPC 最大的请求大小. 如果 aria2 检测到请求超过设定的字节数, 会直接取消连接."),
        //保存上传的种子文件(rpc-save-upload-metadata) tooltip:'在 dir 选项设置的目录中保存上传的种子文件或 Metalink 文件. 文件名包括 SHA-1 哈希后的元数据和扩展名两部分. 对于种子文件, 扩展名为 '.torrent'. 对于 Metalink 为 '.meta4'. 如果此选项设置为"否", 通过 aria2.addTorrent() 或 aria2.addMetalink() 方法添加的下载将无法通过 --save-session 选项保存.'
        FormItem<bool>(
            label: '保存上传的种子文件',
            type: FormItemType.switch_,
            value: config.rpcSaveUploadMetadata,
            key: 'rpc-save-upload-metadata',
            tooltip:
                "在 dir 选项设置的目录中保存上传的种子文件或 Metalink 文件. 文件名包括 SHA-1 哈希后的元数据和扩展名两部分. 对于种子文件, 扩展名为 '.torrent'. 对于 Metalink 为 '.meta4'. 如果此选项设置为\"否\", 通过 aria2.addTorrent() 或 aria2.addMetalink() 方法添加的下载将无法通过 --save-session 选项保存."),
        //启用 SSL/TLS(rpc-secure) tooltip:'RPC 将通过 SSL/TLS 加密传输. RPC 客户端需要使用 https 协议连接服务器. 对于 WebSocket 客户端, 使用 wss 协议. 使用 --rpc-certificate 和 --rpc-private-key 选项设置服务器的证书和私钥.'
        FormItem<bool>(
            label: '启用 SSL/TLS',
            type: FormItemType.switch_,
            value: config.rpcSecure,
            key: 'rpc-secure',
            readOnly: true,
            showDivider: false,
            tooltip:
                "RPC 将通过 SSL/TLS 加密传输. RPC 客户端需要使用 https 协议连接服务器. 对于 WebSocket 客户端, 使用 wss 协议. 使用 --rpc-certificate 和 --rpc-private-key 选项设置服务器的证书和私钥."),
      ],
      itemBuilder: (context, item) {
        return OptionItem(
          formItem: item,
        );
      });
}
