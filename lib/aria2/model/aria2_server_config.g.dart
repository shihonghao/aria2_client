// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aria2_server_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aria2ServerConfig _$Aria2ServerConfigFromJson(Map<String, dynamic> json) =>
    Aria2ServerConfig(
      json['version'] as String? ?? '',
      json['dir'] as String? ?? '',
      json['log'] as String? ?? '',
      _$JsonConverterFromJson<String, int>(json['max-concurrent-downloads'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, bool>(json['check-integrity'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['continue'], const StringToBoolConverter().fromJson) ??
          false,
      json['all-proxy'] as String? ?? '',
      json['all-proxy-user'] as String? ?? '',
      json['all-proxy-passwd'] as String? ?? '',
      _$JsonConverterFromJson<String, int>(json['connect-timeout'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, bool>(
              json['dry-run'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(json['lowest-speed-limit'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['max-connection-per-server'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['max-file-not-found'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(
              json['max-tries'], const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['min-split-size'],
              const StringToIntegerConverter().fromJson) ??
          0,
      json['netrc-path'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(
              json['no-netrc'], const StringToBoolConverter().fromJson) ??
          false,
      json['no-proxy'] as String? ?? '',
      json['proxy-method'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(
              json['remote-time'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['reuse-uri'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(
              json['retry-wait'], const StringToIntegerConverter().fromJson) ??
          0,
      json['server-stat-of'] as String? ?? '',
      _$JsonConverterFromJson<String, int>(json['server-stat-timeout'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(
              json['split'], const StringToIntegerConverter().fromJson) ??
          0,
      json['stream-piece-selector'] as String? ?? '',
      _$JsonConverterFromJson<String, int>(
              json['timeout'], const StringToIntegerConverter().fromJson) ??
          0,
      json['uri-selector'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(json['check-certificate'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['http-accept-gzip'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['http-auth-challenge'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['http-no-cache'], const StringToBoolConverter().fromJson) ??
          false,
      json['http-user'] as String? ?? '',
      json['http-passwd'] as String? ?? '',
      json['http-proxy'] as String? ?? '',
      json['http-proxy-user'] as String? ?? '',
      json['http-proxy-passwd'] as String? ?? '',
      json['https-passwd'] as String? ?? '',
      json['https-proxy'] as String? ?? '',
      json['https-proxy-user'] as String? ?? '',
      json['https-proxy-passwd'] as String? ?? '',
      json['referer'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(json['enable-http-keep-alive'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['enable-http-pipelining'],
              const StringToBoolConverter().fromJson) ??
          false,
      json['header'] as String? ?? '',
      json['save-cookies'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(
              json['use-head'], const StringToBoolConverter().fromJson) ??
          false,
      json['user-agent'] as String? ?? '',
      json['ftp-user'] as String? ?? '',
      json['ftp-passwd'] as String? ?? '',
      json['ftp-proxy'] as String? ?? '',
      json['ftp-proxy-user'] as String? ?? '',
      json['ftp-proxy-passwd'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(
              json['ftp-pasv'], const StringToBoolConverter().fromJson) ??
          false,
      json['ftp-type'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(json['ftp-reuse-connection'],
              const StringToBoolConverter().fromJson) ??
          false,
      json['ssh-host-key-md'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(json['bt-detach-seed-only'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['bt-enable-hook-after-hash-check'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['bt-enable-lpd'], const StringToBoolConverter().fromJson) ??
          false,
      json['bt-exclude-tracker'] as String? ?? '',
      json['bt-external-ip'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(json['bt-force-encryption'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['bt-hash-check-seed'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['bt-load-saved-metadata'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(json['bt-max-open-files'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['bt-max-peers'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, bool>(json['bt-metadata-only'],
              const StringToBoolConverter().fromJson) ??
          false,
      json['bt-min-crypto-level'] as String? ?? '',
      json['bt-prioritize-piece'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(json['bt-remove-unselected-file'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['bt-require-crypto'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(json['bt-request-peer-speed-limit'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, bool>(json['bt-save-metadata'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['bt-seed-unverified'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(json['bt-stop-timeout'],
              const StringToIntegerConverter().fromJson) ??
          0,
      json['bt-tracker'] as String? ?? '',
      _$JsonConverterFromJson<String, int>(json['bt-tracker-connect-timeout'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['bt-tracker-interval'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['bt-tracker-timeout'],
              const StringToIntegerConverter().fromJson) ??
          0,
      json['dht-file-path'] as String? ?? '',
      json['dht-file-path6'] as String? ?? '',
      json['dht-listen-port'] as String? ?? '',
      _$JsonConverterFromJson<String, int>(json['dht-message-timeout'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, bool>(
              json['enable-dht'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['enable-dht6'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['enable-peer-exchange'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['follow-torrent'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(
              json['listen-port'], const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['max-overall-upload-limit'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['max-upload-limit'],
              const StringToIntegerConverter().fromJson) ??
          0,
      json['peer-id-prefix'] as String? ?? '',
      json['peer-agent'] as String? ?? '',
      _$JsonConverterFromJson<String, double>(
              json['seed-ratio'], const StringToDoubleConverter().fromJson) ??
          0.0,
      _$JsonConverterFromJson<String, double>(
              json['seed-time'], const StringToDoubleConverter().fromJson) ??
          0.0,
      _$JsonConverterFromJson<String, bool>(json['follow-metalink'],
              const StringToBoolConverter().fromJson) ??
          false,
      json['metalink-base-url'] as String? ?? '',
      json['metalink-language'] as String? ?? '',
      json['metalink-location'] as String? ?? '',
      json['metalink-os'] as String? ?? '',
      json['metalink-version'] as String? ?? '',
      json['metalink-preferred-protocol'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(
              json['metalink-enable-unique-protocol'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['enable-rpc'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['rpc-allow-origin-all'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['rpc-listen-all'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['rpc-save-upload-metadata'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['rpc-secure'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['pause-metadata'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(json['rpc-listen-port'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['rpc-max-request-size'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, bool>(json['allow-overwrite'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['allow-piece-length-change'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['always-resume'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['async-dns'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['auto-file-renaming'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(json['auto-save-interval'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, bool>(json['conditional-get'],
              const StringToBoolConverter().fromJson) ??
          false,
      json['conf-path'] as String? ?? '',
      json['console-log-level'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(
              json['content-disposition-default-utf8'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['daemon'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['deferred-input'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['disable-ipv6'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(
              json['disk-cache'], const StringToIntegerConverter().fromJson) ??
          0,
      json['download-result'] as String? ?? '',
      _$JsonConverterFromJson<String, int>(
              json['dscp'], const StringToIntegerConverter().fromJson) ??
          0,
      json['rlimit-nofile'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(
              json['enable-color'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['enable-mmap'], const StringToBoolConverter().fromJson) ??
          false,
      json['event-poll'] as String? ?? '',
      json['file-allocation'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(
              json['force-save'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['save-not-found'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['hash-check-only'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['human-readable'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['keep-unfinished-download-result'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(json['max-download-result'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['max-mmap-limit'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['max-resume-failure-tries'],
              const StringToIntegerConverter().fromJson) ??
          0,
      json['min-tls-version'] as String? ?? '',
      json['log-level'] as String? ?? '',
      _$JsonConverterFromJson<String, bool>(
              json['optimize-concurrent-downloads'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(json['piece-length'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, bool>(json['show-console-readout'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(json['summary-interval'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['max-overall-download-limit'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['max-download-limit'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, bool>(
              json['no-conf'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, int>(json['no-file-allocation-limit'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, bool>(json['parameterized-uri'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(
              json['quiet'], const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['realtime-chunk-checksum'],
              const StringToBoolConverter().fromJson) ??
          false,
      _$JsonConverterFromJson<String, bool>(json['remove-control-file'],
              const StringToBoolConverter().fromJson) ??
          false,
      json['save-session'] as String? ?? '',
      _$JsonConverterFromJson<String, int>(json['save-session-interval'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(json['socket-recv-buffer-size'],
              const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, int>(
              json['stop'], const StringToIntegerConverter().fromJson) ??
          0,
      _$JsonConverterFromJson<String, bool>(json['truncate-console-readout'],
              const StringToBoolConverter().fromJson) ??
          false,
      json['enabledFeatures'] as List<dynamic>? ?? [],
    );

Map<String, dynamic> _$Aria2ServerConfigToJson(Aria2ServerConfig instance) =>
    <String, dynamic>{
      'version': instance.version,
      'dir': instance.dir,
      'log': instance.log,
      'max-concurrent-downloads': _$JsonConverterToJson<String, int>(
          instance.maxConcurrentDownloads,
          const StringToIntegerConverter().toJson),
      'check-integrity': _$JsonConverterToJson<String, bool>(
          instance.checkIntegrity, const StringToBoolConverter().toJson),
      'continue': _$JsonConverterToJson<String, bool>(
          instance.continueDownload, const StringToBoolConverter().toJson),
      'all-proxy': instance.allProxy,
      'all-proxy-user': instance.allProxyUser,
      'all-proxy-passwd': instance.allProxyPasswd,
      'connect-timeout': _$JsonConverterToJson<String, int>(
          instance.connectTimeout, const StringToIntegerConverter().toJson),
      'dry-run': _$JsonConverterToJson<String, bool>(
          instance.dryRun, const StringToBoolConverter().toJson),
      'lowest-speed-limit': _$JsonConverterToJson<String, int>(
          instance.lowestSpeedLimit, const StringToIntegerConverter().toJson),
      'max-connection-per-server': _$JsonConverterToJson<String, int>(
          instance.maxConnectionPerServer,
          const StringToIntegerConverter().toJson),
      'max-file-not-found': _$JsonConverterToJson<String, int>(
          instance.maxFileNotFound, const StringToIntegerConverter().toJson),
      'max-tries': _$JsonConverterToJson<String, int>(
          instance.maxTries, const StringToIntegerConverter().toJson),
      'min-split-size': _$JsonConverterToJson<String, int>(
          instance.minSplitSize, const StringToIntegerConverter().toJson),
      'netrc-path': instance.netrcPath,
      'no-netrc': _$JsonConverterToJson<String, bool>(
          instance.noNetrc, const StringToBoolConverter().toJson),
      'no-proxy': instance.noProxy,
      'proxy-method': instance.proxyMethod,
      'remote-time': _$JsonConverterToJson<String, bool>(
          instance.remoteTime, const StringToBoolConverter().toJson),
      'reuse-uri': _$JsonConverterToJson<String, bool>(
          instance.reuseUri, const StringToBoolConverter().toJson),
      'retry-wait': _$JsonConverterToJson<String, int>(
          instance.retryWait, const StringToIntegerConverter().toJson),
      'server-stat-of': instance.serverStatOf,
      'server-stat-timeout': _$JsonConverterToJson<String, int>(
          instance.serverStatTimeout, const StringToIntegerConverter().toJson),
      'split': _$JsonConverterToJson<String, int>(
          instance.split, const StringToIntegerConverter().toJson),
      'stream-piece-selector': instance.streamPieceSelector,
      'timeout': _$JsonConverterToJson<String, int>(
          instance.timeout, const StringToIntegerConverter().toJson),
      'uri-selector': instance.uriSelector,
      'check-certificate': _$JsonConverterToJson<String, bool>(
          instance.checkCertificate, const StringToBoolConverter().toJson),
      'http-accept-gzip': _$JsonConverterToJson<String, bool>(
          instance.httpAcceptGZip, const StringToBoolConverter().toJson),
      'http-auth-challenge': _$JsonConverterToJson<String, bool>(
          instance.httpAuthChallenge, const StringToBoolConverter().toJson),
      'http-no-cache': _$JsonConverterToJson<String, bool>(
          instance.httpNoCache, const StringToBoolConverter().toJson),
      'http-user': instance.httpUser,
      'http-passwd': instance.httpPasswd,
      'http-proxy': instance.httpProxy,
      'http-proxy-user': instance.httpProxyUser,
      'http-proxy-passwd': instance.httpProxyPasswd,
      'https-passwd': instance.httpsPasswd,
      'https-proxy': instance.httpsProxy,
      'https-proxy-user': instance.httpsProxyUser,
      'https-proxy-passwd': instance.httpsProxyPasswd,
      'referer': instance.referer,
      'enable-http-keep-alive': _$JsonConverterToJson<String, bool>(
          instance.enableHttpKeepAlive, const StringToBoolConverter().toJson),
      'enable-http-pipelining': _$JsonConverterToJson<String, bool>(
          instance.enableHttpPipelining, const StringToBoolConverter().toJson),
      'header': instance.header,
      'save-cookies': instance.saveCookies,
      'use-head': _$JsonConverterToJson<String, bool>(
          instance.useHead, const StringToBoolConverter().toJson),
      'user-agent': instance.userAgent,
      'ftp-user': instance.ftpUser,
      'ftp-passwd': instance.ftpPasswd,
      'ftp-proxy': instance.ftpProxy,
      'ftp-proxy-user': instance.ftpProxyUser,
      'ftp-proxy-passwd': instance.ftpProxyPasswd,
      'ftp-pasv': _$JsonConverterToJson<String, bool>(
          instance.ftpPassive, const StringToBoolConverter().toJson),
      'ftp-type': instance.ftpType,
      'ftp-reuse-connection': _$JsonConverterToJson<String, bool>(
          instance.ftpReuseConnection, const StringToBoolConverter().toJson),
      'ssh-host-key-md': instance.sshHostKeyMD,
      'bt-detach-seed-only': _$JsonConverterToJson<String, bool>(
          instance.btDetachSeedOnly, const StringToBoolConverter().toJson),
      'bt-enable-hook-after-hash-check': _$JsonConverterToJson<String, bool>(
          instance.btEnableHookAfterHashCheck,
          const StringToBoolConverter().toJson),
      'bt-enable-lpd': _$JsonConverterToJson<String, bool>(
          instance.btEnableLpd, const StringToBoolConverter().toJson),
      'bt-exclude-tracker': instance.btExcludeTracker,
      'bt-external-ip': instance.btExternalIp,
      'bt-force-encryption': _$JsonConverterToJson<String, bool>(
          instance.btForceEncryption, const StringToBoolConverter().toJson),
      'bt-hash-check-seed': _$JsonConverterToJson<String, bool>(
          instance.btHashCheckSeed, const StringToBoolConverter().toJson),
      'bt-load-saved-metadata': _$JsonConverterToJson<String, bool>(
          instance.btLoadSavedMetadata, const StringToBoolConverter().toJson),
      'bt-max-open-files': _$JsonConverterToJson<String, int>(
          instance.btMaxOpenFiles, const StringToIntegerConverter().toJson),
      'bt-max-peers': _$JsonConverterToJson<String, int>(
          instance.btMaxPeers, const StringToIntegerConverter().toJson),
      'bt-metadata-only': _$JsonConverterToJson<String, bool>(
          instance.btMetadataOnly, const StringToBoolConverter().toJson),
      'bt-min-crypto-level': instance.btMinCryptoLevel,
      'bt-prioritize-piece': instance.btPrioritizePiece,
      'bt-remove-unselected-file': _$JsonConverterToJson<String, bool>(
          instance.btRemoveUnselectedFile,
          const StringToBoolConverter().toJson),
      'bt-require-crypto': _$JsonConverterToJson<String, bool>(
          instance.btRequireCrypto, const StringToBoolConverter().toJson),
      'bt-request-peer-speed-limit': _$JsonConverterToJson<String, int>(
          instance.btRequestPeerSpeedLimit,
          const StringToIntegerConverter().toJson),
      'bt-save-metadata': _$JsonConverterToJson<String, bool>(
          instance.btSaveMetadata, const StringToBoolConverter().toJson),
      'bt-seed-unverified': _$JsonConverterToJson<String, bool>(
          instance.btSeedUnverified, const StringToBoolConverter().toJson),
      'bt-stop-timeout': _$JsonConverterToJson<String, int>(
          instance.btStopTimeOut, const StringToIntegerConverter().toJson),
      'bt-tracker': instance.btTracker,
      'bt-tracker-connect-timeout': _$JsonConverterToJson<String, int>(
          instance.btTrackerConnectTimeout,
          const StringToIntegerConverter().toJson),
      'bt-tracker-interval': _$JsonConverterToJson<String, int>(
          instance.btTrackerInterval, const StringToIntegerConverter().toJson),
      'bt-tracker-timeout': _$JsonConverterToJson<String, int>(
          instance.btTrackerTimeout, const StringToIntegerConverter().toJson),
      'dht-file-path': instance.dhtFilePath,
      'dht-file-path6': instance.dhtFilePath6,
      'dht-listen-port': instance.dhtListenPort,
      'dht-message-timeout': _$JsonConverterToJson<String, int>(
          instance.dhtMessageTimeout, const StringToIntegerConverter().toJson),
      'enable-dht': _$JsonConverterToJson<String, bool>(
          instance.enableDht, const StringToBoolConverter().toJson),
      'enable-dht6': _$JsonConverterToJson<String, bool>(
          instance.enableDht6, const StringToBoolConverter().toJson),
      'enable-peer-exchange': _$JsonConverterToJson<String, bool>(
          instance.enablePeerExchange, const StringToBoolConverter().toJson),
      'follow-torrent': _$JsonConverterToJson<String, bool>(
          instance.followTorrent, const StringToBoolConverter().toJson),
      'listen-port': _$JsonConverterToJson<String, int>(
          instance.listenPort, const StringToIntegerConverter().toJson),
      'max-overall-upload-limit': _$JsonConverterToJson<String, int>(
          instance.maxOverallUploadLimit,
          const StringToIntegerConverter().toJson),
      'max-upload-limit': _$JsonConverterToJson<String, int>(
          instance.maxUploadLimit, const StringToIntegerConverter().toJson),
      'peer-id-prefix': instance.peerIdPrefix,
      'peer-agent': instance.peerAgent,
      'seed-ratio': _$JsonConverterToJson<String, double>(
          instance.seedRatio, const StringToDoubleConverter().toJson),
      'seed-time': _$JsonConverterToJson<String, double>(
          instance.seedTime, const StringToDoubleConverter().toJson),
      'follow-metalink': _$JsonConverterToJson<String, bool>(
          instance.followMetaLink, const StringToBoolConverter().toJson),
      'metalink-base-url': instance.metalinkBaseUrl,
      'metalink-language': instance.metalinkLanguage,
      'metalink-location': instance.metalinkLocation,
      'metalink-os': instance.metalinkOs,
      'metalink-version': instance.metalinkVersion,
      'metalink-preferred-protocol': instance.metalinkPreferredProtocol,
      'metalink-enable-unique-protocol': _$JsonConverterToJson<String, bool>(
          instance.metalinkEnableUniqueProtocol,
          const StringToBoolConverter().toJson),
      'enable-rpc': _$JsonConverterToJson<String, bool>(
          instance.enableRpc, const StringToBoolConverter().toJson),
      'rpc-allow-origin-all': _$JsonConverterToJson<String, bool>(
          instance.rpcAllowOriginAll, const StringToBoolConverter().toJson),
      'rpc-listen-all': _$JsonConverterToJson<String, bool>(
          instance.rpcListenAll, const StringToBoolConverter().toJson),
      'rpc-save-upload-metadata': _$JsonConverterToJson<String, bool>(
          instance.rpcSaveUploadMetadata, const StringToBoolConverter().toJson),
      'rpc-secure': _$JsonConverterToJson<String, bool>(
          instance.rpcSecure, const StringToBoolConverter().toJson),
      'pause-metadata': _$JsonConverterToJson<String, bool>(
          instance.pauseMetadata, const StringToBoolConverter().toJson),
      'rpc-listen-port': _$JsonConverterToJson<String, int>(
          instance.rpcListenPort, const StringToIntegerConverter().toJson),
      'rpc-max-request-size': _$JsonConverterToJson<String, int>(
          instance.rpcMaxRequestSize, const StringToIntegerConverter().toJson),
      'allow-overwrite': _$JsonConverterToJson<String, bool>(
          instance.allowOverwrite, const StringToBoolConverter().toJson),
      'allow-piece-length-change': _$JsonConverterToJson<String, bool>(
          instance.allowPieceLengthChange,
          const StringToBoolConverter().toJson),
      'always-resume': _$JsonConverterToJson<String, bool>(
          instance.alwaysResume, const StringToBoolConverter().toJson),
      'async-dns': _$JsonConverterToJson<String, bool>(
          instance.asyncDns, const StringToBoolConverter().toJson),
      'auto-file-renaming': _$JsonConverterToJson<String, bool>(
          instance.autoFileRenaming, const StringToBoolConverter().toJson),
      'auto-save-interval': _$JsonConverterToJson<String, int>(
          instance.autoSaveInterval, const StringToIntegerConverter().toJson),
      'conditional-get': _$JsonConverterToJson<String, bool>(
          instance.conditionalGet, const StringToBoolConverter().toJson),
      'conf-path': instance.confPath,
      'console-log-level': instance.consoleLogLevel,
      'content-disposition-default-utf8': _$JsonConverterToJson<String, bool>(
          instance.contentDispositionDefaultUtf8,
          const StringToBoolConverter().toJson),
      'daemon': _$JsonConverterToJson<String, bool>(
          instance.daemon, const StringToBoolConverter().toJson),
      'deferred-input': _$JsonConverterToJson<String, bool>(
          instance.deferredInput, const StringToBoolConverter().toJson),
      'disable-ipv6': _$JsonConverterToJson<String, bool>(
          instance.disableIpv6, const StringToBoolConverter().toJson),
      'disk-cache': _$JsonConverterToJson<String, int>(
          instance.diskCache, const StringToIntegerConverter().toJson),
      'download-result': instance.downloadResult,
      'dscp': _$JsonConverterToJson<String, int>(
          instance.dscp, const StringToIntegerConverter().toJson),
      'rlimit-nofile': instance.rlimitNofile,
      'enable-color': _$JsonConverterToJson<String, bool>(
          instance.enableColor, const StringToBoolConverter().toJson),
      'enable-mmap': _$JsonConverterToJson<String, bool>(
          instance.enableMmap, const StringToBoolConverter().toJson),
      'event-poll': instance.eventPoll,
      'file-allocation': instance.fileAllocation,
      'force-save': _$JsonConverterToJson<String, bool>(
          instance.forceSave, const StringToBoolConverter().toJson),
      'save-not-found': _$JsonConverterToJson<String, bool>(
          instance.saveNotFound, const StringToBoolConverter().toJson),
      'hash-check-only': _$JsonConverterToJson<String, bool>(
          instance.hashCheckOnly, const StringToBoolConverter().toJson),
      'human-readable': _$JsonConverterToJson<String, bool>(
          instance.humanReadable, const StringToBoolConverter().toJson),
      'keep-unfinished-download-result': _$JsonConverterToJson<String, bool>(
          instance.keepUnfinishedDownloadResult,
          const StringToBoolConverter().toJson),
      'max-download-result': _$JsonConverterToJson<String, int>(
          instance.maxDownloadResult, const StringToIntegerConverter().toJson),
      'max-mmap-limit': _$JsonConverterToJson<String, int>(
          instance.maxMmapLimit, const StringToIntegerConverter().toJson),
      'max-resume-failure-tries': _$JsonConverterToJson<String, int>(
          instance.maxResumeFailureTries,
          const StringToIntegerConverter().toJson),
      'min-tls-version': instance.minTlsVersion,
      'log-level': instance.logLevel,
      'optimize-concurrent-downloads': _$JsonConverterToJson<String, bool>(
          instance.optimizeConcurrentDownloads,
          const StringToBoolConverter().toJson),
      'piece-length': _$JsonConverterToJson<String, int>(
          instance.pieceLength, const StringToIntegerConverter().toJson),
      'show-console-readout': _$JsonConverterToJson<String, bool>(
          instance.showConsoleReadout, const StringToBoolConverter().toJson),
      'summary-interval': _$JsonConverterToJson<String, int>(
          instance.summaryInterval, const StringToIntegerConverter().toJson),
      'max-overall-download-limit': _$JsonConverterToJson<String, int>(
          instance.maxOverallDownloadLimit,
          const StringToIntegerConverter().toJson),
      'max-download-limit': _$JsonConverterToJson<String, int>(
          instance.maxDownloadLimit, const StringToIntegerConverter().toJson),
      'no-conf': _$JsonConverterToJson<String, bool>(
          instance.noConf, const StringToBoolConverter().toJson),
      'no-file-allocation-limit': _$JsonConverterToJson<String, int>(
          instance.noFileAllocationLimit,
          const StringToIntegerConverter().toJson),
      'parameterized-uri': _$JsonConverterToJson<String, bool>(
          instance.parameterizedUri, const StringToBoolConverter().toJson),
      'quiet': _$JsonConverterToJson<String, bool>(
          instance.quiet, const StringToBoolConverter().toJson),
      'realtime-chunk-checksum': _$JsonConverterToJson<String, bool>(
          instance.realtimeChunkChecksum, const StringToBoolConverter().toJson),
      'remove-control-file': _$JsonConverterToJson<String, bool>(
          instance.removeControlFile, const StringToBoolConverter().toJson),
      'save-session': instance.saveSession,
      'save-session-interval': _$JsonConverterToJson<String, int>(
          instance.saveSessionInterval,
          const StringToIntegerConverter().toJson),
      'socket-recv-buffer-size': _$JsonConverterToJson<String, int>(
          instance.socketRecvBufferSize,
          const StringToIntegerConverter().toJson),
      'stop': _$JsonConverterToJson<String, int>(
          instance.stop, const StringToIntegerConverter().toJson),
      'truncate-console-readout': _$JsonConverterToJson<String, bool>(
          instance.truncateConsoleReadout,
          const StringToBoolConverter().toJson),
      'enabledFeatures': instance.enabledFeatures,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
