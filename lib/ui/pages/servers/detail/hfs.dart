part of 'detail_page.dart';

buildHSF(BuildContext context, Aria2ServerConfig config) {
  return FormGroup(
    title: 'HTTP/FTP/SFTP',
    style: FormGroupStyle(
      backgroundColor: Theme.of(context).splashColor,
      collapsedBackgroundColor: Theme.of(context).highlightColor,
      textColor: Theme.of(context).primaryColor,
      elevation: 3,
    ),
    leading: const CircleAvatar(
      backgroundColor: Colors.lightGreen,
      child: Text(
        'H',
        style: TextStyle(color: Colors.white),
      ),
    ),
    items: [
      FormItem<String>(
        type: FormItemType.input,
        value: config.allProxy,
        key: 'all-proxy',
      ),
      FormItem<String>(
          type: FormItemType.input,
          value: config.allProxyUser,
          key: 'all-proxy-user'),
      FormItem<String>(
          type: FormItemType.input,
          value: config.allProxyPasswd,
          key: 'all-proxy-passwd'),
      FormItem<int>(
        type: FormItemType.input,
        value: config.connectTimeout,
        key: 'connect-timeout',
        trailingBuilder: (context) =>
            buildUnitTrailing(context, S.of(context).second),
      ),
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.dryRun,
        key: 'dry-run',
      ),
      //最小速度限制
      FormItem<int>(
        type: FormItemType.input,
        value: config.lowestSpeedLimit,
        key: 'lowest-speed-limit',
        trailingBuilder: (context) =>
            buildUnitTrailing(context, S.of(context).bytes),
      ),
      //单服务器最大连接数(max-connection-per-server)
      FormItem<int>(
        type: FormItemType.input,
        value: config.maxConnectionPerServer,
        key: 'max-connection-per-server',
      ),
      //文件未找到重试次数(max-file-not-found)
      FormItem<int>(
        type: FormItemType.input,
        value: config.maxFileNotFound,
        key: 'max-file-not-found',
      ),
      //最大尝试次数(max-tries)
      FormItem<int>(
        type: FormItemType.input,
        value: config.maxTries,
        key: 'max-tries',
      ),
      //最小文件分片大小(min-split-size)
      FormItem<int>(
        type: FormItemType.input,
        value: config.minSplitSize,
        key: 'min-split-size',
        trailingBuilder: (context) =>
            buildUnitTrailing(context, S.of(context).bytes),
      ),
      //.netrc 文件路径(netrc-path)
      FormItem<String>(
          type: FormItemType.input,
          value: config.netrcPath,
          key: 'netrc-path',
          readOnly: true),
      //禁用 netrc(no-netrc)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.noNetrc,
        key: 'no-netrc',
      ),
      //不使用代理服务器列表(no-proxy)
      FormItem<String>(
        type: FormItemType.input,
        value: config.noProxy,
        key: 'no-proxy',
      ),
      //代理服务器请求方法(proxy-method)
      FormItem<String>(
        type: FormItemType.select,
        value: config.proxyMethod,
        key: 'proxy-method',
        options: [
          FormItemOption(label: "GET", value: "get"),
          FormItemOption(label: "TUNNEL", value: "tunnel"),
        ],
      ),
      //获取服务器文件时间(remote-time)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.remoteTime,
        key: 'remote-time',
      ),
      //URI 复用(reuse-uri)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.reuseUri,
        key: 'reuse-uri',
      ),
      //重试等待时间(retry-wait)
      FormItem<int>(
        type: FormItemType.input,
        value: config.retryWait,
        key: 'retry-wait',
        trailingBuilder: (context) =>
            buildUnitTrailing(context, S.of(context).second),
      ),
      //服务器状态保存文件(server-stat-of)
      FormItem<String>(
        type: FormItemType.input,
        value: config.serverStatOf,
        key: 'server-stat-of',
      ),
      //服务器状态超时(server-stat-timeout)
      FormItem<int>(
        type: FormItemType.input,
        value: config.serverStatTimeout,
        key: 'server-stat-timeout',
        readOnly: true,
      ),
      //单任务连接数(split)
      FormItem<int>(
        type: FormItemType.input,
        value: config.split,
        key: 'split',
      ),
      //分片选择算法(stream-piece-selector)
      FormItem<String>(
        type: FormItemType.select,
        value: config.streamPieceSelector,
        key: 'stream-piece-selector',
        options: [
          FormItemOption(label: "DEFAULT", value: "default"),
          FormItemOption(label: "INORDER", value: "inorder"),
          FormItemOption(label: "RANDOM", value: "random"),
          FormItemOption(label: "GEOM", value: "geom"),
        ],
      ),
      //超时时间(timeout)
      FormItem<int>(
          type: FormItemType.input,
          value: config.timeout,
          key: 'timeout',
          trailingBuilder: (context) =>
              buildUnitTrailing(context, S.of(context).second)),
      //URI 选择算法(uri-selector)
      FormItem<String>(
        type: FormItemType.select,
        value: config.uriSelector,
        key: 'uri-selector',
        options: [
          FormItemOption(label: "INORDER", value: "inorder"),
          FormItemOption(label: "FEEDBACK", value: "feedback"),
          FormItemOption(label: "ADAPTIVE", value: "adaptive"),
        ],
        showDivider: false,
      ),
    ],
  );
}
