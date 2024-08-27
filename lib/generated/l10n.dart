// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Servers`
  String get appNavigation1 {
    return Intl.message(
      'Servers',
      name: 'appNavigation1',
      desc: '',
      args: [],
    );
  }

  /// `Downloads`
  String get appNavigation2 {
    return Intl.message(
      'Downloads',
      name: 'appNavigation2',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get appNavigation3 {
    return Intl.message(
      'Settings',
      name: 'appNavigation3',
      desc: '',
      args: [],
    );
  }

  /// `Servers`
  String get serverPageTitle {
    return Intl.message(
      'Servers',
      name: 'serverPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `light`
  String get lightTheme {
    return Intl.message(
      'light',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `dark`
  String get darkTheme {
    return Intl.message(
      'dark',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Updating Global Stat Interval`
  String get globalRefreshIntervalLabel {
    return Intl.message(
      'Updating Global Stat Interval',
      name: 'globalRefreshIntervalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Updating Task Information Interval`
  String get taskRefreshIntervalLabel {
    return Intl.message(
      'Updating Task Information Interval',
      name: 'taskRefreshIntervalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enable setting confirm`
  String get enableSettingChangeTipLabel {
    return Intl.message(
      'Enable setting confirm',
      name: 'enableSettingChangeTipLabel',
      desc: '',
      args: [],
    );
  }

  /// `s`
  String get second {
    return Intl.message(
      's',
      name: 'second',
      desc: '',
      args: [],
    );
  }

  /// `bytes`
  String get bytes {
    return Intl.message(
      'bytes',
      name: 'bytes',
      desc: '',
      args: [],
    );
  }

  /// `min`
  String get minute {
    return Intl.message(
      'min',
      name: 'minute',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get confirm {
    return Intl.message(
      'confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `test`
  String get test {
    return Intl.message(
      'test',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get delete {
    return Intl.message(
      'delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `download`
  String get download {
    return Intl.message(
      'download',
      name: 'download',
      desc: '',
      args: [],
    );
  }

  /// `upload`
  String get upload {
    return Intl.message(
      'upload',
      name: 'upload',
      desc: '',
      args: [],
    );
  }

  /// `Aria2 Alias`
  String get aria2_alias {
    return Intl.message(
      'Aria2 Alias',
      name: 'aria2_alias',
      desc: '',
      args: [],
    );
  }

  /// `Aria2 RPC URL`
  String get aria2_rpc_url {
    return Intl.message(
      'Aria2 RPC URL',
      name: 'aria2_rpc_url',
      desc: '',
      args: [],
    );
  }

  /// `Aria2 RPC Port`
  String get aria2_rpc_port {
    return Intl.message(
      'Aria2 RPC Port',
      name: 'aria2_rpc_port',
      desc: '',
      args: [],
    );
  }

  /// `Aria2 RPC Path`
  String get aria2_rpc_path {
    return Intl.message(
      'Aria2 RPC Path',
      name: 'aria2_rpc_path',
      desc: '',
      args: [],
    );
  }

  /// `Aria2 RPC Protocol`
  String get aria2_rpc_protocol {
    return Intl.message(
      'Aria2 RPC Protocol',
      name: 'aria2_rpc_protocol',
      desc: '',
      args: [],
    );
  }

  /// `Aria2 RPC Secret`
  String get aria2_rpc_secret {
    return Intl.message(
      'Aria2 RPC Secret',
      name: 'aria2_rpc_secret',
      desc: '',
      args: [],
    );
  }

  /// `Downloading`
  String get downloading {
    return Intl.message(
      'Downloading',
      name: 'downloading',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completed {
    return Intl.message(
      'Completed',
      name: 'completed',
      desc: '',
      args: [],
    );
  }

  /// `Paused`
  String get paused {
    return Intl.message(
      'Paused',
      name: 'paused',
      desc: '',
      args: [],
    );
  }

  /// `Waiting`
  String get waiting {
    return Intl.message(
      'Waiting',
      name: 'waiting',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Removed`
  String get removed {
    return Intl.message(
      'Removed',
      name: 'removed',
      desc: '',
      args: [],
    );
  }

  /// `Stopped`
  String get stopped {
    return Intl.message(
      'Stopped',
      name: 'stopped',
      desc: '',
      args: [],
    );
  }

  /// `Active`
  String get active {
    return Intl.message(
      'Active',
      name: 'active',
      desc: '',
      args: [],
    );
  }

  /// `Downloading: {count}`
  String downloading_count(Object count) {
    return Intl.message(
      'Downloading: $count',
      name: 'downloading_count',
      desc: '',
      args: [count],
    );
  }

  /// `Completed: {count}`
  String completed_count(Object count) {
    return Intl.message(
      'Completed: $count',
      name: 'completed_count',
      desc: '',
      args: [count],
    );
  }

  /// `Paused: {count}`
  String paused_count(Object count) {
    return Intl.message(
      'Paused: $count',
      name: 'paused_count',
      desc: '',
      args: [count],
    );
  }

  /// `Waiting: {count}`
  String waiting_count(Object count) {
    return Intl.message(
      'Waiting: $count',
      name: 'waiting_count',
      desc: '',
      args: [count],
    );
  }

  /// `Error: {count}`
  String error_count(Object count) {
    return Intl.message(
      'Error: $count',
      name: 'error_count',
      desc: '',
      args: [count],
    );
  }

  /// `Removed: {count}`
  String removed_count(Object count) {
    return Intl.message(
      'Removed: $count',
      name: 'removed_count',
      desc: '',
      args: [count],
    );
  }

  /// `Stopped: {count}`
  String stopped_count(Object count) {
    return Intl.message(
      'Stopped: $count',
      name: 'stopped_count',
      desc: '',
      args: [count],
    );
  }

  /// `Global Limit`
  String get global_limit {
    return Intl.message(
      'Global Limit',
      name: 'global_limit',
      desc: '',
      args: [],
    );
  }

  /// `online`
  String get online {
    return Intl.message(
      'online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `offline`
  String get offline {
    return Intl.message(
      'offline',
      name: 'offline',
      desc: '',
      args: [],
    );
  }

  /// `you should check this server firstly`
  String get check_firstly {
    return Intl.message(
      'you should check this server firstly',
      name: 'check_firstly',
      desc: '',
      args: [],
    );
  }

  /// `connect error`
  String get connect_error {
    return Intl.message(
      'connect error',
      name: 'connect_error',
      desc: '',
      args: [],
    );
  }

  /// `ADVANCED`
  String get advanced {
    return Intl.message(
      'ADVANCED',
      name: 'advanced',
      desc: '',
      args: [],
    );
  }

  /// `BASIC`
  String get basic {
    return Intl.message(
      'BASIC',
      name: 'basic',
      desc: '',
      args: [],
    );
  }

  /// `Download Path`
  String get dir {
    return Intl.message(
      'Download Path',
      name: 'dir',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get dir_tooltip {
    return Intl.message(
      '',
      name: 'dir_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Log File`
  String get log {
    return Intl.message(
      'Log File',
      name: 'log',
      desc: '',
      args: [],
    );
  }

  /// `The file name of the log file. If - is specified, log is written to stdout. If empty string("") is specified, or this option is omitted, no log is written to disk at all.`
  String get log_tooltip {
    return Intl.message(
      'The file name of the log file. If - is specified, log is written to stdout. If empty string("") is specified, or this option is omitted, no log is written to disk at all.',
      name: 'log_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max Concurrent Downloads`
  String get max_concurrent_downloads {
    return Intl.message(
      'Max Concurrent Downloads',
      name: 'max_concurrent_downloads',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get max_concurrent_downloads_tooltip {
    return Intl.message(
      '',
      name: 'max_concurrent_downloads_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Check Integrity`
  String get check_integrity {
    return Intl.message(
      'Check Integrity',
      name: 'check_integrity',
      desc: '',
      args: [],
    );
  }

  /// `Check file integrity by validating piece hashes or a hash of entire file. This option has effect only in BitTorrent, Metalink downloads with checksums or HTTP(S)/FTP downloads with --checksum option.`
  String get check_integrity_tooltip {
    return Intl.message(
      'Check file integrity by validating piece hashes or a hash of entire file. This option has effect only in BitTorrent, Metalink downloads with checksums or HTTP(S)/FTP downloads with --checksum option.',
      name: 'check_integrity_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Resume Download`
  String get continue_download {
    return Intl.message(
      'Resume Download',
      name: 'continue_download',
      desc: '',
      args: [],
    );
  }

  /// `Continue downloading a partially downloaded file. Use this option to resume a download started by a web browser or another program which downloads files sequentially from the beginning. Currently this option is only applicable to HTTP(S)/FTP downloads.`
  String get continue_download_tooltip {
    return Intl.message(
      'Continue downloading a partially downloaded file. Use this option to resume a download started by a web browser or another program which downloads files sequentially from the beginning. Currently this option is only applicable to HTTP(S)/FTP downloads.',
      name: 'continue_download_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Proxy Server`
  String get all_proxy {
    return Intl.message(
      'Proxy Server',
      name: 'all_proxy',
      desc: '',
      args: [],
    );
  }

  /// `Use a proxy server for all protocols. You also can override this setting and specify a proxy server for a particular protocol using --http-proxy, --https-proxy and --ftp-proxy  This affects all downloads. The format of PROXY is [http://][USER:PASSWORD@]HOST[:PORT].`
  String get all_proxy_tooltip {
    return Intl.message(
      'Use a proxy server for all protocols. You also can override this setting and specify a proxy server for a particular protocol using --http-proxy, --https-proxy and --ftp-proxy  This affects all downloads. The format of PROXY is [http://][USER:PASSWORD@]HOST[:PORT].',
      name: 'all_proxy_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Proxy User Name`
  String get all_proxy_user {
    return Intl.message(
      'Proxy User Name',
      name: 'all_proxy_user',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get all_proxy_user_tooltip {
    return Intl.message(
      '',
      name: 'all_proxy_user_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Proxy Password`
  String get all_proxy_passwd {
    return Intl.message(
      'Proxy Password',
      name: 'all_proxy_passwd',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get all_proxy_passwd_tooltip {
    return Intl.message(
      '',
      name: 'all_proxy_passwd_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Checksum`
  String get checksum {
    return Intl.message(
      'Checksum',
      name: 'checksum',
      desc: '',
      args: [],
    );
  }

  /// `Set checksum. The option value format is TYPE\`
  String get checksum_tooltip {
    return Intl.message(
      'Set checksum. The option value format is TYPE\\',
      name: 'checksum_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Connect Timeout`
  String get connect_timeout {
    return Intl.message(
      'Connect Timeout',
      name: 'connect_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Set the connect timeout in seconds to establish connection to HTTP/FTP/proxy server. After the connection is established, this option makes no effect and --timeout option is used instead.`
  String get connect_timeout_tooltip {
    return Intl.message(
      'Set the connect timeout in seconds to establish connection to HTTP/FTP/proxy server. After the connection is established, this option makes no effect and --timeout option is used instead.',
      name: 'connect_timeout_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Dry Run`
  String get dry_run {
    return Intl.message(
      'Dry Run',
      name: 'dry_run',
      desc: '',
      args: [],
    );
  }

  /// `If true is given, aria2 just checks whether the remote file is available and doesn't download data. This option has effect on HTTP/FTP download. BitTorrent downloads are canceled if true is specified.`
  String get dry_run_tooltip {
    return Intl.message(
      'If true is given, aria2 just checks whether the remote file is available and doesn\'t download data. This option has effect on HTTP/FTP download. BitTorrent downloads are canceled if true is specified.',
      name: 'dry_run_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Lowest Speed Limit`
  String get lowest_speed_limit {
    return Intl.message(
      'Lowest Speed Limit',
      name: 'lowest_speed_limit',
      desc: '',
      args: [],
    );
  }

  /// `Close connection if download speed is lower than or equal to this value(bytes per sec). 0 means aria2 does not have a lowest speed limit. You can append K or M (1K `
  String get lowest_speed_limit_tooltip {
    return Intl.message(
      'Close connection if download speed is lower than or equal to this value(bytes per sec). 0 means aria2 does not have a lowest speed limit. You can append K or M (1K ',
      name: 'lowest_speed_limit_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max Connection Per Server`
  String get max_connection_per_server {
    return Intl.message(
      'Max Connection Per Server',
      name: 'max_connection_per_server',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get max_connection_per_server_tooltip {
    return Intl.message(
      '',
      name: 'max_connection_per_server_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max File Not Found Try Times`
  String get max_file_not_found {
    return Intl.message(
      'Max File Not Found Try Times',
      name: 'max_file_not_found',
      desc: '',
      args: [],
    );
  }

  /// `If aria2 receives "file not found" status from the remote HTTP/FTP servers NUM times without getting a single byte, then force the download to fail. Specify 0 to disable this option. This options is effective only when using HTTP/FTP servers. The number of retry attempt is counted toward --max-tries, so it should be configured too.`
  String get max_file_not_found_tooltip {
    return Intl.message(
      'If aria2 receives "file not found" status from the remote HTTP/FTP servers NUM times without getting a single byte, then force the download to fail. Specify 0 to disable this option. This options is effective only when using HTTP/FTP servers. The number of retry attempt is counted toward --max-tries, so it should be configured too.',
      name: 'max_file_not_found_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max Try Times`
  String get max_tries {
    return Intl.message(
      'Max Try Times',
      name: 'max_tries',
      desc: '',
      args: [],
    );
  }

  /// `Set number of tries. 0 means unlimited.`
  String get max_tries_tooltip {
    return Intl.message(
      'Set number of tries. 0 means unlimited.',
      name: 'max_tries_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Min Split Size`
  String get min_split_size {
    return Intl.message(
      'Min Split Size',
      name: 'min_split_size',
      desc: '',
      args: [],
    );
  }

  /// `aria2 does not split less than 2*SIZE byte range. For example, let's consider downloading 20MiB file. If SIZE is 10M, aria2 can split file into 2 range [0-10MiB) and [10MiB-20MiB) and download it using 2 sources(if --split >`
  String get min_split_size_tooltip {
    return Intl.message(
      'aria2 does not split less than 2*SIZE byte range. For example, let\'s consider downloading 20MiB file. If SIZE is 10M, aria2 can split file into 2 range [0-10MiB) and [10MiB-20MiB) and download it using 2 sources(if --split >',
      name: 'min_split_size_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `.netrc Path`
  String get netrc_path {
    return Intl.message(
      '.netrc Path',
      name: 'netrc_path',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get netrc_path_tooltip {
    return Intl.message(
      '',
      name: 'netrc_path_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Disable netrc`
  String get no_netrc {
    return Intl.message(
      'Disable netrc',
      name: 'no_netrc',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get no_netrc_tooltip {
    return Intl.message(
      '',
      name: 'no_netrc_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `No Proxy List`
  String get no_proxy {
    return Intl.message(
      'No Proxy List',
      name: 'no_proxy',
      desc: '',
      args: [],
    );
  }

  /// `Specify a comma separated list of host names, domains and network addresses with or without a subnet mask where no proxy should be used.`
  String get no_proxy_tooltip {
    return Intl.message(
      'Specify a comma separated list of host names, domains and network addresses with or without a subnet mask where no proxy should be used.',
      name: 'no_proxy_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `File Name`
  String get out {
    return Intl.message(
      'File Name',
      name: 'out',
      desc: '',
      args: [],
    );
  }

  /// `The file name of the downloaded file. It is always relative to the directory given in --dir option. When the --force-sequential option is used, this option is ignored.`
  String get out_tooltip {
    return Intl.message(
      'The file name of the downloaded file. It is always relative to the directory given in --dir option. When the --force-sequential option is used, this option is ignored.',
      name: 'out_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Proxy Method`
  String get proxy_method {
    return Intl.message(
      'Proxy Method',
      name: 'proxy_method',
      desc: '',
      args: [],
    );
  }

  /// `Set the method to use in proxy request. METHOD is either GET or TUNNEL. HTTPS downloads always use TUNNEL regardless of this option.`
  String get proxy_method_tooltip {
    return Intl.message(
      'Set the method to use in proxy request. METHOD is either GET or TUNNEL. HTTPS downloads always use TUNNEL regardless of this option.',
      name: 'proxy_method_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Remote File Timestamp`
  String get remote_time {
    return Intl.message(
      'Remote File Timestamp',
      name: 'remote_time',
      desc: '',
      args: [],
    );
  }

  /// `Retrieve timestamp of the remote file from the remote HTTP/FTP server and if it is available, apply it to the local file.`
  String get remote_time_tooltip {
    return Intl.message(
      'Retrieve timestamp of the remote file from the remote HTTP/FTP server and if it is available, apply it to the local file.',
      name: 'remote_time_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Reuse Uri`
  String get reuse_uri {
    return Intl.message(
      'Reuse Uri',
      name: 'reuse_uri',
      desc: '',
      args: [],
    );
  }

  /// `Reuse already used URIs if no unused URIs are left.`
  String get reuse_uri_tooltip {
    return Intl.message(
      'Reuse already used URIs if no unused URIs are left.',
      name: 'reuse_uri_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Retry Wait`
  String get retry_wait {
    return Intl.message(
      'Retry Wait',
      name: 'retry_wait',
      desc: '',
      args: [],
    );
  }

  /// `Set the seconds to wait between retries. When SEC > 0, aria2 will retry downloads when the HTTP server returns a 503 response.`
  String get retry_wait_tooltip {
    return Intl.message(
      'Set the seconds to wait between retries. When SEC > 0, aria2 will retry downloads when the HTTP server returns a 503 response.',
      name: 'retry_wait_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Server Stat Output`
  String get server_stat_of {
    return Intl.message(
      'Server Stat Output',
      name: 'server_stat_of',
      desc: '',
      args: [],
    );
  }

  /// `Specify the file name to which performance profile of the servers is saved. You can load saved data using --server-stat-if option.`
  String get server_stat_of_tooltip {
    return Intl.message(
      'Specify the file name to which performance profile of the servers is saved. You can load saved data using --server-stat-if option.',
      name: 'server_stat_of_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Server Stat Timeout`
  String get server_stat_timeout {
    return Intl.message(
      'Server Stat Timeout',
      name: 'server_stat_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Specifies timeout in seconds to invalidate performance profile of the servers since the last contact to them.`
  String get server_stat_timeout_tooltip {
    return Intl.message(
      'Specifies timeout in seconds to invalidate performance profile of the servers since the last contact to them.',
      name: 'server_stat_timeout_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Split Count`
  String get split {
    return Intl.message(
      'Split Count',
      name: 'split',
      desc: '',
      args: [],
    );
  }

  /// `Download a file using N connections. If more than N URIs are given, first N URIs are used and remaining URIs are used for backup. If less than N URIs are given, those URIs are used more than once so that N connections total are made simultaneously. The number of connections to the same host is restricted by the --max-connection-per-server option.`
  String get split_tooltip {
    return Intl.message(
      'Download a file using N connections. If more than N URIs are given, first N URIs are used and remaining URIs are used for backup. If less than N URIs are given, those URIs are used more than once so that N connections total are made simultaneously. The number of connections to the same host is restricted by the --max-connection-per-server option.',
      name: 'split_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Piece Selection Algorithm`
  String get stream_piece_selector {
    return Intl.message(
      'Piece Selection Algorithm',
      name: 'stream_piece_selector',
      desc: '',
      args: [],
    );
  }

  /// `Specify piece selection algorithm used in HTTP/FTP download. Piece means fixed length segment which is downloaded in parallel in segmented download. If default is given, aria2 selects piece so that it reduces the number of establishing connection. This is reasonable default behavior because establishing connection is an expensive operation. If inorder is given, aria2 selects piece which has minimum index. Index`
  String get stream_piece_selector_tooltip {
    return Intl.message(
      'Specify piece selection algorithm used in HTTP/FTP download. Piece means fixed length segment which is downloaded in parallel in segmented download. If default is given, aria2 selects piece so that it reduces the number of establishing connection. This is reasonable default behavior because establishing connection is an expensive operation. If inorder is given, aria2 selects piece which has minimum index. Index',
      name: 'stream_piece_selector_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Timeout`
  String get timeout {
    return Intl.message(
      'Timeout',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get timeout_tooltip {
    return Intl.message(
      '',
      name: 'timeout_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `URI Selection Algorithm`
  String get uri_selector {
    return Intl.message(
      'URI Selection Algorithm',
      name: 'uri_selector',
      desc: '',
      args: [],
    );
  }

  /// `Specify URI selection algorithm. The possible values are inorder, feedback and adaptive. If inorder is given, URI is tried in the order appeared in the URI list. If feedback is given, aria2 uses download speed observed in the previous downloads and choose fastest server in the URI list. This also effectively skips dead mirrors. The observed download speed is a part of performance profile of servers mentioned in --server-stat-of and --server-stat-if  If adaptive is given, selects one of the best mirrors for the first and reserved connections. For supplementary ones, it returns mirrors which has not been tested yet, and if each of them has already been tested, returns mirrors which has to be tested again. Otherwise, it doesn't select anymore mirrors. Like feedback, it uses a performance profile of servers.`
  String get uri_selector_tooltip {
    return Intl.message(
      'Specify URI selection algorithm. The possible values are inorder, feedback and adaptive. If inorder is given, URI is tried in the order appeared in the URI list. If feedback is given, aria2 uses download speed observed in the previous downloads and choose fastest server in the URI list. This also effectively skips dead mirrors. The observed download speed is a part of performance profile of servers mentioned in --server-stat-of and --server-stat-if  If adaptive is given, selects one of the best mirrors for the first and reserved connections. For supplementary ones, it returns mirrors which has not been tested yet, and if each of them has already been tested, returns mirrors which has to be tested again. Otherwise, it doesn\'t select anymore mirrors. Like feedback, it uses a performance profile of servers.',
      name: 'uri_selector_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Check Certificate`
  String get check_certificate {
    return Intl.message(
      'Check Certificate',
      name: 'check_certificate',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get check_certificate_tooltip {
    return Intl.message(
      '',
      name: 'check_certificate_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Accept GZip`
  String get http_accept_gzip {
    return Intl.message(
      'Accept GZip',
      name: 'http_accept_gzip',
      desc: '',
      args: [],
    );
  }

  /// `Send Accept: deflate, gzip request header and inflate response if remote server responds with Content-Encoding: gzip or Content-Encoding: deflate.`
  String get http_accept_gzip_tooltip {
    return Intl.message(
      'Send Accept: deflate, gzip request header and inflate response if remote server responds with Content-Encoding: gzip or Content-Encoding: deflate.',
      name: 'http_accept_gzip_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Auth Challenge`
  String get http_auth_challenge {
    return Intl.message(
      'Auth Challenge',
      name: 'http_auth_challenge',
      desc: '',
      args: [],
    );
  }

  /// `Send HTTP authorization header only when it is requested by the server. If false is set, then authorization header is always sent to the server. There is an exception: if user name and password are embedded in URI, authorization header is always sent to the server regardless of this option.`
  String get http_auth_challenge_tooltip {
    return Intl.message(
      'Send HTTP authorization header only when it is requested by the server. If false is set, then authorization header is always sent to the server. There is an exception: if user name and password are embedded in URI, authorization header is always sent to the server regardless of this option.',
      name: 'http_auth_challenge_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `No Cache`
  String get http_no_cache {
    return Intl.message(
      'No Cache',
      name: 'http_no_cache',
      desc: '',
      args: [],
    );
  }

  /// `Send Cache-Control: no-cache and Pragma: no-cache header to avoid cached content. If false is given, these headers are not sent and you can add Cache-Control header with a directive you like using --header option.`
  String get http_no_cache_tooltip {
    return Intl.message(
      'Send Cache-Control: no-cache and Pragma: no-cache header to avoid cached content. If false is given, these headers are not sent and you can add Cache-Control header with a directive you like using --header option.',
      name: 'http_no_cache_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `HTTP Default User Name`
  String get http_user {
    return Intl.message(
      'HTTP Default User Name',
      name: 'http_user',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get http_user_tooltip {
    return Intl.message(
      '',
      name: 'http_user_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `HTTP Default Password`
  String get http_passwd {
    return Intl.message(
      'HTTP Default Password',
      name: 'http_passwd',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get http_passwd_tooltip {
    return Intl.message(
      '',
      name: 'http_passwd_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `HTTP Proxy Server`
  String get http_proxy {
    return Intl.message(
      'HTTP Proxy Server',
      name: 'http_proxy',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get http_proxy_tooltip {
    return Intl.message(
      '',
      name: 'http_proxy_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `HTTP Proxy User Name`
  String get http_proxy_user {
    return Intl.message(
      'HTTP Proxy User Name',
      name: 'http_proxy_user',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get http_proxy_user_tooltip {
    return Intl.message(
      '',
      name: 'http_proxy_user_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `HTTP Proxy Password`
  String get http_proxy_passwd {
    return Intl.message(
      'HTTP Proxy Password',
      name: 'http_proxy_passwd',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get http_proxy_passwd_tooltip {
    return Intl.message(
      '',
      name: 'http_proxy_passwd_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `HTTPS Proxy Server`
  String get https_proxy {
    return Intl.message(
      'HTTPS Proxy Server',
      name: 'https_proxy',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get https_proxy_tooltip {
    return Intl.message(
      '',
      name: 'https_proxy_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `HTTPS Proxy User Name`
  String get https_proxy_user {
    return Intl.message(
      'HTTPS Proxy User Name',
      name: 'https_proxy_user',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get https_proxy_user_tooltip {
    return Intl.message(
      '',
      name: 'https_proxy_user_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `HTTPS Proxy Password`
  String get https_proxy_passwd {
    return Intl.message(
      'HTTPS Proxy Password',
      name: 'https_proxy_passwd',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get https_proxy_passwd_tooltip {
    return Intl.message(
      '',
      name: 'https_proxy_passwd_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Referer`
  String get referer {
    return Intl.message(
      'Referer',
      name: 'referer',
      desc: '',
      args: [],
    );
  }

  /// `Set an http referrer (Referer). This affects all http/https downloads. If * is given, the download URI is also used as the referrer. This may be useful when used together with the --parameterized-uri option.`
  String get referer_tooltip {
    return Intl.message(
      'Set an http referrer (Referer). This affects all http/https downloads. If * is given, the download URI is also used as the referrer. This may be useful when used together with the --parameterized-uri option.',
      name: 'referer_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable Persistent Connection`
  String get enable_http_keep_alive {
    return Intl.message(
      'Enable Persistent Connection',
      name: 'enable_http_keep_alive',
      desc: '',
      args: [],
    );
  }

  /// `Enable HTTP/1.1 persistent connection.`
  String get enable_http_keep_alive_tooltip {
    return Intl.message(
      'Enable HTTP/1.1 persistent connection.',
      name: 'enable_http_keep_alive_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable HTTP Pipelining`
  String get enable_http_pipelining {
    return Intl.message(
      'Enable HTTP Pipelining',
      name: 'enable_http_pipelining',
      desc: '',
      args: [],
    );
  }

  /// `Enable HTTP/1.1 pipelining.`
  String get enable_http_pipelining_tooltip {
    return Intl.message(
      'Enable HTTP/1.1 pipelining.',
      name: 'enable_http_pipelining_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Custom Header`
  String get header {
    return Intl.message(
      'Custom Header',
      name: 'header',
      desc: '',
      args: [],
    );
  }

  /// `Append HEADER to HTTP request header. Put one item per line, each item containing "header name: header value".`
  String get header_tooltip {
    return Intl.message(
      'Append HEADER to HTTP request header. Put one item per line, each item containing "header name: header value".',
      name: 'header_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Cookies Path`
  String get save_cookies {
    return Intl.message(
      'Cookies Path',
      name: 'save_cookies',
      desc: '',
      args: [],
    );
  }

  /// `Save Cookies to FILE in Mozilla/Firefox(1.x/2.x)/ Netscape format. If FILE already exists, it is overwritten. Session Cookies are also saved and their expiry values are treated as 0.`
  String get save_cookies_tooltip {
    return Intl.message(
      'Save Cookies to FILE in Mozilla/Firefox(1.x/2.x)/ Netscape format. If FILE already exists, it is overwritten. Session Cookies are also saved and their expiry values are treated as 0.',
      name: 'save_cookies_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Use HEAD Method`
  String get use_head {
    return Intl.message(
      'Use HEAD Method',
      name: 'use_head',
      desc: '',
      args: [],
    );
  }

  /// `Use HEAD method for the first request to the HTTP server.`
  String get use_head_tooltip {
    return Intl.message(
      'Use HEAD method for the first request to the HTTP server.',
      name: 'use_head_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Custom User Agent`
  String get user_agent {
    return Intl.message(
      'Custom User Agent',
      name: 'user_agent',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get user_agent_tooltip {
    return Intl.message(
      '',
      name: 'user_agent_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `FTP Default User Name`
  String get ftp_user {
    return Intl.message(
      'FTP Default User Name',
      name: 'ftp_user',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get ftp_user_tooltip {
    return Intl.message(
      '',
      name: 'ftp_user_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `FTP Default Password`
  String get ftp_passwd {
    return Intl.message(
      'FTP Default Password',
      name: 'ftp_passwd',
      desc: '',
      args: [],
    );
  }

  /// `If user name is embedded but password is missing in URI, aria2 tries to resolve password using .netrc. If password is found in .netrc, then use it as password. If not, use the password specified in this option.`
  String get ftp_passwd_tooltip {
    return Intl.message(
      'If user name is embedded but password is missing in URI, aria2 tries to resolve password using .netrc. If password is found in .netrc, then use it as password. If not, use the password specified in this option.',
      name: 'ftp_passwd_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Passive Mode`
  String get ftp_pasv {
    return Intl.message(
      'Passive Mode',
      name: 'ftp_pasv',
      desc: '',
      args: [],
    );
  }

  /// `Use the passive mode in FTP. If false is given, the active mode will be used. This option is ignored for SFTP transfer.`
  String get ftp_pasv_tooltip {
    return Intl.message(
      'Use the passive mode in FTP. If false is given, the active mode will be used. This option is ignored for SFTP transfer.',
      name: 'ftp_pasv_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `FTP Proxy Server`
  String get ftp_proxy {
    return Intl.message(
      'FTP Proxy Server',
      name: 'ftp_proxy',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get ftp_proxy_tooltip {
    return Intl.message(
      '',
      name: 'ftp_proxy_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `FTP Proxy User Name`
  String get ftp_proxy_user {
    return Intl.message(
      'FTP Proxy User Name',
      name: 'ftp_proxy_user',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get ftp_proxy_user_tooltip {
    return Intl.message(
      '',
      name: 'ftp_proxy_user_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `FTP Proxy Password`
  String get ftp_proxy_passwd {
    return Intl.message(
      'FTP Proxy Password',
      name: 'ftp_proxy_passwd',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get ftp_proxy_passwd_tooltip {
    return Intl.message(
      '',
      name: 'ftp_proxy_passwd_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Transfer Type`
  String get ftp_type {
    return Intl.message(
      'Transfer Type',
      name: 'ftp_type',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get ftp_type_tooltip {
    return Intl.message(
      '',
      name: 'ftp_type_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Reuse Connection`
  String get ftp_reuse_connection {
    return Intl.message(
      'Reuse Connection',
      name: 'ftp_reuse_connection',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get ftp_reuse_connection_tooltip {
    return Intl.message(
      '',
      name: 'ftp_reuse_connection_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `SSH Public Key Checksum`
  String get ssh_host_key_md {
    return Intl.message(
      'SSH Public Key Checksum',
      name: 'ssh_host_key_md',
      desc: '',
      args: [],
    );
  }

  /// `Set checksum for SSH host public key. The option value format is TYPE`
  String get ssh_host_key_md_tooltip {
    return Intl.message(
      'Set checksum for SSH host public key. The option value format is TYPE',
      name: 'ssh_host_key_md_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Detach Seed Only`
  String get bt_detach_seed_only {
    return Intl.message(
      'Detach Seed Only',
      name: 'bt_detach_seed_only',
      desc: '',
      args: [],
    );
  }

  /// `Exclude seed only downloads when counting concurrent active downloads (See -j option). This means that if -j3 is given and this option is turned on and 3 downloads are active and one of those enters seed mode, then it is excluded from active download count (thus it becomes 2), and the next download waiting in queue gets started. But be aware that seeding item is still recognized as active download in RPC method.`
  String get bt_detach_seed_only_tooltip {
    return Intl.message(
      'Exclude seed only downloads when counting concurrent active downloads (See -j option). This means that if -j3 is given and this option is turned on and 3 downloads are active and one of those enters seed mode, then it is excluded from active download count (thus it becomes 2), and the next download waiting in queue gets started. But be aware that seeding item is still recognized as active download in RPC method.',
      name: 'bt_detach_seed_only_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable Hook After Hash Check`
  String get bt_enable_hook_after_hash_check {
    return Intl.message(
      'Enable Hook After Hash Check',
      name: 'bt_enable_hook_after_hash_check',
      desc: '',
      args: [],
    );
  }

  /// `Allow hook command invocation after hash check (see -V option) in BitTorrent download. By default, when hash check succeeds, the command given by --on-bt-download-complete is executed. To disable this action, give false to this option.`
  String get bt_enable_hook_after_hash_check_tooltip {
    return Intl.message(
      'Allow hook command invocation after hash check (see -V option) in BitTorrent download. By default, when hash check succeeds, the command given by --on-bt-download-complete is executed. To disable this action, give false to this option.',
      name: 'bt_enable_hook_after_hash_check_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable Local Peer Discovery (LPD)`
  String get bt_enable_lpd {
    return Intl.message(
      'Enable Local Peer Discovery (LPD)',
      name: 'bt_enable_lpd',
      desc: '',
      args: [],
    );
  }

  /// `Enable Local Peer Discovery. If a private flag is set in a torrent, aria2 doesn't use this feature for that download even if true is given.`
  String get bt_enable_lpd_tooltip {
    return Intl.message(
      'Enable Local Peer Discovery. If a private flag is set in a torrent, aria2 doesn\'t use this feature for that download even if true is given.',
      name: 'bt_enable_lpd_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `BitTorrent Exclude Trackers`
  String get bt_exclude_tracker {
    return Intl.message(
      'BitTorrent Exclude Trackers',
      name: 'bt_exclude_tracker',
      desc: '',
      args: [],
    );
  }

  /// `Comma separated list of BitTorrent tracker's announce URI to remove. You can use special value * which matches all URIs, thus removes all announce URIs. When specifying * in shell command-line, don't forget to escape or quote it.`
  String get bt_exclude_tracker_tooltip {
    return Intl.message(
      'Comma separated list of BitTorrent tracker\'s announce URI to remove. You can use special value * which matches all URIs, thus removes all announce URIs. When specifying * in shell command-line, don\'t forget to escape or quote it.',
      name: 'bt_exclude_tracker_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `External IP`
  String get bt_external_ip {
    return Intl.message(
      'External IP',
      name: 'bt_external_ip',
      desc: '',
      args: [],
    );
  }

  /// `Specify the external IP address to use in BitTorrent download and DHT. It may be sent to BitTorrent tracker. For DHT, this option should be set to report that local node is downloading a particular torrent. This is critical to use DHT in a private network. Although this function is named external, it can accept any kind of IP addresses.`
  String get bt_external_ip_tooltip {
    return Intl.message(
      'Specify the external IP address to use in BitTorrent download and DHT. It may be sent to BitTorrent tracker. For DHT, this option should be set to report that local node is downloading a particular torrent. This is critical to use DHT in a private network. Although this function is named external, it can accept any kind of IP addresses.',
      name: 'bt_external_ip_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Force Encryption`
  String get bt_force_encryption {
    return Intl.message(
      'Force Encryption',
      name: 'bt_force_encryption',
      desc: '',
      args: [],
    );
  }

  /// `Requires BitTorrent message payload encryption with arc4. This is a shorthand of --bt-require-crypto --bt-min-crypto-level`
  String get bt_force_encryption_tooltip {
    return Intl.message(
      'Requires BitTorrent message payload encryption with arc4. This is a shorthand of --bt-require-crypto --bt-min-crypto-level',
      name: 'bt_force_encryption_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Hash Check Before Seeding`
  String get bt_hash_check_seed {
    return Intl.message(
      'Hash Check Before Seeding',
      name: 'bt_hash_check_seed',
      desc: '',
      args: [],
    );
  }

  /// `If true is given, after hash check using --check-integrity option and file is complete, continue to seed file. If you want to check file and download it only when it is damaged or incomplete, set this option to false. This option has effect only on BitTorrent download.`
  String get bt_hash_check_seed_tooltip {
    return Intl.message(
      'If true is given, after hash check using --check-integrity option and file is complete, continue to seed file. If you want to check file and download it only when it is damaged or incomplete, set this option to false. This option has effect only on BitTorrent download.',
      name: 'bt_hash_check_seed_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Load Saved Metadata File`
  String get bt_load_saved_metadata {
    return Intl.message(
      'Load Saved Metadata File',
      name: 'bt_load_saved_metadata',
      desc: '',
      args: [],
    );
  }

  /// `Before getting torrent metadata from DHT when downloading with magnet link, first try to read file saved by --bt-save-metadata option. If it is successful, then skip downloading metadata from DHT.`
  String get bt_load_saved_metadata_tooltip {
    return Intl.message(
      'Before getting torrent metadata from DHT when downloading with magnet link, first try to read file saved by --bt-save-metadata option. If it is successful, then skip downloading metadata from DHT.',
      name: 'bt_load_saved_metadata_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max Open Files`
  String get bt_max_open_files {
    return Intl.message(
      'Max Open Files',
      name: 'bt_max_open_files',
      desc: '',
      args: [],
    );
  }

  /// `Specify maximum number of files to open in multi-file BitTorrent/Metalink download globally.`
  String get bt_max_open_files_tooltip {
    return Intl.message(
      'Specify maximum number of files to open in multi-file BitTorrent/Metalink download globally.',
      name: 'bt_max_open_files_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max Peers`
  String get bt_max_peers {
    return Intl.message(
      'Max Peers',
      name: 'bt_max_peers',
      desc: '',
      args: [],
    );
  }

  /// `Specify the maximum number of peers per torrent. 0 means unlimited.`
  String get bt_max_peers_tooltip {
    return Intl.message(
      'Specify the maximum number of peers per torrent. 0 means unlimited.',
      name: 'bt_max_peers_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Download Metadata Only`
  String get bt_metadata_only {
    return Intl.message(
      'Download Metadata Only',
      name: 'bt_metadata_only',
      desc: '',
      args: [],
    );
  }

  /// `Download meta data only. The file(s) described in meta data will not be downloaded. This option has effect only when BitTorrent Magnet URI is used.`
  String get bt_metadata_only_tooltip {
    return Intl.message(
      'Download meta data only. The file(s) described in meta data will not be downloaded. This option has effect only when BitTorrent Magnet URI is used.',
      name: 'bt_metadata_only_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Min Crypto Level`
  String get bt_min_crypto_level {
    return Intl.message(
      'Min Crypto Level',
      name: 'bt_min_crypto_level',
      desc: '',
      args: [],
    );
  }

  /// `Set minimum level of encryption method. If several encryption methods are provided by a peer, aria2 chooses the lowest one which satisfies the given level.`
  String get bt_min_crypto_level_tooltip {
    return Intl.message(
      'Set minimum level of encryption method. If several encryption methods are provided by a peer, aria2 chooses the lowest one which satisfies the given level.',
      name: 'bt_min_crypto_level_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Prioritize Piece`
  String get bt_prioritize_piece {
    return Intl.message(
      'Prioritize Piece',
      name: 'bt_prioritize_piece',
      desc: '',
      args: [],
    );
  }

  /// `Try to download first and last pieces of each file first. This is useful for previewing files. The argument can contain 2 keywords: head and tail. To include both keywords, they must be separated by comma. These keywords can take one parameter, SIZE. For example, if head`
  String get bt_prioritize_piece_tooltip {
    return Intl.message(
      'Try to download first and last pieces of each file first. This is useful for previewing files. The argument can contain 2 keywords: head and tail. To include both keywords, they must be separated by comma. These keywords can take one parameter, SIZE. For example, if head',
      name: 'bt_prioritize_piece_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Remove Unselected File`
  String get bt_remove_unselected_file {
    return Intl.message(
      'Remove Unselected File',
      name: 'bt_remove_unselected_file',
      desc: '',
      args: [],
    );
  }

  /// `Removes the unselected files when download is completed in BitTorrent. To select files, use --select-file option. If it is not used, all files are assumed to be selected. Please use this option with care because it will actually remove files from your disk.`
  String get bt_remove_unselected_file_tooltip {
    return Intl.message(
      'Removes the unselected files when download is completed in BitTorrent. To select files, use --select-file option. If it is not used, all files are assumed to be selected. Please use this option with care because it will actually remove files from your disk.',
      name: 'bt_remove_unselected_file_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Require Crypto`
  String get bt_require_crypto {
    return Intl.message(
      'Require Crypto',
      name: 'bt_require_crypto',
      desc: '',
      args: [],
    );
  }

  /// `If true is given, aria2 doesn't accept and establish connection with legacy BitTorrent handshake(\19BitTorrent protocol). Thus aria2 always uses Obfuscation handshake.`
  String get bt_require_crypto_tooltip {
    return Intl.message(
      'If true is given, aria2 doesn\'t accept and establish connection with legacy BitTorrent handshake(\\19BitTorrent protocol). Thus aria2 always uses Obfuscation handshake.',
      name: 'bt_require_crypto_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Download Speed`
  String get bt_request_peer_speed_limit {
    return Intl.message(
      'Preferred Download Speed',
      name: 'bt_request_peer_speed_limit',
      desc: '',
      args: [],
    );
  }

  /// `If the whole download speed of every torrent is lower than SPEED, aria2 temporarily increases the number of peers to try for more download speed. Configuring this option with your preferred download speed can increase your download speed in some cases. You can append K or M (1K `
  String get bt_request_peer_speed_limit_tooltip {
    return Intl.message(
      'If the whole download speed of every torrent is lower than SPEED, aria2 temporarily increases the number of peers to try for more download speed. Configuring this option with your preferred download speed can increase your download speed in some cases. You can append K or M (1K ',
      name: 'bt_request_peer_speed_limit_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Save Metadata`
  String get bt_save_metadata {
    return Intl.message(
      'Save Metadata',
      name: 'bt_save_metadata',
      desc: '',
      args: [],
    );
  }

  /// `Save meta data as ".torrent" file. This option has effect only when BitTorrent Magnet URI is used. The file name is hex encoded info hash with suffix ".torrent". The directory to be saved is the same directory where download file is saved. If the same file already exists, meta data is not saved.`
  String get bt_save_metadata_tooltip {
    return Intl.message(
      'Save meta data as ".torrent" file. This option has effect only when BitTorrent Magnet URI is used. The file name is hex encoded info hash with suffix ".torrent". The directory to be saved is the same directory where download file is saved. If the same file already exists, meta data is not saved.',
      name: 'bt_save_metadata_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Not Verify Downloaded Fileds`
  String get bt_seed_unverified {
    return Intl.message(
      'Not Verify Downloaded Fileds',
      name: 'bt_seed_unverified',
      desc: '',
      args: [],
    );
  }

  /// `Seed previously downloaded files without verifying piece hashes.`
  String get bt_seed_unverified_tooltip {
    return Intl.message(
      'Seed previously downloaded files without verifying piece hashes.',
      name: 'bt_seed_unverified_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Stop Timeout`
  String get bt_stop_timeout {
    return Intl.message(
      'Stop Timeout',
      name: 'bt_stop_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Stop BitTorrent download if download speed is 0 in consecutive SEC seconds. If 0 is given, this feature is disabled.`
  String get bt_stop_timeout_tooltip {
    return Intl.message(
      'Stop BitTorrent download if download speed is 0 in consecutive SEC seconds. If 0 is given, this feature is disabled.',
      name: 'bt_stop_timeout_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `BitTorrent Trackers`
  String get bt_tracker {
    return Intl.message(
      'BitTorrent Trackers',
      name: 'bt_tracker',
      desc: '',
      args: [],
    );
  }

  /// `Comma separated list of additional BitTorrent tracker's announce URI. These URIs are not affected by --bt-exclude-tracker option because they are added after URIs in --bt-exclude-tracker option are removed.`
  String get bt_tracker_tooltip {
    return Intl.message(
      'Comma separated list of additional BitTorrent tracker\'s announce URI. These URIs are not affected by --bt-exclude-tracker option because they are added after URIs in --bt-exclude-tracker option are removed.',
      name: 'bt_tracker_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `BitTorrent Tracker Connect Timeout`
  String get bt_tracker_connect_timeout {
    return Intl.message(
      'BitTorrent Tracker Connect Timeout',
      name: 'bt_tracker_connect_timeout',
      desc: '',
      args: [],
    );
  }

  /// `Set the connect timeout in seconds to establish connection to tracker. After the connection is established, this option makes no effect and --bt-tracker-timeout option is used instead.`
  String get bt_tracker_connect_timeout_tooltip {
    return Intl.message(
      'Set the connect timeout in seconds to establish connection to tracker. After the connection is established, this option makes no effect and --bt-tracker-timeout option is used instead.',
      name: 'bt_tracker_connect_timeout_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `BitTorrent Tracker Connect Interval`
  String get bt_tracker_interval {
    return Intl.message(
      'BitTorrent Tracker Connect Interval',
      name: 'bt_tracker_interval',
      desc: '',
      args: [],
    );
  }

  /// `Set the interval in seconds between tracker requests. This completely overrides interval value and aria2 just uses this value and ignores the min interval and interval value in the response of tracker. If 0 is set, aria2 determines interval based on the response of tracker and the download progress.`
  String get bt_tracker_interval_tooltip {
    return Intl.message(
      'Set the interval in seconds between tracker requests. This completely overrides interval value and aria2 just uses this value and ignores the min interval and interval value in the response of tracker. If 0 is set, aria2 determines interval based on the response of tracker and the download progress.',
      name: 'bt_tracker_interval_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `BitTorrent Tracker Timeout`
  String get bt_tracker_timeout {
    return Intl.message(
      'BitTorrent Tracker Timeout',
      name: 'bt_tracker_timeout',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get bt_tracker_timeout_tooltip {
    return Intl.message(
      '',
      name: 'bt_tracker_timeout_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `DHT (IPv4) File`
  String get dht_file_path {
    return Intl.message(
      'DHT (IPv4) File',
      name: 'dht_file_path',
      desc: '',
      args: [],
    );
  }

  /// `Change the IPv4 DHT routing table file to PATH.`
  String get dht_file_path_tooltip {
    return Intl.message(
      'Change the IPv4 DHT routing table file to PATH.',
      name: 'dht_file_path_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `DHT (IPv6) File`
  String get dht_file_path6 {
    return Intl.message(
      'DHT (IPv6) File',
      name: 'dht_file_path6',
      desc: '',
      args: [],
    );
  }

  /// `Change the IPv6 DHT routing table file to PATH.`
  String get dht_file_path6_tooltip {
    return Intl.message(
      'Change the IPv6 DHT routing table file to PATH.',
      name: 'dht_file_path6_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `DHT Listen Port`
  String get dht_listen_port {
    return Intl.message(
      'DHT Listen Port',
      name: 'dht_listen_port',
      desc: '',
      args: [],
    );
  }

  /// `Set UDP listening port used by DHT(IPv4, IPv6) and UDP tracker. Multiple ports can be specified by using "," for example: 6881,6885. You can also use - to specify a range: 6881-6999. , and - can be used together.`
  String get dht_listen_port_tooltip {
    return Intl.message(
      'Set UDP listening port used by DHT(IPv4, IPv6) and UDP tracker. Multiple ports can be specified by using "," for example: 6881,6885. You can also use - to specify a range: 6881-6999. , and - can be used together.',
      name: 'dht_listen_port_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `DHT Message Timeout`
  String get dht_message_timeout {
    return Intl.message(
      'DHT Message Timeout',
      name: 'dht_message_timeout',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get dht_message_timeout_tooltip {
    return Intl.message(
      '',
      name: 'dht_message_timeout_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable DHT (IPv4)`
  String get enable_dht {
    return Intl.message(
      'Enable DHT (IPv4)',
      name: 'enable_dht',
      desc: '',
      args: [],
    );
  }

  /// `Enable IPv4 DHT functionality. It also enables UDP tracker support. If a private flag is set in a torrent, aria2 doesn't use DHT for that download even if true is given.`
  String get enable_dht_tooltip {
    return Intl.message(
      'Enable IPv4 DHT functionality. It also enables UDP tracker support. If a private flag is set in a torrent, aria2 doesn\'t use DHT for that download even if true is given.',
      name: 'enable_dht_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable DHT (IPv6)`
  String get enable_dht6 {
    return Intl.message(
      'Enable DHT (IPv6)',
      name: 'enable_dht6',
      desc: '',
      args: [],
    );
  }

  /// `Enable IPv6 DHT functionality. If a private flag is set in a torrent, aria2 doesn't use DHT for that download even if true is given. Use --dht-listen-port option to specify port number to listen on.`
  String get enable_dht6_tooltip {
    return Intl.message(
      'Enable IPv6 DHT functionality. If a private flag is set in a torrent, aria2 doesn\'t use DHT for that download even if true is given. Use --dht-listen-port option to specify port number to listen on.',
      name: 'enable_dht6_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable Peer Exchange`
  String get enable_peer_exchange {
    return Intl.message(
      'Enable Peer Exchange',
      name: 'enable_peer_exchange',
      desc: '',
      args: [],
    );
  }

  /// `Enable Peer Exchange extension. If a private flag is set in a torrent, this feature is disabled for that download even if true is given.`
  String get enable_peer_exchange_tooltip {
    return Intl.message(
      'Enable Peer Exchange extension. If a private flag is set in a torrent, this feature is disabled for that download even if true is given.',
      name: 'enable_peer_exchange_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Follow Torrent`
  String get follow_torrent {
    return Intl.message(
      'Follow Torrent',
      name: 'follow_torrent',
      desc: '',
      args: [],
    );
  }

  /// `If true or mem is specified, when a file whose suffix is .torrent or content type is application/x-bittorrent is downloaded, aria2 parses it as a torrent file and downloads files mentioned in it. If mem is specified, a torrent file is not written to the disk, but is just kept in memory. If false is specified, the .torrent file is downloaded to the disk, but is not parsed as a torrent and its contents are not downloaded.`
  String get follow_torrent_tooltip {
    return Intl.message(
      'If true or mem is specified, when a file whose suffix is .torrent or content type is application/x-bittorrent is downloaded, aria2 parses it as a torrent file and downloads files mentioned in it. If mem is specified, a torrent file is not written to the disk, but is just kept in memory. If false is specified, the .torrent file is downloaded to the disk, but is not parsed as a torrent and its contents are not downloaded.',
      name: 'follow_torrent_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Listen Port`
  String get listen_port {
    return Intl.message(
      'Listen Port',
      name: 'listen_port',
      desc: '',
      args: [],
    );
  }

  /// `Set TCP port number for BitTorrent downloads. Multiple ports can be specified by using "," for example: 6881,6885. You can also use - to specify a range: 6881-6999. , and - can be used together: 6881-6889,6999.`
  String get listen_port_tooltip {
    return Intl.message(
      'Set TCP port number for BitTorrent downloads. Multiple ports can be specified by using "," for example: 6881,6885. You can also use - to specify a range: 6881-6999. , and - can be used together: 6881-6889,6999.',
      name: 'listen_port_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Global Max Upload Limit`
  String get max_overall_upload_limit {
    return Intl.message(
      'Global Max Upload Limit',
      name: 'max_overall_upload_limit',
      desc: '',
      args: [],
    );
  }

  /// `Set max overall upload speed in bytes/sec. 0 means unrestricted. You can append K or M (1K `
  String get max_overall_upload_limit_tooltip {
    return Intl.message(
      'Set max overall upload speed in bytes/sec. 0 means unrestricted. You can append K or M (1K ',
      name: 'max_overall_upload_limit_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max Upload Limit`
  String get max_upload_limit {
    return Intl.message(
      'Max Upload Limit',
      name: 'max_upload_limit',
      desc: '',
      args: [],
    );
  }

  /// `Set max upload speed per each torrent in bytes/sec. 0 means unrestricted. You can append K or M (1K `
  String get max_upload_limit_tooltip {
    return Intl.message(
      'Set max upload speed per each torrent in bytes/sec. 0 means unrestricted. You can append K or M (1K ',
      name: 'max_upload_limit_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Peer ID Prefix`
  String get peer_id_prefix {
    return Intl.message(
      'Peer ID Prefix',
      name: 'peer_id_prefix',
      desc: '',
      args: [],
    );
  }

  /// `Specify the prefix of peer ID. The peer ID in BitTorrent is 20 byte length. If more than 20 bytes are specified, only first 20 bytes are used. If less than 20 bytes are specified, random byte data are added to make its length 20 bytes.`
  String get peer_id_prefix_tooltip {
    return Intl.message(
      'Specify the prefix of peer ID. The peer ID in BitTorrent is 20 byte length. If more than 20 bytes are specified, only first 20 bytes are used. If less than 20 bytes are specified, random byte data are added to make its length 20 bytes.',
      name: 'peer_id_prefix_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Peer Agent`
  String get peer_agent {
    return Intl.message(
      'Peer Agent',
      name: 'peer_agent',
      desc: '',
      args: [],
    );
  }

  /// `Specify the string used during the bitorrent extended handshake for the peer’s client version.`
  String get peer_agent_tooltip {
    return Intl.message(
      'Specify the string used during the bitorrent extended handshake for the peer’s client version.',
      name: 'peer_agent_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Min Share Ratio`
  String get seed_ratio {
    return Intl.message(
      'Min Share Ratio',
      name: 'seed_ratio',
      desc: '',
      args: [],
    );
  }

  /// `Specify share ratio. Seed completed torrents until share ratio reaches RATIO. You are strongly encouraged to specify equals or more than 1.0 here. Specify 0.0 if you intend to do seeding regardless of share ratio. If --seed-time option is specified along with this option, seeding ends when at least one of the conditions is satisfied.`
  String get seed_ratio_tooltip {
    return Intl.message(
      'Specify share ratio. Seed completed torrents until share ratio reaches RATIO. You are strongly encouraged to specify equals or more than 1.0 here. Specify 0.0 if you intend to do seeding regardless of share ratio. If --seed-time option is specified along with this option, seeding ends when at least one of the conditions is satisfied.',
      name: 'seed_ratio_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Min Seed Time`
  String get seed_time {
    return Intl.message(
      'Min Seed Time',
      name: 'seed_time',
      desc: '',
      args: [],
    );
  }

  /// `Specify seeding time in (fractional) minutes. Specifying --seed-time`
  String get seed_time_tooltip {
    return Intl.message(
      'Specify seeding time in (fractional) minutes. Specifying --seed-time',
      name: 'seed_time_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Follow Metalink`
  String get follow_metalink {
    return Intl.message(
      'Follow Metalink',
      name: 'follow_metalink',
      desc: '',
      args: [],
    );
  }

  /// `If true or mem is specified, when a file whose suffix is .meta4 or .metalink or content type of application/metalink4+xml or application/metalink+xml is downloaded, aria2 parses it as a metalink file and downloads files mentioned in it. If mem is specified, a metalink file is not written to the disk, but is just kept in memory. If false is specified, the .metalink file is downloaded to the disk, but is not parsed as a metalink file and its contents are not downloaded.`
  String get follow_metalink_tooltip {
    return Intl.message(
      'If true or mem is specified, when a file whose suffix is .meta4 or .metalink or content type of application/metalink4+xml or application/metalink+xml is downloaded, aria2 parses it as a metalink file and downloads files mentioned in it. If mem is specified, a metalink file is not written to the disk, but is just kept in memory. If false is specified, the .metalink file is downloaded to the disk, but is not parsed as a metalink file and its contents are not downloaded.',
      name: 'follow_metalink_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Base URI`
  String get metalink_base_uri {
    return Intl.message(
      'Base URI',
      name: 'metalink_base_uri',
      desc: '',
      args: [],
    );
  }

  /// `Specify base URI to resolve relative URI in metalink:url and metalink:metaurl element in a metalink file stored in local disk. If URI points to a directory, URI must end with /.`
  String get metalink_base_uri_tooltip {
    return Intl.message(
      'Specify base URI to resolve relative URI in metalink:url and metalink:metaurl element in a metalink file stored in local disk. If URI points to a directory, URI must end with /.',
      name: 'metalink_base_uri_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get metalink_language {
    return Intl.message(
      'Language',
      name: 'metalink_language',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get metalink_language_tooltip {
    return Intl.message(
      '',
      name: 'metalink_language_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Server Location`
  String get metalink_location {
    return Intl.message(
      'Preferred Server Location',
      name: 'metalink_location',
      desc: '',
      args: [],
    );
  }

  /// `The location of the preferred server. A comma-delimited list of locations is acceptable, for example, jp,us.`
  String get metalink_location_tooltip {
    return Intl.message(
      'The location of the preferred server. A comma-delimited list of locations is acceptable, for example, jp,us.',
      name: 'metalink_location_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Operation System`
  String get metalink_os {
    return Intl.message(
      'Operation System',
      name: 'metalink_os',
      desc: '',
      args: [],
    );
  }

  /// `The operating system of the file to download.`
  String get metalink_os_tooltip {
    return Intl.message(
      'The operating system of the file to download.',
      name: 'metalink_os_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get metalink_version {
    return Intl.message(
      'Version',
      name: 'metalink_version',
      desc: '',
      args: [],
    );
  }

  /// `The version of the file to download.`
  String get metalink_version_tooltip {
    return Intl.message(
      'The version of the file to download.',
      name: 'metalink_version_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Preferred Protocol`
  String get metalink_preferred_protocol {
    return Intl.message(
      'Preferred Protocol',
      name: 'metalink_preferred_protocol',
      desc: '',
      args: [],
    );
  }

  /// `Specify preferred protocol. The possible values are http, https, ftp and none. Specify none to disable this feature.`
  String get metalink_preferred_protocol_tooltip {
    return Intl.message(
      'Specify preferred protocol. The possible values are http, https, ftp and none. Specify none to disable this feature.',
      name: 'metalink_preferred_protocol_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable Unique Protocol`
  String get metalink_enable_unique_protocol {
    return Intl.message(
      'Enable Unique Protocol',
      name: 'metalink_enable_unique_protocol',
      desc: '',
      args: [],
    );
  }

  /// `If true is given and several protocols are available for a mirror in a metalink file, aria2 uses one of them. Use --metalink-preferred-protocol option to specify the preference of protocol.`
  String get metalink_enable_unique_protocol_tooltip {
    return Intl.message(
      'If true is given and several protocols are available for a mirror in a metalink file, aria2 uses one of them. Use --metalink-preferred-protocol option to specify the preference of protocol.',
      name: 'metalink_enable_unique_protocol_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable JSON-RPC/XML-RPC Server`
  String get enable_rpc {
    return Intl.message(
      'Enable JSON-RPC/XML-RPC Server',
      name: 'enable_rpc',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get enable_rpc_tooltip {
    return Intl.message(
      '',
      name: 'enable_rpc_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Pause After Metadata Downloaded`
  String get pause_metadata {
    return Intl.message(
      'Pause After Metadata Downloaded',
      name: 'pause_metadata',
      desc: '',
      args: [],
    );
  }

  /// `Pause downloads created as a result of metadata download. There are 3 types of metadata downloads in aria2: (1) downloading .torrent file. (2) downloading torrent metadata using magnet link. (3) downloading metalink file. These metadata downloads will generate downloads using their metadata. This option pauses these subsequent downloads. This option is effective only when --enable-rpc`
  String get pause_metadata_tooltip {
    return Intl.message(
      'Pause downloads created as a result of metadata download. There are 3 types of metadata downloads in aria2: (1) downloading .torrent file. (2) downloading torrent metadata using magnet link. (3) downloading metalink file. These metadata downloads will generate downloads using their metadata. This option pauses these subsequent downloads. This option is effective only when --enable-rpc',
      name: 'pause_metadata_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Allow All Origin Request`
  String get rpc_allow_origin_all {
    return Intl.message(
      'Allow All Origin Request',
      name: 'rpc_allow_origin_all',
      desc: '',
      args: [],
    );
  }

  /// `Add Access-Control-Allow-Origin header field with value * to the RPC response.`
  String get rpc_allow_origin_all_tooltip {
    return Intl.message(
      'Add Access-Control-Allow-Origin header field with value * to the RPC response.',
      name: 'rpc_allow_origin_all_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Listen on All Network Interfaces`
  String get rpc_listen_all {
    return Intl.message(
      'Listen on All Network Interfaces',
      name: 'rpc_listen_all',
      desc: '',
      args: [],
    );
  }

  /// `Listen incoming JSON-RPC/XML-RPC requests on all network interfaces. If false is given, listen only on local loopback interface.`
  String get rpc_listen_all_tooltip {
    return Intl.message(
      'Listen incoming JSON-RPC/XML-RPC requests on all network interfaces. If false is given, listen only on local loopback interface.',
      name: 'rpc_listen_all_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Listen Port`
  String get rpc_listen_port {
    return Intl.message(
      'Listen Port',
      name: 'rpc_listen_port',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get rpc_listen_port_tooltip {
    return Intl.message(
      '',
      name: 'rpc_listen_port_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max Request Size`
  String get rpc_max_request_size {
    return Intl.message(
      'Max Request Size',
      name: 'rpc_max_request_size',
      desc: '',
      args: [],
    );
  }

  /// `Set max size of JSON-RPC/XML-RPC request. If aria2 detects the request is more than SIZE bytes, it drops connection.`
  String get rpc_max_request_size_tooltip {
    return Intl.message(
      'Set max size of JSON-RPC/XML-RPC request. If aria2 detects the request is more than SIZE bytes, it drops connection.',
      name: 'rpc_max_request_size_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Save Upload Metadata`
  String get rpc_save_upload_metadata {
    return Intl.message(
      'Save Upload Metadata',
      name: 'rpc_save_upload_metadata',
      desc: '',
      args: [],
    );
  }

  /// `Save the uploaded torrent or metalink meta data in the directory specified by --dir option. The file name consists of SHA-1 hash hex string of meta data plus extension. For torrent, the extension is '.torrent'. For metalink, it is '.meta4'. If false is given to this option, the downloads added by aria2.addTorrent() or aria2.addMetalink() will not be saved by --save-session option.`
  String get rpc_save_upload_metadata_tooltip {
    return Intl.message(
      'Save the uploaded torrent or metalink meta data in the directory specified by --dir option. The file name consists of SHA-1 hash hex string of meta data plus extension. For torrent, the extension is \'.torrent\'. For metalink, it is \'.meta4\'. If false is given to this option, the downloads added by aria2.addTorrent() or aria2.addMetalink() will not be saved by --save-session option.',
      name: 'rpc_save_upload_metadata_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable SSL/TLS`
  String get rpc_secure {
    return Intl.message(
      'Enable SSL/TLS',
      name: 'rpc_secure',
      desc: '',
      args: [],
    );
  }

  /// `RPC transport will be encrypted by SSL/TLS. The RPC clients must use https scheme to access the server. For WebSocket client, use wss scheme. Use --rpc-certificate and --rpc-private-key options to specify the server certificate and private key.`
  String get rpc_secure_tooltip {
    return Intl.message(
      'RPC transport will be encrypted by SSL/TLS. The RPC clients must use https scheme to access the server. For WebSocket client, use wss scheme. Use --rpc-certificate and --rpc-private-key options to specify the server certificate and private key.',
      name: 'rpc_secure_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Allow Overwrite`
  String get allow_overwrite {
    return Intl.message(
      'Allow Overwrite',
      name: 'allow_overwrite',
      desc: '',
      args: [],
    );
  }

  /// `Restart download from scratch if the corresponding control file doesn't exist. See also --auto-file-renaming option.`
  String get allow_overwrite_tooltip {
    return Intl.message(
      'Restart download from scratch if the corresponding control file doesn\'t exist. See also --auto-file-renaming option.',
      name: 'allow_overwrite_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Allow Piece Length Change`
  String get allow_piece_length_change {
    return Intl.message(
      'Allow Piece Length Change',
      name: 'allow_piece_length_change',
      desc: '',
      args: [],
    );
  }

  /// `If false is given, aria2 aborts download when a piece length is different from one in a control file. If true is given, you can proceed but some download progress will be lost.`
  String get allow_piece_length_change_tooltip {
    return Intl.message(
      'If false is given, aria2 aborts download when a piece length is different from one in a control file. If true is given, you can proceed but some download progress will be lost.',
      name: 'allow_piece_length_change_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Always Resume Download`
  String get always_resume {
    return Intl.message(
      'Always Resume Download',
      name: 'always_resume',
      desc: '',
      args: [],
    );
  }

  /// `Always resume download. If true is given, aria2 always tries to resume download and if resume is not possible, aborts download. If false is given, when all given URIs do not support resume or aria2 encounters N URIs which does not support resume (N is the value specified using --max-resume-failure-tries option), aria2 downloads file from scratch. See --max-resume-failure-tries option.`
  String get always_resume_tooltip {
    return Intl.message(
      'Always resume download. If true is given, aria2 always tries to resume download and if resume is not possible, aborts download. If false is given, when all given URIs do not support resume or aria2 encounters N URIs which does not support resume (N is the value specified using --max-resume-failure-tries option), aria2 downloads file from scratch. See --max-resume-failure-tries option.',
      name: 'always_resume_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Asynchronous DNS`
  String get async_dns {
    return Intl.message(
      'Asynchronous DNS',
      name: 'async_dns',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get async_dns_tooltip {
    return Intl.message(
      '',
      name: 'async_dns_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Auto File Renaming`
  String get auto_file_renaming {
    return Intl.message(
      'Auto File Renaming',
      name: 'auto_file_renaming',
      desc: '',
      args: [],
    );
  }

  /// `Rename file name if the same file already exists. This option works only in HTTP(S)/FTP download. The new file name has a dot and a number(1..9999) appended after the name, but before the file extension, if any.`
  String get auto_file_renaming_tooltip {
    return Intl.message(
      'Rename file name if the same file already exists. This option works only in HTTP(S)/FTP download. The new file name has a dot and a number(1..9999) appended after the name, but before the file extension, if any.',
      name: 'auto_file_renaming_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Auto Save Interval`
  String get auto_save_interval {
    return Intl.message(
      'Auto Save Interval',
      name: 'auto_save_interval',
      desc: '',
      args: [],
    );
  }

  /// `Save a control file(*.aria2) every SEC seconds. If 0 is given, a control file is not saved during download. aria2 saves a control file when it stops regardless of the value. The possible values are between 0 to 600.`
  String get auto_save_interval_tooltip {
    return Intl.message(
      'Save a control file(*.aria2) every SEC seconds. If 0 is given, a control file is not saved during download. aria2 saves a control file when it stops regardless of the value. The possible values are between 0 to 600.',
      name: 'auto_save_interval_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Conditional Download`
  String get conditional_get {
    return Intl.message(
      'Conditional Download',
      name: 'conditional_get',
      desc: '',
      args: [],
    );
  }

  /// `Download file only when the local file is older than remote file. This function only works with HTTP(S) downloads only. It does not work if file size is specified in Metalink. It also ignores Content-Disposition header. If a control file exists, this option will be ignored. This function uses If-Modified-Since header to get only newer file conditionally. When getting modification time of local file, it uses user supplied file name (see --out option) or file name part in URI if --out is not specified. To overwrite existing file, --allow-overwrite is required.`
  String get conditional_get_tooltip {
    return Intl.message(
      'Download file only when the local file is older than remote file. This function only works with HTTP(S) downloads only. It does not work if file size is specified in Metalink. It also ignores Content-Disposition header. If a control file exists, this option will be ignored. This function uses If-Modified-Since header to get only newer file conditionally. When getting modification time of local file, it uses user supplied file name (see --out option) or file name part in URI if --out is not specified. To overwrite existing file, --allow-overwrite is required.',
      name: 'conditional_get_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Configuration File`
  String get conf_path {
    return Intl.message(
      'Configuration File',
      name: 'conf_path',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get conf_path_tooltip {
    return Intl.message(
      '',
      name: 'conf_path_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Console Log Level`
  String get console_log_level {
    return Intl.message(
      'Console Log Level',
      name: 'console_log_level',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get console_log_level_tooltip {
    return Intl.message(
      '',
      name: 'console_log_level_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Use UTF-8 to Handle Content-Disposition`
  String get content_disposition_default_utf8 {
    return Intl.message(
      'Use UTF-8 to Handle Content-Disposition',
      name: 'content_disposition_default_utf8',
      desc: '',
      args: [],
    );
  }

  /// `Handle quoted string in Content-Disposition header as UTF-8 instead of ISO-8859-1, for example, the filename parameter, but not the extended version filename.`
  String get content_disposition_default_utf8_tooltip {
    return Intl.message(
      'Handle quoted string in Content-Disposition header as UTF-8 instead of ISO-8859-1, for example, the filename parameter, but not the extended version filename.',
      name: 'content_disposition_default_utf8_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable Daemon`
  String get daemon {
    return Intl.message(
      'Enable Daemon',
      name: 'daemon',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get daemon_tooltip {
    return Intl.message(
      '',
      name: 'daemon_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Deferred Load`
  String get deferred_input {
    return Intl.message(
      'Deferred Load',
      name: 'deferred_input',
      desc: '',
      args: [],
    );
  }

  /// `If true is given, aria2 does not read all URIs and options from file specified by --input-file option at startup, but it reads one by one when it needs later. This may reduce memory usage if input file contains a lot of URIs to download. If false is given, aria2 reads all URIs and options at startup. --deferred-input option will be disabled when --save-session is used together.`
  String get deferred_input_tooltip {
    return Intl.message(
      'If true is given, aria2 does not read all URIs and options from file specified by --input-file option at startup, but it reads one by one when it needs later. This may reduce memory usage if input file contains a lot of URIs to download. If false is given, aria2 reads all URIs and options at startup. --deferred-input option will be disabled when --save-session is used together.',
      name: 'deferred_input_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Disable IPv6`
  String get disable_ipv6 {
    return Intl.message(
      'Disable IPv6',
      name: 'disable_ipv6',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get disable_ipv6_tooltip {
    return Intl.message(
      '',
      name: 'disable_ipv6_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Disk Cache`
  String get disk_cache {
    return Intl.message(
      'Disk Cache',
      name: 'disk_cache',
      desc: '',
      args: [],
    );
  }

  /// `Enable disk cache. If SIZE is 0, the disk cache is disabled. This feature caches the downloaded data in memory, which grows to at most SIZE bytes. The cache storage is created for aria2 instance and shared by all downloads. The one advantage of the disk cache is reduce the disk I/O because the data are written in larger unit and it is reordered by the offset of the file. If hash checking is involved and the data are cached in memory, we don't need to read them from the disk. SIZE can include K or M (1K `
  String get disk_cache_tooltip {
    return Intl.message(
      'Enable disk cache. If SIZE is 0, the disk cache is disabled. This feature caches the downloaded data in memory, which grows to at most SIZE bytes. The cache storage is created for aria2 instance and shared by all downloads. The one advantage of the disk cache is reduce the disk I/O because the data are written in larger unit and it is reordered by the offset of the file. If hash checking is involved and the data are cached in memory, we don\'t need to read them from the disk. SIZE can include K or M (1K ',
      name: 'disk_cache_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Download Result`
  String get download_result {
    return Intl.message(
      'Download Result',
      name: 'download_result',
      desc: '',
      args: [],
    );
  }

  /// `This option changes the way Download Results is formatted. If OPT is default, print GID, status, average download speed and path/URI. If multiple files are involved, path/URI of first requested file is printed and remaining ones are omitted. If OPT is full, print GID, status, average download speed, percentage of progress and path/URI. The percentage of progress and path/URI are printed for each requested file in each row. If OPT is hide, Download Results is hidden.`
  String get download_result_tooltip {
    return Intl.message(
      'This option changes the way Download Results is formatted. If OPT is default, print GID, status, average download speed and path/URI. If multiple files are involved, path/URI of first requested file is printed and remaining ones are omitted. If OPT is full, print GID, status, average download speed, percentage of progress and path/URI. The percentage of progress and path/URI are printed for each requested file in each row. If OPT is hide, Download Results is hidden.',
      name: 'download_result_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `DSCP`
  String get dscp {
    return Intl.message(
      'DSCP',
      name: 'dscp',
      desc: '',
      args: [],
    );
  }

  /// `Set DSCP value in outgoing IP packets of BitTorrent traffic for QoS. This parameter sets only DSCP bits in TOS field of IP packets, not the whole field. If you take values from /usr/include/netinet/ip.h divide them by 4 (otherwise values would be incorrect, e.g. your CS1 class would turn into CS4). If you take commonly used values from RFC, network vendors' documentation, Wikipedia or any other source, use them as they are.`
  String get dscp_tooltip {
    return Intl.message(
      'Set DSCP value in outgoing IP packets of BitTorrent traffic for QoS. This parameter sets only DSCP bits in TOS field of IP packets, not the whole field. If you take values from /usr/include/netinet/ip.h divide them by 4 (otherwise values would be incorrect, e.g. your CS1 class would turn into CS4). If you take commonly used values from RFC, network vendors\' documentation, Wikipedia or any other source, use them as they are.',
      name: 'dscp_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Soft Limit of Open File Descriptors`
  String get rlimit_nofile {
    return Intl.message(
      'Soft Limit of Open File Descriptors',
      name: 'rlimit_nofile',
      desc: '',
      args: [],
    );
  }

  /// `Set the soft limit of open file descriptors. This open will only have effect when: a. The system supports it (posix). b. The limit does not exceed the hard limit. c. The specified limit is larger than the current soft limit. This is equivalent to setting nofile via ulimit, except that it will never decrease the limit. This option is only available on systems supporting the rlimit API.`
  String get rlimit_nofile_tooltip {
    return Intl.message(
      'Set the soft limit of open file descriptors. This open will only have effect when: a. The system supports it (posix). b. The limit does not exceed the hard limit. c. The specified limit is larger than the current soft limit. This is equivalent to setting nofile via ulimit, except that it will never decrease the limit. This option is only available on systems supporting the rlimit API.',
      name: 'rlimit_nofile_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable Color in Terminal`
  String get enable_color {
    return Intl.message(
      'Enable Color in Terminal',
      name: 'enable_color',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get enable_color_tooltip {
    return Intl.message(
      '',
      name: 'enable_color_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable MMap`
  String get enable_mmap {
    return Intl.message(
      'Enable MMap',
      name: 'enable_mmap',
      desc: '',
      args: [],
    );
  }

  /// `Map files into memory. This option may not work if the file space is not pre-allocated. See --file-allocation.`
  String get enable_mmap_tooltip {
    return Intl.message(
      'Map files into memory. This option may not work if the file space is not pre-allocated. See --file-allocation.',
      name: 'enable_mmap_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Event Polling Method`
  String get event_poll {
    return Intl.message(
      'Event Polling Method',
      name: 'event_poll',
      desc: '',
      args: [],
    );
  }

  /// `Specify the method for polling events. The possible values are epoll, kqueue, port, poll and select. For each epoll, kqueue, port and poll, it is available if system supports it. epoll is available on recent Linux. kqueue is available on various *BSD systems including Mac OS X. port is available on Open Solaris. The default value may vary depending on the system you use.`
  String get event_poll_tooltip {
    return Intl.message(
      'Specify the method for polling events. The possible values are epoll, kqueue, port, poll and select. For each epoll, kqueue, port and poll, it is available if system supports it. epoll is available on recent Linux. kqueue is available on various *BSD systems including Mac OS X. port is available on Open Solaris. The default value may vary depending on the system you use.',
      name: 'event_poll_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `File Allocation Method`
  String get file_allocation {
    return Intl.message(
      'File Allocation Method',
      name: 'file_allocation',
      desc: '',
      args: [],
    );
  }

  /// `Specify file allocation method. none doesn't pre-allocate file space. prealloc pre-allocates file space before download begins. This may take some time depending on the size of the file. If you are using newer file systems such as ext4 (with extents support), btrfs, xfs or NTFS(MinGW build only), falloc is your best choice. It allocates large(few GiB) files almost instantly. Don't use falloc with legacy file systems such as ext3 and FAT32 because it takes almost same time as prealloc and it blocks aria2 entirely until allocation finishes. falloc may not be available if your system doesn't have posix_fallocate(3) function. trunc uses ftruncate(2) system call or platform-specific counterpart to truncate a file to a specified length. In multi file torrent downloads, the files adjacent forward to the specified files are also allocated if they share the same piece.`
  String get file_allocation_tooltip {
    return Intl.message(
      'Specify file allocation method. none doesn\'t pre-allocate file space. prealloc pre-allocates file space before download begins. This may take some time depending on the size of the file. If you are using newer file systems such as ext4 (with extents support), btrfs, xfs or NTFS(MinGW build only), falloc is your best choice. It allocates large(few GiB) files almost instantly. Don\'t use falloc with legacy file systems such as ext3 and FAT32 because it takes almost same time as prealloc and it blocks aria2 entirely until allocation finishes. falloc may not be available if your system doesn\'t have posix_fallocate(3) function. trunc uses ftruncate(2) system call or platform-specific counterpart to truncate a file to a specified length. In multi file torrent downloads, the files adjacent forward to the specified files are also allocated if they share the same piece.',
      name: 'file_allocation_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Force Save`
  String get force_save {
    return Intl.message(
      'Force Save',
      name: 'force_save',
      desc: '',
      args: [],
    );
  }

  /// `Save download with --save-session option even if the download is completed or removed. This option also saves control file in that situations. This may be useful to save BitTorrent seeding which is recognized as completed state.`
  String get force_save_tooltip {
    return Intl.message(
      'Save download with --save-session option even if the download is completed or removed. This option also saves control file in that situations. This may be useful to save BitTorrent seeding which is recognized as completed state.',
      name: 'force_save_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Save Not Found File`
  String get save_not_found {
    return Intl.message(
      'Save Not Found File',
      name: 'save_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Save download with --save-session option even if the file was not found on the server. This option also saves control file in that situations.`
  String get save_not_found_tooltip {
    return Intl.message(
      'Save download with --save-session option even if the file was not found on the server. This option also saves control file in that situations.',
      name: 'save_not_found_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Hash Check Only`
  String get hash_check_only {
    return Intl.message(
      'Hash Check Only',
      name: 'hash_check_only',
      desc: '',
      args: [],
    );
  }

  /// `If true is given, after hash check using --check-integrity option, abort download whether or not download is complete.`
  String get hash_check_only_tooltip {
    return Intl.message(
      'If true is given, after hash check using --check-integrity option, abort download whether or not download is complete.',
      name: 'hash_check_only_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Console Human Readable Output`
  String get human_readable {
    return Intl.message(
      'Console Human Readable Output',
      name: 'human_readable',
      desc: '',
      args: [],
    );
  }

  /// `Print sizes and speed in human readable format (e.g., 1.2Ki, 3.4Mi) in the console readout.`
  String get human_readable_tooltip {
    return Intl.message(
      'Print sizes and speed in human readable format (e.g., 1.2Ki, 3.4Mi) in the console readout.',
      name: 'human_readable_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Keep Unfinished Download Result`
  String get keep_unfinished_download_result {
    return Intl.message(
      'Keep Unfinished Download Result',
      name: 'keep_unfinished_download_result',
      desc: '',
      args: [],
    );
  }

  /// `Keep unfinished download results even if doing so exceeds --max-download-result. This is useful if all unfinished downloads must be saved in session file (see --save-session option). Please keep in mind that there is no upper bound to the number of unfinished download result to keep. If that is undesirable, turn this option off.`
  String get keep_unfinished_download_result_tooltip {
    return Intl.message(
      'Keep unfinished download results even if doing so exceeds --max-download-result. This is useful if all unfinished downloads must be saved in session file (see --save-session option). Please keep in mind that there is no upper bound to the number of unfinished download result to keep. If that is undesirable, turn this option off.',
      name: 'keep_unfinished_download_result_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max Download Result`
  String get max_download_result {
    return Intl.message(
      'Max Download Result',
      name: 'max_download_result',
      desc: '',
      args: [],
    );
  }

  /// `Set maximum number of download result kept in memory. The download results are completed/error/removed downloads. The download results are stored in FIFO queue and it can store at most NUM download results. When queue is full and new download result is created, oldest download result is removed from the front of the queue and new one is pushed to the back. Setting big number in this option may result high memory consumption after thousands of downloads. Specifying 0 means no download result is kept. Note that unfinished downloads are kept in memory regardless of this option value. See --keep-unfinished-download-result option.`
  String get max_download_result_tooltip {
    return Intl.message(
      'Set maximum number of download result kept in memory. The download results are completed/error/removed downloads. The download results are stored in FIFO queue and it can store at most NUM download results. When queue is full and new download result is created, oldest download result is removed from the front of the queue and new one is pushed to the back. Setting big number in this option may result high memory consumption after thousands of downloads. Specifying 0 means no download result is kept. Note that unfinished downloads are kept in memory regardless of this option value. See --keep-unfinished-download-result option.',
      name: 'max_download_result_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max MMap Limit`
  String get max_mmap_limit {
    return Intl.message(
      'Max MMap Limit',
      name: 'max_mmap_limit',
      desc: '',
      args: [],
    );
  }

  /// `Set the maximum file size to enable mmap (see --enable-mmap option). The file size is determined by the sum of all files contained in one download. For example, if a download contains 5 files, then file size is the total size of those files. If file size is strictly greater than the size specified in this option, mmap will be disabled.`
  String get max_mmap_limit_tooltip {
    return Intl.message(
      'Set the maximum file size to enable mmap (see --enable-mmap option). The file size is determined by the sum of all files contained in one download. For example, if a download contains 5 files, then file size is the total size of those files. If file size is strictly greater than the size specified in this option, mmap will be disabled.',
      name: 'max_mmap_limit_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max Resume Failure Try Times`
  String get max_resume_failure_tries {
    return Intl.message(
      'Max Resume Failure Try Times',
      name: 'max_resume_failure_tries',
      desc: '',
      args: [],
    );
  }

  /// `When used with --always-resume`
  String get max_resume_failure_tries_tooltip {
    return Intl.message(
      'When used with --always-resume',
      name: 'max_resume_failure_tries_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Min TLS Version`
  String get min_tls_version {
    return Intl.message(
      'Min TLS Version',
      name: 'min_tls_version',
      desc: '',
      args: [],
    );
  }

  /// `Specify minimum SSL/TLS version to enable.`
  String get min_tls_version_tooltip {
    return Intl.message(
      'Specify minimum SSL/TLS version to enable.',
      name: 'min_tls_version_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Log Level`
  String get log_level {
    return Intl.message(
      'Log Level',
      name: 'log_level',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get log_level_tooltip {
    return Intl.message(
      '',
      name: 'log_level_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Optimize Concurrent Downloads`
  String get optimize_concurrent_downloads {
    return Intl.message(
      'Optimize Concurrent Downloads',
      name: 'optimize_concurrent_downloads',
      desc: '',
      args: [],
    );
  }

  /// `Optimizes the number of concurrent downloads according to the bandwidth available. aria2 uses the download speed observed in the previous downloads to adapt the number of downloads launched in parallel according to the rule N `
  String get optimize_concurrent_downloads_tooltip {
    return Intl.message(
      'Optimizes the number of concurrent downloads according to the bandwidth available. aria2 uses the download speed observed in the previous downloads to adapt the number of downloads launched in parallel according to the rule N ',
      name: 'optimize_concurrent_downloads_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Piece Length`
  String get piece_length {
    return Intl.message(
      'Piece Length',
      name: 'piece_length',
      desc: '',
      args: [],
    );
  }

  /// `Set a piece length for HTTP/FTP downloads. This is the boundary when aria2 splits a file. All splits occur at multiple of this length. This option will be ignored in BitTorrent downloads. It will be also ignored if Metalink file contains piece hashes.`
  String get piece_length_tooltip {
    return Intl.message(
      'Set a piece length for HTTP/FTP downloads. This is the boundary when aria2 splits a file. All splits occur at multiple of this length. This option will be ignored in BitTorrent downloads. It will be also ignored if Metalink file contains piece hashes.',
      name: 'piece_length_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Show Console Output`
  String get show_console_readout {
    return Intl.message(
      'Show Console Output',
      name: 'show_console_readout',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get show_console_readout_tooltip {
    return Intl.message(
      '',
      name: 'show_console_readout_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Download Summary Output Interval`
  String get summary_interval {
    return Intl.message(
      'Download Summary Output Interval',
      name: 'summary_interval',
      desc: '',
      args: [],
    );
  }

  /// `Set interval in seconds to output download progress summary. Setting 0 suppresses the output.`
  String get summary_interval_tooltip {
    return Intl.message(
      'Set interval in seconds to output download progress summary. Setting 0 suppresses the output.',
      name: 'summary_interval_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Global Max Download Limit`
  String get max_overall_download_limit {
    return Intl.message(
      'Global Max Download Limit',
      name: 'max_overall_download_limit',
      desc: '',
      args: [],
    );
  }

  /// `Set max overall download speed in bytes/sec. 0 means unrestricted. You can append K or M (1K `
  String get max_overall_download_limit_tooltip {
    return Intl.message(
      'Set max overall download speed in bytes/sec. 0 means unrestricted. You can append K or M (1K ',
      name: 'max_overall_download_limit_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Max Download Limit`
  String get max_download_limit {
    return Intl.message(
      'Max Download Limit',
      name: 'max_download_limit',
      desc: '',
      args: [],
    );
  }

  /// `Set max download speed per each download in bytes/sec. 0 means unrestricted. You can append K or M (1K `
  String get max_download_limit_tooltip {
    return Intl.message(
      'Set max download speed per each download in bytes/sec. 0 means unrestricted. You can append K or M (1K ',
      name: 'max_download_limit_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Disable Configuration File`
  String get no_conf {
    return Intl.message(
      'Disable Configuration File',
      name: 'no_conf',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get no_conf_tooltip {
    return Intl.message(
      '',
      name: 'no_conf_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `No File Allocation Limit`
  String get no_file_allocation_limit {
    return Intl.message(
      'No File Allocation Limit',
      name: 'no_file_allocation_limit',
      desc: '',
      args: [],
    );
  }

  /// `No file allocation is made for files whose size is smaller than SIZE. You can append K or M (1K `
  String get no_file_allocation_limit_tooltip {
    return Intl.message(
      'No file allocation is made for files whose size is smaller than SIZE. You can append K or M (1K ',
      name: 'no_file_allocation_limit_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Enable Parameterized URI`
  String get parameterized_uri {
    return Intl.message(
      'Enable Parameterized URI',
      name: 'parameterized_uri',
      desc: '',
      args: [],
    );
  }

  /// `Enable parameterized URI support. You can specify set of parts: http://{sv1,sv2,sv3}/foo.iso. Also you can specify numeric sequences with step counter: http://host/image[000-100:2].img. A step counter can be omitted. If all URIs do not point to the same file, such as the second example above, -Z option is required.`
  String get parameterized_uri_tooltip {
    return Intl.message(
      'Enable parameterized URI support. You can specify set of parts: http://{sv1,sv2,sv3}/foo.iso. Also you can specify numeric sequences with step counter: http://host/image[000-100:2].img. A step counter can be omitted. If all URIs do not point to the same file, such as the second example above, -Z option is required.',
      name: 'parameterized_uri_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Disable Console Output`
  String get quiet {
    return Intl.message(
      'Disable Console Output',
      name: 'quiet',
      desc: '',
      args: [],
    );
  }

  /// ``
  String get quiet_tooltip {
    return Intl.message(
      '',
      name: 'quiet_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Realtime Data Chunk Validation`
  String get realtime_chunk_checksum {
    return Intl.message(
      'Realtime Data Chunk Validation',
      name: 'realtime_chunk_checksum',
      desc: '',
      args: [],
    );
  }

  /// `Validate chunk of data by calculating checksum while downloading a file if chunk checksums are provided.`
  String get realtime_chunk_checksum_tooltip {
    return Intl.message(
      'Validate chunk of data by calculating checksum while downloading a file if chunk checksums are provided.',
      name: 'realtime_chunk_checksum_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Remove Control File`
  String get remove_control_file {
    return Intl.message(
      'Remove Control File',
      name: 'remove_control_file',
      desc: '',
      args: [],
    );
  }

  /// `Remove control file before download. Using with --allow-overwrite`
  String get remove_control_file_tooltip {
    return Intl.message(
      'Remove control file before download. Using with --allow-overwrite',
      name: 'remove_control_file_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Session Save File`
  String get save_session {
    return Intl.message(
      'Session Save File',
      name: 'save_session',
      desc: '',
      args: [],
    );
  }

  /// `Save error/unfinished downloads to FILE on exit. You can pass this output file to aria2c with --input-file option on restart. If you like the output to be gzipped append a .gz extension to the file name. Please note that downloads added by aria2.addTorrent() and aria2.addMetalink() RPC method and whose meta data could not be saved as a file are not saved. Downloads removed using aria2.remove() and aria2.forceRemove() will not be saved.`
  String get save_session_tooltip {
    return Intl.message(
      'Save error/unfinished downloads to FILE on exit. You can pass this output file to aria2c with --input-file option on restart. If you like the output to be gzipped append a .gz extension to the file name. Please note that downloads added by aria2.addTorrent() and aria2.addMetalink() RPC method and whose meta data could not be saved as a file are not saved. Downloads removed using aria2.remove() and aria2.forceRemove() will not be saved.',
      name: 'save_session_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Save Session Interval`
  String get save_session_interval {
    return Intl.message(
      'Save Session Interval',
      name: 'save_session_interval',
      desc: '',
      args: [],
    );
  }

  /// `Save error/unfinished downloads to a file specified by --save-session option every SEC seconds. If 0 is given, file will be saved only when aria2 exits.`
  String get save_session_interval_tooltip {
    return Intl.message(
      'Save error/unfinished downloads to a file specified by --save-session option every SEC seconds. If 0 is given, file will be saved only when aria2 exits.',
      name: 'save_session_interval_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Socket Receive Buffer Size`
  String get socket_recv_buffer_size {
    return Intl.message(
      'Socket Receive Buffer Size',
      name: 'socket_recv_buffer_size',
      desc: '',
      args: [],
    );
  }

  /// `Set the maximum socket receive buffer in bytes. Specifing 0 will disable this option. This value will be set to socket file descriptor using SO_RCVBUF socket option with setsockopt() call.`
  String get socket_recv_buffer_size_tooltip {
    return Intl.message(
      'Set the maximum socket receive buffer in bytes. Specifing 0 will disable this option. This value will be set to socket file descriptor using SO_RCVBUF socket option with setsockopt() call.',
      name: 'socket_recv_buffer_size_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Auto Shutdown Time`
  String get stop {
    return Intl.message(
      'Auto Shutdown Time',
      name: 'stop',
      desc: '',
      args: [],
    );
  }

  /// `Stop application after SEC seconds has passed. If 0 is given, this feature is disabled.`
  String get stop_tooltip {
    return Intl.message(
      'Stop application after SEC seconds has passed. If 0 is given, this feature is disabled.',
      name: 'stop_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Truncate Console Output`
  String get truncate_console_readout {
    return Intl.message(
      'Truncate Console Output',
      name: 'truncate_console_readout',
      desc: '',
      args: [],
    );
  }

  /// `Truncate console readout to fit in a single line.`
  String get truncate_console_readout_tooltip {
    return Intl.message(
      'Truncate console readout to fit in a single line.',
      name: 'truncate_console_readout_tooltip',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overview {
    return Intl.message(
      'Overview',
      name: 'overview',
      desc: '',
      args: [],
    );
  }

  /// `Files`
  String get files {
    return Intl.message(
      'Files',
      name: 'files',
      desc: '',
      args: [],
    );
  }

  /// `Pieces`
  String get pieces {
    return Intl.message(
      'Pieces',
      name: 'pieces',
      desc: '',
      args: [],
    );
  }

  /// `Bittorrent Info`
  String get btInfo {
    return Intl.message(
      'Bittorrent Info',
      name: 'btInfo',
      desc: '',
      args: [],
    );
  }

  /// `Base Info`
  String get baseInfo {
    return Intl.message(
      'Base Info',
      name: 'baseInfo',
      desc: '',
      args: [],
    );
  }

  /// `Task Name`
  String get task_name {
    return Intl.message(
      'Task Name',
      name: 'task_name',
      desc: '',
      args: [],
    );
  }

  /// `Task Status`
  String get task_status {
    return Intl.message(
      'Task Status',
      name: 'task_status',
      desc: '',
      args: [],
    );
  }

  /// `Task Size`
  String get task_size {
    return Intl.message(
      'Task Size',
      name: 'task_size',
      desc: '',
      args: [],
    );
  }

  /// `Process`
  String get task_process {
    return Intl.message(
      'Process',
      name: 'task_process',
      desc: '',
      args: [],
    );
  }

  /// `Download Speed`
  String get download_speed {
    return Intl.message(
      'Download Speed',
      name: 'download_speed',
      desc: '',
      args: [],
    );
  }

  /// `Upload Speed`
  String get upload_speed {
    return Intl.message(
      'Upload Speed',
      name: 'upload_speed',
      desc: '',
      args: [],
    );
  }

  /// `Share Ratio`
  String get share_ratio {
    return Intl.message(
      'Share Ratio',
      name: 'share_ratio',
      desc: '',
      args: [],
    );
  }

  /// `Remaining`
  String get remain_time {
    return Intl.message(
      'Remaining',
      name: 'remain_time',
      desc: '',
      args: [],
    );
  }

  /// `Seeders/Connections`
  String get seedersAndConnections {
    return Intl.message(
      'Seeders/Connections',
      name: 'seedersAndConnections',
      desc: '',
      args: [],
    );
  }

  /// `Creation Date`
  String get creationDate {
    return Intl.message(
      'Creation Date',
      name: 'creationDate',
      desc: '',
      args: [],
    );
  }

  /// `Info_hash`
  String get info_hash {
    return Intl.message(
      'Info_hash',
      name: 'info_hash',
      desc: '',
      args: [],
    );
  }

  /// `Download Directory`
  String get download_dir {
    return Intl.message(
      'Download Directory',
      name: 'download_dir',
      desc: '',
      args: [],
    );
  }

  /// `BT Tracker Servers`
  String get bt_tracker_servers {
    return Intl.message(
      'BT Tracker Servers',
      name: 'bt_tracker_servers',
      desc: '',
      args: [],
    );
  }

  /// `Connections`
  String get connections {
    return Intl.message(
      'Connections',
      name: 'connections',
      desc: '',
      args: [],
    );
  }

  /// `Download URL`
  String get download_url {
    return Intl.message(
      'Download URL',
      name: 'download_url',
      desc: '',
      args: [],
    );
  }

  /// `Download Path`
  String get download_path {
    return Intl.message(
      'Download Path',
      name: 'download_path',
      desc: '',
      args: [],
    );
  }

  /// `Uncompleted`
  String get unCompleted {
    return Intl.message(
      'Uncompleted',
      name: 'unCompleted',
      desc: '',
      args: [],
    );
  }

  /// `UnKnown`
  String get unKnown {
    return Intl.message(
      'UnKnown',
      name: 'unKnown',
      desc: '',
      args: [],
    );
  }

  /// `Connection information`
  String get connection_info {
    return Intl.message(
      'Connection information',
      name: 'connection_info',
      desc: '',
      args: [],
    );
  }

  /// `Local`
  String get local {
    return Intl.message(
      'Local',
      name: 'local',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
