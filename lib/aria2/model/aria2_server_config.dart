import 'package:json_annotation/json_annotation.dart';
import 'json/converter.dart';

part 'aria2_server_config.g.dart';

enum ProxyMethod { get, tunnel }

@JsonSerializable()
class Aria2ServerConfig {
  @JsonKey(name: "version",defaultValue: "")
  String? version;
  @JsonKey(name: "dir",defaultValue: "")
  String? dir;
  @JsonKey(name: "log",defaultValue: "")
  String? log;
  @JsonKey(name: "max-concurrent-downloads",defaultValue: 0)
  @StringToIntegerConverter()
  int? maxConcurrentDownloads;
  @JsonKey(name: "check-integrity",defaultValue: false)
  @StringToBoolConverter()
  bool? checkIntegrity;
  @JsonKey(name: "continue",defaultValue: false)
  @StringToBoolConverter()
  bool? continueDownload;
  @JsonKey(name: "all-proxy",defaultValue: "")
  String? allProxy;
  @JsonKey(name: "all-proxy-user",defaultValue: "")
  String? allProxyUser;
  @JsonKey(name: "all-proxy-passwd",defaultValue: "")
  String? allProxyPasswd;
  @JsonKey(name: "connect-timeout",defaultValue: 0)
  @StringToIntegerConverter()
  int? connectTimeout;
  @JsonKey(name: "dry-run",defaultValue: false)
  @StringToBoolConverter()
  bool? dryRun;
  @JsonKey(name: "lowest-speed-limit",defaultValue: 0)
  @StringToIntegerConverter()
  int? lowestSpeedLimit;
  @JsonKey(name: "max-connection-per-server",defaultValue: 0)
  @StringToIntegerConverter()
  int? maxConnectionPerServer;
  @JsonKey(name: "max-file-not-found",defaultValue: 0)
  @StringToIntegerConverter()
  int? maxFileNotFound;
  @JsonKey(name: "max-tries",defaultValue: 0)
  @StringToIntegerConverter()
  int? maxTries;
  @JsonKey(name: "min-split-size",defaultValue: 0)
  @StringToIntegerConverter()
  int? minSplitSize;
  @JsonKey(name: "netrc-path",defaultValue: "")
  String? netrcPath;
  @JsonKey(name: "no-netrc",defaultValue: false)
  @StringToBoolConverter()
  bool? noNetrc;
  @JsonKey(name: "no-proxy",defaultValue: "")
  String? noProxy;
  @JsonKey(name: "proxy-method",defaultValue: "")
  String? proxyMethod;
  @JsonKey(name: "remote-time",defaultValue: false)
  @StringToBoolConverter()
  bool? remoteTime;
  @JsonKey(name: "reuse-uri",defaultValue: false)
  @StringToBoolConverter()
  bool? reuseUri;
  @JsonKey(name: "retry-wait",defaultValue: 0)
  @StringToIntegerConverter()
  int? retryWait;
  @JsonKey(name: "server-stat-of",defaultValue: "")
  String? serverStatOf;
  @JsonKey(name: "server-stat-timeout",defaultValue: 0)
  @StringToIntegerConverter()
  int? serverStatTimeout;
  @JsonKey(name: "split",defaultValue: 0)
  @StringToIntegerConverter()
  int? split;
  @JsonKey(name: "stream-piece-selector",defaultValue: "")
  String? streamPieceSelector;
  @JsonKey(name: "timeout",defaultValue: 0)
  @StringToIntegerConverter()
  int? timeout;
  @JsonKey(name: "uri-selector",defaultValue: "")
  String? uriSelector;
  @JsonKey(name: "check-certificate",defaultValue: false)
  @StringToBoolConverter()
  bool? checkCertificate;
  @JsonKey(name: "http-accept-gzip",defaultValue: false)
  @StringToBoolConverter()
  bool? httpAcceptGZip;
  @JsonKey(name: "http-auth-challenge",defaultValue: false)
  @StringToBoolConverter()
  bool? httpAuthChallenge;
  @JsonKey(name: "http-no-cache",defaultValue: false)
  @StringToBoolConverter()
  bool? httpNoCache;
  @JsonKey(name: "http-user",defaultValue: "")
  String? httpUser;
  @JsonKey(name: "http-passwd",defaultValue: "")
  String? httpPasswd;
  @JsonKey(name: "http-proxy",defaultValue: "")
  String? httpProxy;
  @JsonKey(name: "http-proxy-user",defaultValue: "")
  String? httpProxyUser;
  @JsonKey(name: "http-proxy-passwd",defaultValue: "")
  String? httpProxyPasswd;
  @JsonKey(name: "https-passwd",defaultValue: "")
  String? httpsPasswd;
  @JsonKey(name: "https-proxy",defaultValue: "")
  String? httpsProxy;
  @JsonKey(name: "https-proxy-user",defaultValue: "")
  String? httpsProxyUser;
  @JsonKey(name: "https-proxy-passwd",defaultValue: "")
  String? httpsProxyPasswd;
  @JsonKey(name: "referer",defaultValue: "")
  String? referer;
  @JsonKey(name: "enable-http-keep-alive",defaultValue: false)
  @StringToBoolConverter()
  bool? enableHttpKeepAlive;
  @JsonKey(name: "enable-http-pipelining",defaultValue: false)
  @StringToBoolConverter()
  bool? enableHttpPipelining;
  @JsonKey(name: "header",defaultValue: "")
  String? header;
  @JsonKey(name: "save-cookies",defaultValue: "")
  String? saveCookies;
  @JsonKey(name: "use-head",defaultValue: false)
  @StringToBoolConverter()
  bool? useHead;
  @JsonKey(name: "user-agent",defaultValue: "")
  String? userAgent;
  @JsonKey(name: "ftp-user",defaultValue: "")
  String? ftpUser;
  @JsonKey(name: "ftp-passwd",defaultValue: "")
  String? ftpPasswd;
  @JsonKey(name: "ftp-proxy",defaultValue: "")
  String? ftpProxy;
  @JsonKey(name: "ftp-proxy-user",defaultValue: "")
  String? ftpProxyUser;
  @JsonKey(name: "ftp-proxy-passwd",defaultValue: "")
  String? ftpProxyPasswd;
  @JsonKey(name: "ftp-pasv",defaultValue: false)
  @StringToBoolConverter()
  bool? ftpPassive;
  @JsonKey(name: "ftp-type",defaultValue: "")
  String? ftpType;
  @JsonKey(name: "ftp-reuse-connection",defaultValue: false)
  @StringToBoolConverter()
  bool? ftpReuseConnection;
  @JsonKey(name: "ssh-host-key-md",defaultValue: "")
  String? sshHostKeyMD;
  @JsonKey(name: "bt-detach-seed-only",defaultValue: false)
  @StringToBoolConverter()
  bool? btDetachSeedOnly;
  @JsonKey(name: "bt-enable-hook-after-hash-check",defaultValue: false)
  @StringToBoolConverter()
  bool? btEnableHookAfterHashCheck;
  @JsonKey(name: "bt-enable-lpd",defaultValue: false)
  @StringToBoolConverter()
  bool? btEnableLpd;
  @JsonKey(name: "bt-exclude-tracker",defaultValue: "")
  String? btExcludeTracker;
  @JsonKey(name: "bt-external-ip",defaultValue: "")
  String? btExternalIp;
  @JsonKey(name: "bt-force-encryption",defaultValue: false)
  @StringToBoolConverter()
  bool? btForceEncryption;
  @JsonKey(name: "bt-hash-check-seed",defaultValue: false)
  @StringToBoolConverter()
  bool? btHashCheckSeed;
  @JsonKey(name: "bt-load-saved-metadata",defaultValue: false)
  @StringToBoolConverter()
  bool? btLoadSavedMetadata;
  @JsonKey(name: "bt-max-open-files",defaultValue: 0)
  @StringToIntegerConverter()
  int? btMaxOpenFiles;
  @JsonKey(name: "bt-max-peers",defaultValue: 0)
  @StringToIntegerConverter()
  int? btMaxPeers;
  @JsonKey(name: "bt-metadata-only",defaultValue: false)
  @StringToBoolConverter()
  bool? btMetadataOnly;
  @JsonKey(name: "bt-min-crypto-level",defaultValue: "")
  String? btMinCryptoLevel;
  @JsonKey(name: "bt-prioritize-piece",defaultValue: "")
  String? btPrioritizePiece;
  @JsonKey(name: "bt-remove-unselected-file",defaultValue: false)
  @StringToBoolConverter()
  bool? btRemoveUnselectedFile;
  @JsonKey(name: "bt-require-crypto",defaultValue: false)
  @StringToBoolConverter()
  bool? btRequireCrypto;
  @JsonKey(name: "bt-request-peer-speed-limit",defaultValue: 0)
  @StringToIntegerConverter()
  int? btRequestPeerSpeedLimit;
  @JsonKey(name: "bt-save-metadata",defaultValue: false)
  @StringToBoolConverter()
  bool? btSaveMetadata;
  @JsonKey(name: "bt-seed-unverified",defaultValue: false)
  @StringToBoolConverter()
  bool? btSeedUnverified;
  @JsonKey(name: "bt-stop-timeout",defaultValue: 0)
  @StringToIntegerConverter()
  int? btStopTimeOut;
  @JsonKey(name: "bt-tracker",defaultValue: "")
  String? btTracker;
  @JsonKey(name: "bt-tracker-connect-timeout",defaultValue: 0)
  @StringToIntegerConverter()
  int? btTrackerConnectTimeout;
  @JsonKey(name: "bt-tracker-interval",defaultValue: 0)
  @StringToIntegerConverter()
  int? btTrackerInterval;
  @JsonKey(name: "bt-tracker-timeout",defaultValue: 0)
  @StringToIntegerConverter()
  int? btTrackerTimeout;
  @JsonKey(name: "dht-file-path",defaultValue: "")
  String? dhtFilePath;
  @JsonKey(name: "dht-file-path6",defaultValue: "")
  String? dhtFilePath6;
  @JsonKey(name: "dht-listen-port",defaultValue: "")
  String? dhtListenPort;
  @JsonKey(name: "dht-message-timeout",defaultValue: 0)
  @StringToIntegerConverter()
  int? dhtMessageTimeout;
  @JsonKey(name: "enable-dht",defaultValue: false)
  @StringToBoolConverter()
  bool? enableDht;
  @JsonKey(name: "enable-dht6",defaultValue: false)
  @StringToBoolConverter()
  bool? enableDht6;
  @JsonKey(name: "enable-peer-exchange",defaultValue: false)
  @StringToBoolConverter()
  bool? enablePeerExchange;
  @JsonKey(name: "follow-torrent",defaultValue: false)
  @StringToBoolConverter()
  bool? followTorrent;
  @JsonKey(name: "listen-port",defaultValue: 0)
  @StringToIntegerConverter()
  int? listenPort;
  @JsonKey(name: "max-overall-upload-limit",defaultValue: 0)
  @StringToIntegerConverter()
  int? maxOverallUploadLimit;
  @JsonKey(name: "max-upload-limit",defaultValue: 0)
  @StringToIntegerConverter()
  int? maxUploadLimit;
  @JsonKey(name: "peer-id-prefix",defaultValue: "")
  String? peerIdPrefix;
  @JsonKey(name: "peer-agent",defaultValue: "")
  String? peerAgent;
  @JsonKey(name: "seed-ratio",defaultValue: 0.0)
  @StringToDoubleConverter()
  double? seedRatio;
  @JsonKey(name: "seed-time",defaultValue: 0.0)
  @StringToDoubleConverter()
  double? seedTime;
  @JsonKey(name: "follow-metalink",defaultValue: false)
  @StringToBoolConverter()
  bool? followMetaLink;
  @JsonKey(name: "metalink-base-url",defaultValue: "")
  String? metalinkBaseUrl;
  @JsonKey(name: "metalink-language",defaultValue: "")
  String? metalinkLanguage;
  @JsonKey(name: "metalink-location",defaultValue: "")
  String? metalinkLocation;
  @JsonKey(name: "metalink-os",defaultValue: "")
  String? metalinkOs;
  @JsonKey(name: "metalink-version",defaultValue: "")
  String? metalinkVersion;
  @JsonKey(name: "metalink-preferred-protocol",defaultValue: "")
  String? metalinkPreferredProtocol;
  @JsonKey(name: "metalink-enable-unique-protocol",defaultValue: false)
  @StringToBoolConverter()
  bool? metalinkEnableUniqueProtocol;
  @JsonKey(name: "enable-rpc",defaultValue: false)
  @StringToBoolConverter()
  bool? enableRpc;
  @JsonKey(name: "rpc-allow-origin-all",defaultValue: false)
  @StringToBoolConverter()
  bool? rpcAllowOriginAll;
  @JsonKey(name: "rpc-listen-all",defaultValue: false)
  @StringToBoolConverter()
  bool? rpcListenAll;
  @JsonKey(name: "rpc-save-upload-metadata",defaultValue: false)
  @StringToBoolConverter()
  bool? rpcSaveUploadMetadata;
  @JsonKey(name: "rpc-secure",defaultValue: false)
  @StringToBoolConverter()
  bool? rpcSecure;
  @JsonKey(name: "pause-metadata",defaultValue: false)
  @StringToBoolConverter()
  bool? pauseMetadata;
  @JsonKey(name: "rpc-listen-port",defaultValue: 0)
  @StringToIntegerConverter()
  int? rpcListenPort;
  @JsonKey(name: "rpc-max-request-size",defaultValue: 0)
  @StringToIntegerConverter()
  int? rpcMaxRequestSize;
  @JsonKey(name: "allow-overwrite",defaultValue: false)
  @StringToBoolConverter()
  bool? allowOverwrite;
  @JsonKey(name: "allow-piece-length-change",defaultValue: false)
  @StringToBoolConverter()
  bool? allowPieceLengthChange;
  @JsonKey(name: "always-resume",defaultValue: false)
  @StringToBoolConverter()
  bool? alwaysResume;
  @JsonKey(name: "async-dns",defaultValue: false)
  @StringToBoolConverter()
  bool? asyncDns;
  @JsonKey(name: "auto-file-renaming",defaultValue: false)
  @StringToBoolConverter()
  bool? autoFileRenaming;
  @JsonKey(name: "auto-save-interval",defaultValue: 0)
  @StringToIntegerConverter()
  int? autoSaveInterval;
  @JsonKey(name: "conditional-get",defaultValue: false)
  @StringToBoolConverter()
  bool? conditionalGet;
  @JsonKey(name: "conf-path",defaultValue: "")
  String? confPath;
  @JsonKey(name: "console-log-level",defaultValue: "")
  String? consoleLogLevel;
  @JsonKey(name: "content-disposition-default-utf8",defaultValue: false)
  @StringToBoolConverter()
  bool? contentDispositionDefaultUtf8;
  @JsonKey(name: "daemon",defaultValue: false)
  @StringToBoolConverter()
  bool? daemon;
  @JsonKey(name: "deferred-input",defaultValue: false)
  @StringToBoolConverter()
  bool? deferredInput;
  @JsonKey(name: "disable-ipv6",defaultValue: false)
  @StringToBoolConverter()
  bool? disableIpv6;
  @JsonKey(name: "disk-cache",defaultValue: 0)
  @StringToIntegerConverter()
  int? diskCache;
  @JsonKey(name: "download-result",defaultValue: "")
  String? downloadResult;
  @JsonKey(name: "dscp",defaultValue: 0)
  @StringToIntegerConverter()
  int? dscp;
  @JsonKey(name: "rlimit-nofile",defaultValue: 0)
  @StringToIntegerConverter()
  int? rlimitNofile;
  @JsonKey(name: "enable-color",defaultValue: false)
  @StringToBoolConverter()
  bool? enableColor;
  @JsonKey(name: "enable-mmap",defaultValue: false)
  @StringToBoolConverter()
  bool? enableMmap;
  @JsonKey(name: "event-poll",defaultValue: "")
  String? eventPoll;
  @JsonKey(name: "file-allocation",defaultValue: "")
  String? fileAllocation;
  @JsonKey(name: "force-save",defaultValue: false)
  @StringToBoolConverter()
  bool? forceSave;
  @JsonKey(name: "save-not-found",defaultValue: false)
  @StringToBoolConverter()
  bool? saveNotFound;
  @JsonKey(name: "hash-check-only",defaultValue: false)
  @StringToBoolConverter()
  bool? hashCheckOnly;
  @JsonKey(name: "human-readable",defaultValue: false)
  @StringToBoolConverter()
  bool? humanReadable;
  @JsonKey(name: "keep-unfinished-download-result",defaultValue: false)
  @StringToBoolConverter()
  bool? keepUnfinishedDownloadResult;
  @JsonKey(name: "max-download-result",defaultValue: 0)
  @StringToIntegerConverter()
  int? maxDownloadResult;
  @JsonKey(name: "max-mmap-limit",defaultValue: 0)
  @StringToIntegerConverter()
  int? maxMmapLimit;
  @JsonKey(name: "max-resume-failure-tries",defaultValue: 0)
  @StringToIntegerConverter()
  int? maxResumeFailureTries;
  @JsonKey(name: "min-tls-version",defaultValue: "")
  String? minTlsVersion;
  @JsonKey(name: "log-level",defaultValue: "")
  String? logLevel;
  @JsonKey(name: "optimize-concurrent-downloads",defaultValue: false)
  @StringToBoolConverter()
  bool? optimizeConcurrentDownloads;
  @JsonKey(name: "piece-length",defaultValue: 0)
  @StringToIntegerConverter()
  int? pieceLength;
  @JsonKey(name: "show-console-readout",defaultValue: false)
  @StringToBoolConverter()
  bool? showConsoleReadout;
  @JsonKey(name: "summary-interval",defaultValue: 0)
  @StringToIntegerConverter()
  int? summaryInterval;
  @JsonKey(name: "max-overall-download-limit",defaultValue: 0)
  @StringToIntegerConverter()
  int? maxOverallDownloadLimit;
  @JsonKey(name: "max-download-limit",defaultValue: 0)
  @StringToIntegerConverter()
  int? maxDownloadLimit;
  @JsonKey(name: "no-conf",defaultValue: false)
  @StringToBoolConverter()
  bool? noConf;
  @JsonKey(name: "no-file-allocation-limit",defaultValue: 0)
  @StringToIntegerConverter()
  int? noFileAllocationLimit;
  @JsonKey(name: "parameterized-uri",defaultValue: false)
  @StringToBoolConverter()
  bool? parameterizedUri;
  @JsonKey(name: "quiet",defaultValue: false)
  @StringToBoolConverter()
  bool? quiet;
  @JsonKey(name: "realtime-chunk-checksum",defaultValue: false)
  @StringToBoolConverter()
  bool? realtimeChunkChecksum;
  @JsonKey(name: "remove-control-file",defaultValue: false)
  @StringToBoolConverter()
  bool? removeControlFile;
  @JsonKey(name: "save-session",defaultValue: "")
  String? saveSession;
  @JsonKey(name: "save-session-interval",defaultValue: 0)
  @StringToIntegerConverter()
  int? saveSessionInterval;
  @JsonKey(name: "socket-recv-buffer-size",defaultValue: 0)
  @StringToIntegerConverter()
  int? socketRecvBufferSize;
  @JsonKey(name: "stop",defaultValue: 0)
  @StringToIntegerConverter()
  int? stop;
  @JsonKey(name: "truncate-console-readout",defaultValue: false)
  @StringToBoolConverter()
  bool? truncateConsoleReadout;
  @JsonKey(name: "enabledFeatures",defaultValue: [])
  List<dynamic> enabledFeatures;

