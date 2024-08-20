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
          label: '代理服务器',
          type: FormItemType.input,
          value: config.allProxy,
          key: 'all-proxy',
          tooltip:
              "设置所有协议的代理服务器地址. 您还可以针对特定的协议覆盖此选项, 即使用 --http-proxy, --https-proxy 和 --ftp-proxy 选项. 此设置将会影响所有下载. 代理服务器地址的格式为 [http://][USER:PASSWORD@]HOST[:PORT].",
        ),
        FormItem<String>(
            label: '代理服务器用户名',
            type: FormItemType.input,
            value: config.allProxyUser,
            key: 'all-proxy-user'),
        FormItem<String>(
            label: '代理服务器密码',
            type: FormItemType.input,
            value: config.allProxyPasswd,
            key: 'all-proxy-passwd'),
        FormItem<int>(
          label: '连接超时时间',
          type: FormItemType.input,
          value: config.connectTimeout,
          key: 'connect-timeout',
          trailingBuilder: (context) => buildUnitTrailing(context, "秒"),
          tooltip:
              "设置建立 HTTP/FTP/代理服务器 连接的超时时间(秒). 当连接建立后, 此选项不再生效, 请使用 --timeout 选项.",
        ),
        FormItem<bool>(
          label: '模拟运行',
          type: FormItemType.switch_,
          value: config.dryRun,
          key: 'dry-run',
          tooltip:
              '如果设置为"是, aria2 将仅检查远程文件是否存在而不会下载文件内容. 此选项仅对 HTTP/FTP 下载生效. 如果设置为 true, BT 下载将会直接取消.',
        ),
        //最小速度限制
        FormItem<int>(
          label: '最小速度限制',
          type: FormItemType.input,
          value: config.lowestSpeedLimit,
          key: 'lowest-speed-limit',
          trailingBuilder: (context) => buildUnitTrailing(context, "字节"),
          tooltip:
              "当下载速度低于此选项设置的值(B/s) 时将会关闭连接. 0 表示不设置最小速度限制. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K). 此选项不会影响 BT 下载.",
        ),
        //单服务器最大连接数(max-connection-per-server)
        FormItem<int>(
          label: '单服务器最大连接数',
          type: FormItemType.input,
          value: config.maxConnectionPerServer,
          key: 'max-connection-per-server',
        ),
        //文件未找到重试次数(max-file-not-found)
        FormItem<int>(
          label: '文件未找到重试次数',
          type: FormItemType.input,
          value: config.maxFileNotFound,
          key: 'max-file-not-found',
          tooltip:
              '如果 aria2 从远程 HTTP/FTP 服务器收到 "文件未找到" 的状态超过此选项设置的次数后下载将会失败. 设置为 0 将会禁用此选项. 此选项仅影响 HTTP/FTP 服务器. 重试时同时会记录重试次数, 所以也需要设置 --max-tries 这个选项.',
        ),
        //最大尝试次数(max-tries)
        FormItem<int>(
          label: '最大尝试次数',
          type: FormItemType.input,
          value: config.maxTries,
          key: 'max-tries',
          tooltip: "设置最大尝试次数. 0 表示不限制.",
        ),
        //最小文件分片大小(min-split-size)
        FormItem<int>(
          label: '最小文件分片大小',
          type: FormItemType.input,
          value: config.minSplitSize,
          key: 'min-split-size',
          trailingBuilder: (context) => buildUnitTrailing(context, "字节"),
          tooltip:
              "aria2 不会分割小于 2*SIZE 字节的文件. 例如, 文件大小为 20MB, 如果 SIZE 为 10M, aria2 会把文件分成 2 段 [0-10MB) 和 [10MB-20MB), 并且使用 2 个源进行下载 (如果 --split >= 2). 如果 SIZE 为 15M, 由于 2*15M > 20MB, 因此 aria2 不会分割文件并使用 1 个源进行下载. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K). 可以设置的值为: 1M-1024M.",
        ),
        //.netrc 文件路径(netrc-path)
        FormItem<String>(
            label: '.netrc 文件路径',
            type: FormItemType.input,
            value: config.netrcPath,
            key: 'netrc-path',
            readOnly: true),
        //禁用 netrc(no-netrc)
        FormItem<bool>(
          label: '禁用 netrc',
          type: FormItemType.switch_,
          value: config.noNetrc,
          key: 'no-netrc',
        ),
        //不使用代理服务器列表(no-proxy)
        FormItem<String>(
          label: '不使用代理服务器列表',
          type: FormItemType.input,
          value: config.noProxy,
          key: 'no-proxy',
          tooltip: "设置不使用代理服务器的主机名, 域名, 包含或不包含子网掩码的网络地址, 多个使用逗号分隔.",
        ),
        //代理服务器请求方法(proxy-method)
        FormItem<String>(
          label: '代理服务器请求方法',
          type: FormItemType.select,
          value: config.proxyMethod,
          key: 'proxy-method',
          options: [
            FormItemOption(label: "GET", value: "get"),
            FormItemOption(label: "TUNNEL", value: "tunnel"),
          ],
          tooltip:
              "设置用来请求代理服务器的方法. 方法可设置为 GET 或 TUNNEL. HTTPS 下载将忽略此选项并总是使用 TUNNEL.",
        ),
        //获取服务器文件时间(remote-time)
        FormItem<bool>(
          label: '获取服务器文件时间',
          type: FormItemType.switch_,
          value: config.remoteTime,
          key: 'remote-time',
          tooltip: "从 HTTP/FTP 服务获取远程文件的时间戳, 如果可用将设置到本地文件",
        ),
        //URI 复用(reuse-uri)
        FormItem<bool>(
          label: 'URI 复用',
          type: FormItemType.switch_,
          value: config.reuseUri,
          key: 'reuse-uri',
          tooltip: "当所有给定的 URI 地址都已使用, 继续使用已经使用过的 URI 地址.",
        ),
        //重试等待时间(retry-wait)
        FormItem<int>(
          label: '重试等待时间',
          type: FormItemType.input,
          value: config.retryWait,
          key: 'retry-wait',
          trailingBuilder: (context) => buildUnitTrailing(context, "秒"),
          tooltip: "设置重试间隔时间(秒). 当此选项的值大于 0 时, aria2 在 HTTP 服务器返回 503 响应时将会重试.",
        ),
        //服务器状态保存文件(server-stat-of)
        FormItem<String>(
          label: '服务器状态保存文件',
          type: FormItemType.input,
          value: config.serverStatOf,
          key: 'server-stat-of',
          tooltip: "指定用来保存服务器状态的文件名. 您可以使用 --server-stat-if 参数读取保存的数据.",
        ),
        //服务器状态超时(server-stat-timeout)
        FormItem<int>(
          label: '服务器状态超时',
          type: FormItemType.input,
          value: config.serverStatTimeout,
          key: 'server-stat-timeout',
          readOnly: true,
          tooltip: "指定服务器状态的过期时间 (单位为秒).",
        ),
        //单任务连接数(split)
        FormItem<int>(
          label: '单任务连接数',
          type: FormItemType.input,
          value: config.split,
          key: 'split',
          tooltip:
              "下载时使用 N 个连接. 如果提供超过 N 个 URI 地址, 则使用前 N 个地址, 剩余的地址将作为备用. 如果提供的 URI 地址不足 N 个, 这些地址多次使用以保证同时建立 N 个连接. 同一服务器的连接数会被 --max-connection-per-server 选项限制.",
        ),
        //分片选择算法(stream-piece-selector)
        FormItem<String>(
          label: '分片选择算法',
          type: FormItemType.select,
          value: config.streamPieceSelector,
          key: 'stream-piece-selector',
          options: [
            FormItemOption(label: "默认", value: "default"),
            FormItemOption(label: "顺序", value: "inorder"),
            FormItemOption(label: "随机", value: "random"),
            FormItemOption(label: "几何", value: "geom"),
          ],
          tooltip:
              '指定 HTTP/FTP 下载使用的分片选择算法. 分片表示的是并行下载时固定长度的分隔段. 如果设置为"默认", aria2 将会按减少建立连接数选择分片. 由于建立连接操作的成本较高, 因此这是合理的默认行为. 如果设置为"顺序", aria2 将选择索引最小的分片. 索引为 0 时表示为文件的第一个分片. 这将有助于视频的边下边播. --enable-http-pipelining 选项有助于减少重连接的开销. 请注意, aria2 依赖于 --min-split-size 选项, 所以有必要对 --min-split-size 选项设置一个合理的值. 如果设置为"随机", aria2 将随机选择一个分片. 就像"顺序"一样, 依赖于 --min-split-size 选项. 如果设置为"几何", aria2 会先选择索引最小的分片, 然后会为之前选择的分片保留指数增长的空间. 这将减少建立连接的次数, 同时文件开始部分将会先行下载. 这也有助于视频的边下边播.',
        ),
        //超时时间(timeout)
        FormItem<int>(
            label: '超时时间',
            type: FormItemType.input,
            value: config.timeout,
            key: 'timeout',
            trailingBuilder: (context) => buildUnitTrailing(context, "秒")),
        //URI 选择算法(uri-selector)
        FormItem<String>(
          label: 'URI 选择算法',
          type: FormItemType.select,
          value: config.uriSelector,
          key: 'uri-selector',
          options: [
            FormItemOption(label: "顺序", value: "inorder"),
            FormItemOption(label: "反馈", value: "feedback"),
            FormItemOption(label: "自适应", value: "adaptive"),
          ],
          showDivider: false,
          tooltip:
              '指定 URI 选择的算法. 可选的值包括 "按顺序", "反馈" 和 "自适应". 如果设置为"按顺序", URI 将按列表中出现的顺序使用. 如果设置为"反馈", aria2 将根据之前的下载速度选择 URI 列表中下载速度最快的服务器. 同时也将有效跳过无效镜像. 之前统计的下载速度将作为服务器状态文件的一部分, 参见 --server-stat-of 和 --server-stat-if 选项. 如果设置为"自适应", 将从最好的镜像和保留的连接里选择一项. 补充说明, 其返回的镜像没有被测试过, 同时如果每个镜像都已经被测试过时, 返回的镜像还会被重新测试. 否则, 其将不会选择其他镜像. 例如"反馈", 其使用服务器状态文件.',
        ),
      ],
      itemBuilder: (context, item) {
        return OptionItem(
          formItem: item,
        );
      });
}
