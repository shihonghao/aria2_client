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
      //分离仅做种任务(bt-detach-seed-only)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.btDetachSeedOnly,
        key: 'bt-detach-seed-only',
        readOnly: true,
      ),
      //启用哈希检查完成事件(bt-enable-hook-after-hash-check)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.btEnableHookAfterHashCheck,
        key: 'bt-enable-hook-after-hash-check',
      ),
      //启用本地节点发现  (LPD)(bt-enable-lpd)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.btEnableLpd,
        key: 'bt-enable-lpd',
      ),
      //BT 排除服务器地址(bt-exclude-tracker)
      FormItem<String>(
        type: FormItemType.input,
        value: config.btExcludeTracker,
        key: 'bt-exclude-tracker',
      ),
      //外部 IP 地址(bt-external-ip)
      FormItem<String>(
        type: FormItemType.input,
        value: config.btExternalIp,
        key: 'bt-external-ip',
      ),
      //强制加密(bt-force-encryption)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.btForceEncryption,
        key: 'bt-force-encryption',
      ),
      //做种前检查文件哈希(bt-hash-check-seed)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.btHashCheckSeed,
        key: 'bt-hash-check-seed',
      ),
      //加载已保存的元数据文件(bt-load-saved-metadata)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.btLoadSavedMetadata,
        key: 'bt-load-saved-metadata',
      ),
      //最多打开文件数(bt-max-open-files)
      FormItem<int>(
        type: FormItemType.input,
        value: config.btMaxOpenFiles,
        key: 'bt-max-open-files',
      ),
      //最大连接节点数(bt-max-peers)
      FormItem<int>(
        type: FormItemType.input,
        value: config.btMaxPeers,
        key: 'bt-max-peers',
      ),
      //仅下载种子文件(bt-metadata-only)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.btMetadataOnly,
        key: 'bt-metadata-only',
      ),
      //最低加密级别(bt-min-crypto-level)
      FormItem<String>(
        type: FormItemType.select,
        value: config.btMinCryptoLevel,
        key: 'bt-min-crypto-level',
        options: [
          FormItemOption(label: "明文", value: "plain"),
          FormItemOption(label: "ARC4", value: "arc4"),
        ],
      ),
      //优先下载(bt-prioritize-piece)
      FormItem<String>(
        type: FormItemType.input,
        value: config.btPrioritizePiece,
        key: 'bt-prioritize-piece',
      ),
      //删除未选择的文件(bt-remove-unselected-file)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.btRemoveUnselectedFile,
        key: 'bt-remove-unselected-file',
      ),
      //需要加密(bt-require-crypto)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.btRequireCrypto,
        key: 'bt-require-crypto',
      ),
      //期望下载速度(bt-request-peer-speed-limit)
      FormItem<int>(
        type: FormItemType.input,
        value: config.btRequestPeerSpeedLimit,
        key: 'bt-request-peer-speed-limit',
        trailingBuilder: (context) =>
            buildUnitTrailing(context, S.of(context).bytes),
      ),
      //保存种子文件(bt-save-metadata)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.btSaveMetadata,
        key: 'bt-save-metadata',
      ),
      //不检查已经下载的文件(bt-seed-unverified)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.btSeedUnverified,
        key: 'bt-seed-unverified',
      ),
      //无速度时自动停止时间(bt-stop-timeout)
      FormItem<int>(
        type: FormItemType.input,
        value: config.btStopTimeOut,
        key: 'bt-stop-timeout',
        trailingBuilder: (context) =>
            buildUnitTrailing(context, S.of(context).second),
      ),
      //BT 服务器地址(bt-tracker)
      FormItem<String>(
        type: FormItemType.input,
        value: config.btTracker,
        key: 'bt-tracker',
      ),
      //BT 服务器连接超时时间(bt-tracker-connect-timeout)
      FormItem<int>(
        type: FormItemType.input,
        value: config.btTrackerConnectTimeout,
        key: 'bt-tracker-connect-timeout',
        trailingBuilder: (context) =>
            buildUnitTrailing(context, S.of(context).second),
      ),
      //BT 服务器连接间隔时间(bt-tracker-interval)
      FormItem<int>(
        type: FormItemType.input,
        value: config.btTrackerInterval,
        key: 'bt-tracker-interval',
      ),
      //BT 服务器超时时间(bt-tracker-timeout)
      FormItem<int>(
        type: FormItemType.input,
        value: config.btTrackerTimeout,
        key: 'bt-tracker-timeout',
        trailingBuilder: (context) =>
            buildUnitTrailing(context, S.of(context).second),
      ),
      //DHT (IPv4) 文件(dht-file-path)
      FormItem<String>(
        type: FormItemType.input,
        value: config.dhtFilePath,
        key: 'dht-file-path',
        readOnly: true,
      ),
      //DHT (IPv6) 文件(dht-file-path6)
      FormItem<String>(
        type: FormItemType.input,
        value: config.dhtFilePath6,
        key: 'dht-file-path6',
        readOnly: true,
      ),
      //DHT 监听端口(dht-listen-port)
      FormItem<String>(
        type: FormItemType.input,
        value: config.dhtListenPort,
        key: 'dht-listen-port',
        readOnly: true,
      ),
      //DHT 消息超时时间(dht-message-timeout)
      FormItem<int>(
        type: FormItemType.input,
        value: config.dhtMessageTimeout,
        key: 'dht-message-timeout',
        readOnly: true,
      ),
      //启用 DHT (IPv4)(enable-dht)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.enableDht,
        key: 'enable-dht',
        readOnly: true,
      ),
      //启用 DHT (IPv6)(enable-dht6)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.enableDht6,
        key: 'enable-dht6',
        readOnly: true,
      ),
      //启用节点交换(enable-peer-exchange)
      FormItem<bool>(
        type: FormItemType.switch_,
        value: config.enablePeerExchange,
        key: 'enable-peer-exchange',
      ),
      //下载种子中的文件(follow-torrent)
      FormItem<bool>(
        type: FormItemType.input,
        value: config.followTorrent,
        key: 'follow-torrent',
      ),
      //监听端口(listen-port)
      FormItem<int>(
        type: FormItemType.input,
        value: config.listenPort,
        key: 'listen-port',
        readOnly: true,
      ),
      //全局最大上传速度(max-overall-upload-limit)
      FormItem<int>(
        type: FormItemType.input,
        value: config.maxOverallUploadLimit,
        key: 'max-overall-upload-limit',
        trailingBuilder: (context) =>
            buildUnitTrailing(context, S.of(context).bytes),
      ),
      //最大上传速度(max-upload-limit)
      FormItem<int>(
        type: FormItemType.input,
        value: config.maxUploadLimit,
        key: 'max-upload-limit',
        trailingBuilder: (context) =>
            buildUnitTrailing(context, S.of(context).bytes),
      ),
      //节点 ID 前缀(peer-id-prefix)
      FormItem<String>(
        type: FormItemType.input,
        value: config.peerIdPrefix,
        key: 'peer-id-prefix',
        readOnly: true,
      ),
      //Peer Agent(peer-agent)
      FormItem<String>(
        type: FormItemType.input,
        value: config.peerAgent,
        key: 'peer-agent',
        readOnly: true,
      ),
      //最小分享率(seed-ratio)
      FormItem<double>(
        type: FormItemType.input,
        value: config.seedRatio,
        key: 'seed-ratio',
      ),
      //最小做种时间(seed-time)
      FormItem<double>(
        type: FormItemType.input,
        value: config.seedTime,
        key: 'seed-time',
        showDivider: false,
        trailingBuilder: (context) =>
            buildUnitTrailing(context, S.of(context).minute),
      ),
    ],
  );
}
