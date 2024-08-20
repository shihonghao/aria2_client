part of 'detail_page.dart';

buildBT(BuildContext context, Aria2ServerConfig config) {
  return FormGroup(
      title: 'Bittorrent',
      style: FormGroupStyle(
        backgroundColor: Theme.of(context).splashColor,
        collapsedBackgroundColor: Theme.of(context).highlightColor,
        textColor: Theme.of(context).primaryColor,
        elevation: 3,
      ),
      leading: const CircleAvatar(
        backgroundColor: Colors.lightGreen,
        child: Text(
          'B',
          style: TextStyle(color: Colors.white),
        ),
      ),
      items: [
        //分离仅做种任务(bt-detach-seed-only) tooltip:'统计当前活动下载任务(参见 -j 选项) 时排除仅做种的任务. 这意味着, 如果参数设置为 -j3, 此选项打开并且当前有 3 个正在活动的任务, 并且其中有 1 个进入做种模式, 那么其会从正在下载的数量中排除(即数量会变为 2), 在队列中等待的下一个任务将会开始执行. 但要知道, 在 RPC 方法中, 做种的任务仍然被认为是活动的下载任务.'
        FormItem<bool>(
            label: '仅做种任务',
            type: FormItemType.switch_,
            value: config.btDetachSeedOnly,
            key: 'bt-detach-seed-only',
            readOnly: true,
            tooltip:
                '统计当前活动下载任务(参见 -j 选项) 时排除仅做种的任务. 这意味着, 如果参数设置为 -j3, 此选项打开并且当前有 3 个正在活动的任务, 并且其中有 1 个进入做种模式, 那么其会从正在下载的数量中排除(即数量会变为 2), 在队列中等), 在队列中等待的下一个任务将会开始执行. 但要知道, 在 RPC 方法中, 做种的任务仍然被认为是活动的下载任务.'),
        //启用哈希检查完成事件(bt-enable-hook-after-hash-check) tooltip:'允许 BT 下载哈希检查(参见 -V 选项) 完成后调用命令. 默认情况下, 当哈希检查成功后, 通过 --on-bt-download-complete 设置的命令将会被执行. 如果要禁用此行为, 请设置为"否".'
        FormItem<bool>(
            label: '哈希检查完成事件',
            type: FormItemType.switch_,
            value: config.btEnableHookAfterHashCheck,
            key: 'bt-enable-hook-after-hash-check',
            tooltip:
                '允许 BT 下载哈希检查(参见 -V 选项) 完成后调用命令. 默认情况下, 当哈希检查成功后, 通过 --on-bt-download-complete 设置的命令将会被执行. 如果要禁用此行为, 请设置为"否".'),
        //启用本地节点发现  (LPD)(bt-enable-lpd)
        FormItem<bool>(
          label: '本地节点发现',
          type: FormItemType.switch_,
          value: config.btEnableLpd,
          key: 'bt-enable-lpd',
          tooltip: '启用本地节点发现  (LPD)(bt-enable-lpd)',
        ),
        //BT 排除服务器地址(bt-exclude-tracker) tooltip:'逗号分隔的 BT 排除服务器地址. 您可以使用 * 匹配所有地址, 因此将排除所有服务器地址. 当在 shell 命令行使用 * 时, 需要使用转义符或引号.'
        FormItem<String>(
          label: 'BT 排除服务器地址',
          type: FormItemType.input,
          value: config.btExcludeTracker,
          key: 'bt-exclude-tracker',
          tooltip:
              '逗号分隔的 BT 排除服务器地址. 您可以使用 * 匹配所有地址, 因此将排除所有服务器地址. 当在 shell 命令行使用 * 时, 需要使用转义符或引号.',
        ),
        //外部 IP 地址(bt-external-ip) tooltip:'指定用在 BitTorrent 下载和 DHT 中的外部 IP 地址. 它可能被发送到 BitTorrent 服务器. 对于 DHT, 此选项将会报告本地节点正在下载特定的种子. 这对于在私有网络中使用 DHT 非常关键. 虽然这个方法叫外部, 但其可以接受各种类型的 IP 地址.'
        FormItem<String>(
          label: '外部 IP 地址',
          type: FormItemType.input,
          value: config.btExternalIp,
          key: 'bt-external-ip',
          tooltip:
              '指定用在 BitTorrent 下载和 DHT 中的外部 IP 地址. 它可能被发送到 BitTorrent 服务器. 对于 DHT, 此选项将会报告本地节点正在下载特定的种子. 这对于在私有网络中使用 DHT 非常关键. 虽然这个方法叫外部, 但其可以接受各种类型的 IP 地址.',
        ),
        //强制加密(bt-force-encryption) tooltip:'BT 消息中的内容需要使用 arc4 加密. 此选项是设置 --bt-require-crypto --bt-min-crypto-level=arc4 这两个选项的快捷方式. 此选项不会修改上述两个选项的内容. 如果设置为"是", 将拒绝以前的 BT 握手, 并仅使用模糊握手及加密消息.'
        FormItem<bool>(
          label: '强制加密',
          type: FormItemType.switch_,
          value: config.btForceEncryption,
          key: 'bt-force-encryption',
          tooltip:
              'BT 消息中的内容需要使用 arc4 加密. 此选项是设置 --bt-require-crypto --bt-min-crypto-level=arc4 这两个选项的快捷方式. 此选项不会修改上述两个选项的内容. 如果设置为"是", 将拒绝以前的 BT 握手, 并仅使用模糊握手及加密消息.',
        ),
        //做种前检查文件哈希(bt-hash-check-seed) tooltip:'如果设置为"是", 当使用 --check-integrity 选项完成哈希检查及文件完成后才继续做种. 如果您希望仅当文件损坏或未完成时检查文件, 请设置为"否". 此选项仅对 BT 下载有效'
        FormItem<bool>(
          label: '做种前检查文件哈希',
          type: FormItemType.switch_,
          value: config.btHashCheckSeed,
          key: 'bt-hash-check-seed',
          tooltip:
              '如果设置为"是", 当使用 --check-integrity 选项完成哈希检查及文件完成后才继续做种. 如果您希望仅当文件损坏或未完成时检查文件, 请设置为"否". 此选项仅对 BT 下载有效',
        ),
        //加载已保存的元数据文件(bt-load-saved-metadata) tooltip:'当使用磁链下载时, 在从 DHT 获取种子元数据之前, 首先尝试加载使用 --bt-save-metadata 选项保存的文件. 如果文件加载成功, 则不会从 DHT 下载元数据.'
        FormItem<bool>(
          label: '加载已保存的元数据文件',
          type: FormItemType.switch_,
          value: config.btLoadSavedMetadata,
          key: 'bt-load-saved-metadata',
          tooltip:
              '当使用磁链下载时, 在从 DHT 获取种子元数据之前, 首先尝试加载使用 --bt-save-metadata 选项保存的文件. 如果文件加载成功, 则不会从 DHT 下载元数据.',
        ),
        //最多打开文件数(bt-max-open-files) tooltip:'设置 BT/Metalink 下载全局打开的最大文件数.'
        FormItem<int>(
          label: '最多打开文件数',
          type: FormItemType.input,
          value: config.btMaxOpenFiles,
          key: 'bt-max-open-files',
          tooltip: '设置 BT/Metalink 下载全局打开的最大文件数.',
        ),
        //最大连接节点数(bt-max-peers) tooltip:'设置每个 BT 下载的最大连接节点数. 0 表示不限制.'
        FormItem<int>(
          label: '最大连接节点数',
          type: FormItemType.input,
          value: config.btMaxPeers,
          key: 'bt-max-peers',
          tooltip: '设置每个 BT 下载的最大连接节点数. 0 表示不限制.',
        ),
        //仅下载种子文件(bt-metadata-only) tooltip:'仅下载种子文件. 种子文件中描述的文件将不会下载. 此选项仅对磁链生效.'
        FormItem<bool>(
          label: '仅下载种子文件',
          type: FormItemType.switch_,
          value: config.btMetadataOnly,
          key: 'bt-metadata-only',
          tooltip: '仅下载种子文件. 种子文件中描述的文件将不会下载. 此选项仅对磁链生效.',
        ),
        //最低加密级别(bt-min-crypto-level) tooltip:'设置加密方法的最小级别. 如果节点提供多种加密方法, aria2 将选择满足给定级别的最低级别.'
        FormItem<String>(
          label: '最低加密级别',
          type: FormItemType.select,
          value: config.btMinCryptoLevel,
          key: 'bt-min-crypto-level',
          options: [
            FormItemOption(label: "明文", value: "plain"),
            FormItemOption(label: "ARC4", value: "arc4"),
          ],
          tooltip: '设置加密方法的最小级别. 如果节点提供多种加密方法, aria2 将选择满足给定级别的最低级别.',
        ),
        //优先下载(bt-prioritize-piece) tooltip:'尝试先下载每个文件开头或结尾的分片. 此选项有助于预览文件. 参数可以包括两个关键词: head 和 tail. 如果包含两个关键词, 需要使用逗号分隔. 每个关键词可以包含一个参数, SIZE. 例如, 如果指定 head=SIZE, 每个文件的最前 SIZE 数据将会获得更高的优先级. tail=SIZE 表示每个文件的最后 SIZE 数据. SIZE 可以包含 K 或 M (1K = 1024, 1M = 1024K).'
        FormItem<String>(
          label: '优先下载',
          type: FormItemType.input,
          value: config.btPrioritizePiece,
          key: 'bt-prioritize-piece',
          tooltip:
              '尝试先下载每个文件开头或结尾的分片. 此选项有助于预览文件. 参数可以包括两个关键词: head 和 tail. 如果包含两个关键词, 需要使用逗号分隔. 每个关键词可以包含一个参数, SIZE. 例如, 如果指定 head=SIZE,每个文件的最前 SIZE 数据将会获得更高的优先级. tail=SIZE 表示每个文件的最后 SIZE 数据. SIZE 可以包含 K 或 M (1K = 1024, 1M = 1024K).',
        ),
        //删除未选择的文件(bt-remove-unselected-file) tooltip:'当 BT 任务完成后删除未选择的文件. 要选择需要下载的文件, 请使用 --select-file 选项. 如果没有选择, 则所有文件都默认为需要下载. 此选项会从磁盘上直接删除文件, 请谨慎使用此选项.'
        FormItem<bool>(
          label: '删除未选择的文件',
          type: FormItemType.switch_,
          value: config.btRemoveUnselectedFile,
          key: 'bt-remove-unselected-file',
          tooltip:
              '当 BT 任务完成后删除未选择的文件. 要选择需要下载的文件, 请使用 --select-file 选项. 如果没有选择, 则所有文件都默认为需要下载. 此选项会从磁盘上直接删除文件, 请谨慎使用此选项.',
        ),
        //需要加密(bt-require-crypto) tooltip:'如果设置为"是", aria 将不会接受以前的 BitTorrent 握手协议(\19BitTorrent 协议)并建立连接. 因此 aria2 总是模糊握手.'
        FormItem<bool>(
          label: '需要加密',
          type: FormItemType.switch_,
          value: config.btRequireCrypto,
          key: 'bt-require-crypto',
          tooltip:
              '如果设置为"是", aria 将不会接受以前的 BitTorrent 握手协议(19BitTorrent 协议)并建立连接. 因此 aria2 总是模糊握手.',
        ),
        //期望下载速度(bt-request-peer-speed-limit) tooltip:'如果一个 BT 下载的整体下载速度低于此选项设置的值, aria2 会临时提高连接数以提高下载速度. 在某些情况下, 设置期望下载速度可以提高您的下载速度. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K).'
        FormItem<int>(
          label: '期望下载速度',
          type: FormItemType.input,
          value: config.btRequestPeerSpeedLimit,
          key: 'bt-request-peer-speed-limit',
          tooltip:
              '如果一个 BT 下载的整体下载速度低于此选项设置的值, aria2 会临时提高连接数以提高下载速度. 在某些情况下, 设置期望下载速度可以提高您的下载速度. 您可以增加数值的单位 K 或 M (1K = 1024,1M = 1024K).',
          trailingBuilder: (context) => buildUnitTrailing(context, "字节"),
        ),
        //保存种子文件(bt-save-metadata) tooltip:'保存种子文件为 ".torrent" 文件. 此选项仅对磁链生效. 文件名为十六进制编码后的哈希值及 ".torrent"后缀. 保存的目录与下载文件的目录相同. 如果相同的文件已存在, 种子文件将不会保存.'
        FormItem<bool>(
          label: '保存种子文件',
          type: FormItemType.switch_,
          value: config.btSaveMetadata,
          key: 'bt-save-metadata',
          tooltip:
              '保存种子文件为 ".torrent" 文件. 此选项仅对磁链生效. 文件名为十六进制编码后的哈希值及 ".torrent"后缀. 保存的目录与下载文件的目录相同. 如果相同的文件已存在, 种子文件将不会保存.',
        ),
        //不检查已经下载的文件(bt-seed-unverified) tooltip:'不检查之前下载文件中每个分片的哈希值.'
        FormItem<bool>(
          label: '不检查已经下载的文件',
          type: FormItemType.switch_,
          value: config.btSeedUnverified,
          key: 'bt-seed-unverified',
          tooltip: '不检查之前下载文件中每个分片的哈希值.',
        ),
        //无速度时自动停止时间(bt-stop-timeout) tooltip:'当 BT 任务下载速度持续为 0, 达到此选项设置的时间后停止下载. 如果设置为 0, 此功能将禁用.'
        FormItem<int>(
          label: '无速度时自动停止时间',
          type: FormItemType.input,
          value: config.btStopTimeOut,
          key: 'bt-stop-timeout',
          tooltip: '当 BT 任务下载速度持续为 0, 达到此选项设置的时间后停止下载. 如果设置为 0, 此功能将禁用.',
          trailingBuilder: (context) => buildUnitTrailing(context, "秒"),
        ),
        //BT 服务器地址(bt-tracker) tooltip:'逗号分隔的 BT 服务器地址. 这些地址不受 --bt-exclude-tracker 选项的影响, 因为这些地址在 --bt-exclude-tracker 选项排除掉其他地址之后才会添加.'
        FormItem<String>(
          label: 'BT 服务器地址',
          type: FormItemType.input,
          value: config.btTracker,
          key: 'bt-tracker',
          tooltip:
              '逗号分隔的 BT 服务器地址. 这些地址不受 --bt-exclude-tracker 选项的影响, 因为这些地址在 --bt-exclude-tracker 选项排除掉其他地址之后才会添加.',
        ),
        //BT 服务器连接超时时间(bt-tracker-connect-timeout) tooltip:'设置 BT 服务器的连接超时时间 (秒). 当连接建立后, 此选项不再生效, 请使用 --bt-tracker-timeout 选项.'
        FormItem<int>(
          label: 'BT 服务器连接超时时间',
          type: FormItemType.input,
          value: config.btTrackerConnectTimeout,
          key: 'bt-tracker-connect-timeout',
          tooltip:
              '设置 BT 服务器的连接超时时间 (秒). 当连接建立后, 此选项不再生效, 请使用 --bt-tracker-timeout 选项.',
          trailingBuilder: (context) => buildUnitTrailing(context, "秒"),
        ),
        //BT 服务器连接间隔时间(bt-tracker-interval) tooltip:'设置请求 BT 服务器的间隔时间 (秒). 此选项将完全覆盖服务器返回的最小间隔时间和间隔时间, aria2 仅使用此选项的值.如果设置为 0, aria2 将根据服务器的响应情况和下载进程决定时间间隔.'
        FormItem<int>(
          label: 'BT 服务器连接间隔时间',
          type: FormItemType.input,
          value: config.btTrackerInterval,
          key: 'bt-tracker-interval',
          tooltip:
              '设置请求 BT 服务器的间隔时间 (秒). 此选项将完全覆盖服务器返回的最小间隔时间和间隔时间, aria2 仅使用此选项的值.如果设置为 0, aria2 将根据服务器的响应情况和下载进程决定时间间隔.',
        ),
        //BT 服务器超时时间(bt-tracker-timeout)
        FormItem<int>(
          label: 'BT 服务器超时时间',
          type: FormItemType.input,
          value: config.btTrackerTimeout,
          key: 'bt-tracker-timeout',
          tooltip:
              '设置请求 BT 服务器的超时时间 (秒). 此选项将完全覆盖服务器返回的最小超时时间, aria2 仅使用此选项的值.如果设置为 0, aria2 将根据服务器的响应情况和下载进程决定超时时间.',
          trailingBuilder: (context) =>
              buildUnitTrailing(context, "秒"),
        ),
        //DHT (IPv4) 文件(dht-file-path) tooltip:'修改 IPv4 DHT 路由表文件路径.'
        FormItem<String>(
          label: 'DHT (IPv4) 文件',
          type: FormItemType.input,
          value: config.dhtFilePath,
          key: 'dht-file-path',
          readOnly: true,
          tooltip: '修改 IPv4 DHT 路由表文件路径.',
        ),
        //DHT (IPv6) 文件(dht-file-path6) tooltip:'修改 IPv6 DHT 路由表文件路径.'
        FormItem<String>(
          label: 'DHT (IPv6) 文件',
          type: FormItemType.input,
          value: config.dhtFilePath6,
          key: 'dht-file-path6',
          readOnly: true,
          tooltip: '修改 IPv6 DHT 路由表文件路径.',
        ),
        //DHT 监听端口(dht-listen-port) tooltip:'设置 DHT (IPv4, IPv6) 和 UDP 服务器使用的 UCP 端口. 多个端口可以使用逗号 "," 分隔, 例如: 6881,6885. 您还可以使用短横线 "-" 表示范围: 6881-6999, 或可以一起使用: 6881-6889, 6999.'
        FormItem<String>(
            label: 'DHT 监听端口',
            type: FormItemType.input,
            value: config.dhtListenPort,
            key: 'dht-listen-port',
            readOnly: true,
            tooltip:
                '设置 DHT (IPv4, IPv6) 和 UDP 服务器使用的 UCP 端口. 多个端口可以使用逗号 "," 分隔, 例如: 6881,6885. 您还可以使用短横线 "-" 表示范围: 6881-6999, 或可以一起使用: 6881-6889, 6999.'),
        //DHT 消息超时时间(dht-message-timeout)
        FormItem<int>(
          label: 'DHT 消息超时时间',
          type: FormItemType.input,
          value: config.dhtMessageTimeout,
          key: 'dht-message-timeout',
          readOnly: true,
          tooltip: '设置 DHT 消息超时时间 (秒).',
        ),
        //启用 DHT (IPv4)(enable-dht) tooltip:'启用 IPv4 DHT 功能. 此选项同时会启用 UDP 服务器支持. 如果种子设置为私有, 即使此选项设置为"是", aria2 也不会启用 DHT.'
        FormItem<bool>(
          label: '启用 DHT (IPv4)',
          type: FormItemType.switch_,
          value: config.enableDht,
          key: 'enable-dht',
          readOnly: true,
          tooltip:
              '启用 IPv4 DHT 功能. 此选项同时会启用 UDP 服务器支持. 如果种子设置为私有, 即使此选项设置为"是", aria2 也不会启用 DHT.',
        ),
        //启用 DHT (IPv6)(enable-dht6) tooltip:'启用 IPv6 DHT 功能. 如果种子设置为私有, 即使此选项设置为"是", aria2 也不会启用 DHT. 使用 --dht-listen-port 选项设置监听的端口.'
        FormItem<bool>(
          label: '启用 DHT (IPv6)',
          type: FormItemType.switch_,
          value: config.enableDht6,
          key: 'enable-dht6',
          readOnly: true,
          tooltip:
              '启用 IPv6 DHT 功能. 如果种子设置为私有, 即使此选项设置为"是", aria2 也不会启用 DHT. 使用 --dht-listen-port 选项设置监听的端口.',
        ),
        //启用节点交换(enable-peer-exchange) tooltip:'启用节点交换扩展. 如果种子设置为私有, 即使此选项设置为"是", aria2 也不会启用此功能.'
        FormItem<bool>(
          label: '启用节点交换',
          type: FormItemType.switch_,
          value: config.enablePeerExchange,
          key: 'enable-peer-exchange',
          tooltip: '启用节点交换扩展. 如果种子设置为私有, 即使此选项设置为"是", aria2 也不会启用此功能.',
        ),
        //下载种子中的文件(follow-torrent) tooltip:'如果设置为"是"或"仅内存", 当后缀为 .torrent 或内容类型为 application/x-bittorrent 的文件下载完成时, aria2 将按种子文件读取并下载该文件中提到的文件. 如果设置为"仅内存", 该种子文件将不会写入到磁盘中, 而仅会存储在内存中. 如果设置为"否", 则 .torrent 文件会下载到磁盘中, 但不会按种子文件读取并且其中的文件不会进行下载.'
        FormItem<bool>(
          label: '下载种子中的文件',
          type: FormItemType.input,
          value: config.followTorrent,
          key: 'follow-torrent',
          tooltip:
              '如果设置为"是"或"仅内存", 当后缀为 .torrent 或内容类型为 application/x-bittorrent 的文件下载完成时, aria2 将按种子文件读取并下载该文件中提到的文件. 如果设置为"仅内存", 该种子文件将不会写入到磁盘中, 而仅会存储在内存中. 如果设置为"否", 则 .torrent 文件会下载到磁盘中, 但不会按种子文件读取并且其中的文件不会进行下载.',
        ),
        //监听端口(listen-port) tooltip:'设置 BT 下载的 TCP 端口. 多个端口可以使用逗号 "," 分隔, 例如: 6881,6885. 您还可以使用短横线 "-" 表示范围: 6881-6999, 或可以一起使用: 6881-6889, 6999.'
        FormItem<int>(
          label: '监听端口',
          type: FormItemType.input,
          value: config.listenPort,
          key: 'listen-port',
          readOnly: true,
          tooltip:
              '设置 BT 下载的 TCP 端口. 多个端口可以使用逗号 "," 分隔, 例如: 6881,6885. 您还可以使用短横线 "-" 表示范围: 6881-6999, 或可以一起使用: 6881-6889, 6999.',
        ),
        //全局最大上传速度(max-overall-upload-limit) tooltip:'设置全局最大上传速度 (字节/秒). 0 表示不限制. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K).'
        FormItem<int>(
          label: '全局最大上传速度',
          type: FormItemType.input,
          value: config.maxOverallUploadLimit,
          key: 'max-overall-upload-limit',
          tooltip:
              '设置全局最大上传速度 (字节/秒). 0 表示不限制. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K).',
          trailingBuilder: (context) =>
              buildUnitTrailing(context, "字节"),
        ),
        //最大上传速度(max-upload-limit) tooltip:'设置每个任务的最大上传速度 (字节/秒). 0 表示不限制. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K).'
        FormItem<int>(
          label: '最大上传速度',
          type: FormItemType.input,
          value: config.maxUploadLimit,
          key: 'max-upload-limit',
          tooltip:
              '设置每个任务的最大上传速度 (字节/秒). 0 表示不限制. 您可以增加数值的单位 K 或 M (1K = 1024, 1M = 1024K).',
          trailingBuilder: (context) =>
              buildUnitTrailing(context, "字节"),
        ),
        //节点 ID 前缀(peer-id-prefix) tooltip:'指定节点 ID 的前缀. BT 中节点 ID 长度为 20 字节. 如果超过 20 字节, 将仅使用前 20 字节. 如果少于 20 字节, 将在其后不足随机的数据保证为 20 字节.'
        FormItem<String>(
          label: '节点 ID 前缀',
          type: FormItemType.input,
          value: config.peerIdPrefix,
          key: 'peer-id-prefix',
          readOnly: true,
          tooltip:
              '指定节点 ID 的前缀. BT 中节点 ID 长度为 20 字节. 如果超过 20 字节, 将仅使用前 20 字节. 如果少于 20 字节, 将在其后不足随机的数据保证为 20 字节.',
        ),
        //Peer Agent(peer-agent) tooltip:'指定 BT 扩展握手期间用于节点客户端版本的字符串.'
        FormItem<String>(
          label: 'Peer Agent',
          type: FormItemType.input,
          value: config.peerAgent,
          key: 'peer-agent',
          readOnly: true,
          tooltip: '指定 BT 扩展握手期间用于节点客户端版本的字符串.',
        ),
        //最小分享率(seed-ratio) tooltip:'指定分享率. 当分享率达到此选项设置的值时会完成做种. 强烈建议您将此选项设置为大于等于 1.0. 如果您想不限制分享比率, 可以设置为 0.0. 如果同时设置了 --seed-time 选项, 当任意一个条件满足时将停止做种.'
        FormItem<double>(
          label: '最小分享率',
          type: FormItemType.input,
          value: config.seedRatio,
          key: 'seed-ratio',
          tooltip:
              '指定分享率. 当分享率达到此选项设置的值时会完成做种. 强烈建议您将此选项设置为大于等于 1.0. 如果您想不限制分享比率, 可以设置为 0.0. 如果同时设置了 --seed-time 选项, 当任意一个条件满足时将停止做种.',
        ),
        //最小做种时间(seed-time) tooltip:'以 (小数形式的) 分钟指定做种时间. 此选项设置为 0 时, 将在 BT 任务下载完成后不进行做种.'
        FormItem<double>(
          label: '最小做种时间',
          type: FormItemType.input,
          value: config.seedTime,
          key: 'seed-time',
          showDivider: false,
          tooltip: '以 (小数形式的) 分钟指定做种时间. 此选项设置为 0 时, 将在 BT 任务下载完成后不进行做种.',
          trailingBuilder: (context) =>
              buildUnitTrailing(context, "分钟"),
        ),
      ],
      itemBuilder: (context, item) {
        return OptionItem(
          formItem: item,
        );
      });
}