  Aria2ServerConfig(
      this.version,
      this.dir,
      this.log,
      this.maxConcurrentDownloads,
      this.checkIntegrity,
      this.continueDownload,
      this.allProxy,
      this.allProxyUser,
      this.allProxyPasswd,
      this.connectTimeout,
      this.dryRun,
      this.lowestSpeedLimit,
      this.maxConnectionPerServer,
      this.maxFileNotFound,
      this.maxTries,
      this.minSplitSize,
      this.netrcPath,
      this.noNetrc,
      this.noProxy,
      this.proxyMethod,
      this.remoteTime,
      this.reuseUri,
      this.retryWait,
      this.serverStatOf,
      this.serverStatTimeout,
      this.split,
      this.streamPieceSelector,
      this.timeout,
      this.uriSelector,
      this.checkCertificate,
      this.httpAcceptGZip,
      this.httpAuthChallenge,
      this.httpNoCache,
      this.httpUser,
      this.httpPasswd,
      this.httpProxy,
      this.httpProxyUser,
      this.httpProxyPasswd,
      this.httpsPasswd,
      this.httpsProxy,
      this.httpsProxyUser,
      this.httpsProxyPasswd,
      this.referer,
      this.enableHttpKeepAlive,
      this.enableHttpPipelining,
      this.header,
      this.saveCookies,
      this.useHead,
      this.userAgent,
      this.ftpUser,
      this.ftpPasswd,
      this.ftpProxy,
      this.ftpProxyUser,
      this.ftpProxyPasswd,
      this.ftpPassive,
      this.ftpType,
      this.ftpReuseConnection,
      this.sshHostKeyMD,
      this.btDetachSeedOnly,
      this.btEnableHookAfterHashCheck,
      this.btEnableLpd,
      this.btExcludeTracker,
      this.btExternalIp,
      this.btForceEncryption,
      this.btHashCheckSeed,
      this.btLoadSavedMetadata,
      this.btMaxOpenFiles,
      this.btMaxPeers,
      this.btMetadataOnly,
      this.btMinCryptoLevel,
      this.btPrioritizePiece,
      this.btRemoveUnselectedFile,
      this.btRequireCrypto,
      this.btRequestPeerSpeedLimit,
      this.btSaveMetadata,
      this.btSeedUnverified,
      this.btStopTimeOut,
      this.btTracker,
      this.btTrackerConnectTimeout,
      this.btTrackerInterval,
      this.btTrackerTimeout,
      this.dhtFilePath,
      this.dhtFilePath6,
      this.dhtListenPort,
      this.dhtMessageTimeout,
      this.enableDht,
      this.enableDht6,
      this.enablePeerExchange,
      this.followTorrent,
      this.listenPort,
      this.maxOverallUploadLimit,
      this.maxUploadLimit,
      this.peerIdPrefix,
      this.peerAgent,
      this.seedRatio,
      this.seedTime,
      this.followMetaLink,
      this.metalinkBaseUrl,
      this.metalinkLanguage,
      this.metalinkLocation,
      this.metalinkOs,
      this.metalinkVersion,
      this.metalinkPreferredProtocol,
      this.metalinkEnableUniqueProtocol,
      this.enableRpc,
      this.rpcAllowOriginAll,
      this.rpcListenAll,
      this.rpcSaveUploadMetadata,
      this.rpcSecure,
      this.pauseMetadata,
      this.rpcListenPort,
      this.rpcMaxRequestSize,
      this.allowOverwrite,
      this.allowPieceLengthChange,
      this.alwaysResume,
      this.asyncDns,
      this.autoFileRenaming,
      this.autoSaveInterval,
      this.conditionalGet,
      this.confPath,
      this.consoleLogLevel,
      this.contentDispositionDefaultUtf8,
      this.daemon,
      this.deferredInput,
      this.disableIpv6,
      this.diskCache,
      this.downloadResult,
      this.dscp,
      this.rlimitNofile,
      this.enableColor,
      this.enableMmap,
      this.eventPoll,
      this.fileAllocation,
      this.forceSave,
      this.saveNotFound,
      this.hashCheckOnly,
      this.humanReadable,
      this.keepUnfinishedDownloadResult,
      this.maxDownloadResult,
      this.maxMmapLimit,
      this.maxResumeFailureTries,
      this.minTlsVersion,
      this.logLevel,
      this.optimizeConcurrentDownloads,
      this.pieceLength,
      this.showConsoleReadout,
      this.summaryInterval,
      this.maxOverallDownloadLimit,
      this.maxDownloadLimit,
      this.noConf,
      this.noFileAllocationLimit,
      this.parameterizedUri,
      this.quiet,
      this.realtimeChunkChecksum,
      this.removeControlFile,
      this.saveSession,
      this.saveSessionInterval,
      this.socketRecvBufferSize,
      this.stop,
      this.truncateConsoleReadout,
      this.enabledFeatures,);

  factory Aria2ServerConfig.fromJson(Map<String, dynamic> json) =>
      _$Aria2ServerConfigFromJson(json);

  Map<String?, dynamic> toJson() => _$Aria2ServerConfigToJson(this);
}
