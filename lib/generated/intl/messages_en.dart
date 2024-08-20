// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) => "Completed: ${count}";

  static String m1(count) => "Downloading: ${count}";

  static String m2(count) => "Error: ${count}";

  static String m3(count) => "Paused: ${count}";

  static String m4(count) => "Removed: ${count}";

  static String m5(count) => "Stopped: ${count}";

  static String m6(count) => "Waiting: ${count}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "active": MessageLookupByLibrary.simpleMessage("Active"),
        "advanced": MessageLookupByLibrary.simpleMessage("advanced"),
        "all_proxy": MessageLookupByLibrary.simpleMessage("Proxy Server"),
        "all_proxy_passwd":
            MessageLookupByLibrary.simpleMessage("Proxy Password"),
        "all_proxy_passwd_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "all_proxy_tooltip": MessageLookupByLibrary.simpleMessage(
            "Use a proxy server for all protocols. You also can override this setting and specify a proxy server for a particular protocol using --http-proxy, --https-proxy and --ftp-proxy  This affects all downloads. The format of PROXY is [http://][USER:PASSWORD@]HOST[:PORT]."),
        "all_proxy_user":
            MessageLookupByLibrary.simpleMessage("Proxy User Name"),
        "all_proxy_user_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "allow_overwrite":
            MessageLookupByLibrary.simpleMessage("Allow Overwrite"),
        "allow_overwrite_tooltip": MessageLookupByLibrary.simpleMessage(
            "Restart download from scratch if the corresponding control file doesn\'t exist. See also --auto-file-renaming option."),
        "allow_piece_length_change":
            MessageLookupByLibrary.simpleMessage("Allow Piece Length Change"),
        "allow_piece_length_change_tooltip": MessageLookupByLibrary.simpleMessage(
            "If false is given, aria2 aborts download when a piece length is different from one in a control file. If true is given, you can proceed but some download progress will be lost."),
        "always_resume":
            MessageLookupByLibrary.simpleMessage("Always Resume Download"),
        "always_resume_tooltip": MessageLookupByLibrary.simpleMessage(
            "Always resume download. If true is given, aria2 always tries to resume download and if resume is not possible, aborts download. If false is given, when all given URIs do not support resume or aria2 encounters N URIs which does not support resume (N is the value specified using --max-resume-failure-tries option), aria2 downloads file from scratch. See --max-resume-failure-tries option."),
        "appNavigation1": MessageLookupByLibrary.simpleMessage("Servers"),
        "appNavigation2": MessageLookupByLibrary.simpleMessage("Downloads"),
        "appNavigation3": MessageLookupByLibrary.simpleMessage("Settings"),
        "aria2_alias": MessageLookupByLibrary.simpleMessage("Aria2 Alias"),
        "aria2_rpc_path":
            MessageLookupByLibrary.simpleMessage("Aria2 RPC Path"),
        "aria2_rpc_port":
            MessageLookupByLibrary.simpleMessage("Aria2 RPC Port"),
        "aria2_rpc_protocol":
            MessageLookupByLibrary.simpleMessage("Aria2 RPC Protocol"),
        "aria2_rpc_secret":
            MessageLookupByLibrary.simpleMessage("Aria2 RPC Secret"),
        "aria2_rpc_url": MessageLookupByLibrary.simpleMessage("Aria2 RPC URL"),
        "async_dns": MessageLookupByLibrary.simpleMessage("Asynchronous DNS"),
        "async_dns_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "auto_file_renaming":
            MessageLookupByLibrary.simpleMessage("Auto File Renaming"),
        "auto_file_renaming_tooltip": MessageLookupByLibrary.simpleMessage(
            "Rename file name if the same file already exists. This option works only in HTTP(S)/FTP download. The new file name has a dot and a number(1..9999) appended after the name, but before the file extension, if any."),
        "auto_save_interval":
            MessageLookupByLibrary.simpleMessage("Auto Save Interval"),
        "auto_save_interval_tooltip": MessageLookupByLibrary.simpleMessage(
            "Save a control file(*.aria2) every SEC seconds. If 0 is given, a control file is not saved during download. aria2 saves a control file when it stops regardless of the value. The possible values are between 0 to 600."),
        "bt_detach_seed_only":
            MessageLookupByLibrary.simpleMessage("Detach Seed Only"),
        "bt_detach_seed_only_tooltip": MessageLookupByLibrary.simpleMessage(
            "Exclude seed only downloads when counting concurrent active downloads (See -j option). This means that if -j3 is given and this option is turned on and 3 downloads are active and one of those enters seed mode, then it is excluded from active download count (thus it becomes 2), and the next download waiting in queue gets started. But be aware that seeding item is still recognized as active download in RPC method."),
        "bt_enable_hook_after_hash_check": MessageLookupByLibrary.simpleMessage(
            "Enable Hook After Hash Check"),
        "bt_enable_hook_after_hash_check_tooltip":
            MessageLookupByLibrary.simpleMessage(
                "Allow hook command invocation after hash check (see -V option) in BitTorrent download. By default, when hash check succeeds, the command given by --on-bt-download-complete is executed. To disable this action, give false to this option."),
        "bt_enable_lpd": MessageLookupByLibrary.simpleMessage(
            "Enable Local Peer Discovery (LPD)"),
        "bt_enable_lpd_tooltip": MessageLookupByLibrary.simpleMessage(
            "Enable Local Peer Discovery. If a private flag is set in a torrent, aria2 doesn\'t use this feature for that download even if true is given."),
        "bt_exclude_tracker":
            MessageLookupByLibrary.simpleMessage("BitTorrent Exclude Trackers"),
        "bt_exclude_tracker_tooltip": MessageLookupByLibrary.simpleMessage(
            "Comma separated list of BitTorrent tracker\'s announce URI to remove. You can use special value * which matches all URIs, thus removes all announce URIs. When specifying * in shell command-line, don\'t forget to escape or quote it."),
        "bt_external_ip": MessageLookupByLibrary.simpleMessage("External IP"),
        "bt_external_ip_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify the external IP address to use in BitTorrent download and DHT. It may be sent to BitTorrent tracker. For DHT, this option should be set to report that local node is downloading a particular torrent. This is critical to use DHT in a private network. Although this function is named external, it can accept any kind of IP addresses."),
        "bt_force_encryption":
            MessageLookupByLibrary.simpleMessage("Force Encryption"),
        "bt_force_encryption_tooltip": MessageLookupByLibrary.simpleMessage(
            "Requires BitTorrent message payload encryption with arc4. This is a shorthand of --bt-require-crypto --bt-min-crypto-level"),
        "bt_hash_check_seed":
            MessageLookupByLibrary.simpleMessage("Hash Check Before Seeding"),
        "bt_hash_check_seed_tooltip": MessageLookupByLibrary.simpleMessage(
            "If true is given, after hash check using --check-integrity option and file is complete, continue to seed file. If you want to check file and download it only when it is damaged or incomplete, set this option to false. This option has effect only on BitTorrent download."),
        "bt_load_saved_metadata":
            MessageLookupByLibrary.simpleMessage("Load Saved Metadata File"),
        "bt_load_saved_metadata_tooltip": MessageLookupByLibrary.simpleMessage(
            "Before getting torrent metadata from DHT when downloading with magnet link, first try to read file saved by --bt-save-metadata option. If it is successful, then skip downloading metadata from DHT."),
        "bt_max_open_files":
            MessageLookupByLibrary.simpleMessage("Max Open Files"),
        "bt_max_open_files_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify maximum number of files to open in multi-file BitTorrent/Metalink download globally."),
        "bt_max_peers": MessageLookupByLibrary.simpleMessage("Max Peers"),
        "bt_max_peers_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify the maximum number of peers per torrent. 0 means unlimited."),
        "bt_metadata_only":
            MessageLookupByLibrary.simpleMessage("Download Metadata Only"),
        "bt_metadata_only_tooltip": MessageLookupByLibrary.simpleMessage(
            "Download meta data only. The file(s) described in meta data will not be downloaded. This option has effect only when BitTorrent Magnet URI is used."),
        "bt_min_crypto_level":
            MessageLookupByLibrary.simpleMessage("Min Crypto Level"),
        "bt_min_crypto_level_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set minimum level of encryption method. If several encryption methods are provided by a peer, aria2 chooses the lowest one which satisfies the given level."),
        "bt_prioritize_piece":
            MessageLookupByLibrary.simpleMessage("Prioritize Piece"),
        "bt_prioritize_piece_tooltip": MessageLookupByLibrary.simpleMessage(
            "Try to download first and last pieces of each file first. This is useful for previewing files. The argument can contain 2 keywords: head and tail. To include both keywords, they must be separated by comma. These keywords can take one parameter, SIZE. For example, if head"),
        "bt_remove_unselected_file":
            MessageLookupByLibrary.simpleMessage("Remove Unselected File"),
        "bt_remove_unselected_file_tooltip": MessageLookupByLibrary.simpleMessage(
            "Removes the unselected files when download is completed in BitTorrent. To select files, use --select-file option. If it is not used, all files are assumed to be selected. Please use this option with care because it will actually remove files from your disk."),
        "bt_request_peer_speed_limit":
            MessageLookupByLibrary.simpleMessage("Preferred Download Speed"),
        "bt_request_peer_speed_limit_tooltip": MessageLookupByLibrary.simpleMessage(
            "If the whole download speed of every torrent is lower than SPEED, aria2 temporarily increases the number of peers to try for more download speed. Configuring this option with your preferred download speed can increase your download speed in some cases. You can append K or M (1K "),
        "bt_require_crypto":
            MessageLookupByLibrary.simpleMessage("Require Crypto"),
        "bt_require_crypto_tooltip": MessageLookupByLibrary.simpleMessage(
            "If true is given, aria2 doesn\'t accept and establish connection with legacy BitTorrent handshake(\\19BitTorrent protocol). Thus aria2 always uses Obfuscation handshake."),
        "bt_save_metadata":
            MessageLookupByLibrary.simpleMessage("Save Metadata"),
        "bt_save_metadata_tooltip": MessageLookupByLibrary.simpleMessage(
            "Save meta data as \".torrent\" file. This option has effect only when BitTorrent Magnet URI is used. The file name is hex encoded info hash with suffix \".torrent\". The directory to be saved is the same directory where download file is saved. If the same file already exists, meta data is not saved."),
        "bt_seed_unverified": MessageLookupByLibrary.simpleMessage(
            "Not Verify Downloaded Fileds"),
        "bt_seed_unverified_tooltip": MessageLookupByLibrary.simpleMessage(
            "Seed previously downloaded files without verifying piece hashes."),
        "bt_stop_timeout": MessageLookupByLibrary.simpleMessage("Stop Timeout"),
        "bt_stop_timeout_tooltip": MessageLookupByLibrary.simpleMessage(
            "Stop BitTorrent download if download speed is 0 in consecutive SEC seconds. If 0 is given, this feature is disabled."),
        "bt_tracker":
            MessageLookupByLibrary.simpleMessage("BitTorrent Trackers"),
        "bt_tracker_connect_timeout": MessageLookupByLibrary.simpleMessage(
            "BitTorrent Tracker Connect Timeout"),
        "bt_tracker_connect_timeout_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set the connect timeout in seconds to establish connection to tracker. After the connection is established, this option makes no effect and --bt-tracker-timeout option is used instead."),
        "bt_tracker_interval": MessageLookupByLibrary.simpleMessage(
            "BitTorrent Tracker Connect Interval"),
        "bt_tracker_interval_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set the interval in seconds between tracker requests. This completely overrides interval value and aria2 just uses this value and ignores the min interval and interval value in the response of tracker. If 0 is set, aria2 determines interval based on the response of tracker and the download progress."),
        "bt_tracker_timeout":
            MessageLookupByLibrary.simpleMessage("BitTorrent Tracker Timeout"),
        "bt_tracker_timeout_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "bt_tracker_tooltip": MessageLookupByLibrary.simpleMessage(
            "Comma separated list of additional BitTorrent tracker\'s announce URI. These URIs are not affected by --bt-exclude-tracker option because they are added after URIs in --bt-exclude-tracker option are removed."),
        "cancel": MessageLookupByLibrary.simpleMessage("cancel"),
        "check_certificate":
            MessageLookupByLibrary.simpleMessage("Check Certificate"),
        "check_certificate_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "check_firstly": MessageLookupByLibrary.simpleMessage(
            "you should check this server firstly"),
        "check_integrity":
            MessageLookupByLibrary.simpleMessage("Check Integrity"),
        "check_integrity_tooltip": MessageLookupByLibrary.simpleMessage(
            "Check file integrity by validating piece hashes or a hash of entire file. This option has effect only in BitTorrent, Metalink downloads with checksums or HTTP(S)/FTP downloads with --checksum option."),
        "checksum": MessageLookupByLibrary.simpleMessage("Checksum"),
        "checksum_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set checksum. The option value format is TYPE\\"),
        "completed": MessageLookupByLibrary.simpleMessage("Completed"),
        "completed_count": m0,
        "conditional_get":
            MessageLookupByLibrary.simpleMessage("Conditional Download"),
        "conditional_get_tooltip": MessageLookupByLibrary.simpleMessage(
            "Download file only when the local file is older than remote file. This function only works with HTTP(S) downloads only. It does not work if file size is specified in Metalink. It also ignores Content-Disposition header. If a control file exists, this option will be ignored. This function uses If-Modified-Since header to get only newer file conditionally. When getting modification time of local file, it uses user supplied file name (see --out option) or file name part in URI if --out is not specified. To overwrite existing file, --allow-overwrite is required."),
        "conf_path": MessageLookupByLibrary.simpleMessage("Configuration File"),
        "conf_path_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "confirm": MessageLookupByLibrary.simpleMessage("confirm"),
        "connect_timeout":
            MessageLookupByLibrary.simpleMessage("Connect Timeout"),
        "connect_timeout_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set the connect timeout in seconds to establish connection to HTTP/FTP/proxy server. After the connection is established, this option makes no effect and --timeout option is used instead."),
        "console_log_level":
            MessageLookupByLibrary.simpleMessage("Console Log Level"),
        "console_log_level_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "content_disposition_default_utf8":
            MessageLookupByLibrary.simpleMessage(
                "Use UTF-8 to Handle Content-Disposition"),
        "content_disposition_default_utf8_tooltip":
            MessageLookupByLibrary.simpleMessage(
                "Handle quoted string in Content-Disposition header as UTF-8 instead of ISO-8859-1, for example, the filename parameter, but not the extended version filename."),
        "continue_": MessageLookupByLibrary.simpleMessage("Resume Download"),
        "continue_tooltip": MessageLookupByLibrary.simpleMessage(
            "Continue downloading a partially downloaded file. Use this option to resume a download started by a web browser or another program which downloads files sequentially from the beginning. Currently this option is only applicable to HTTP(S)/FTP downloads."),
        "daemon": MessageLookupByLibrary.simpleMessage("Enable Daemon"),
        "daemon_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "darkTheme": MessageLookupByLibrary.simpleMessage("dark"),
        "deferred_input": MessageLookupByLibrary.simpleMessage("Deferred Load"),
        "deferred_input_tooltip": MessageLookupByLibrary.simpleMessage(
            "If true is given, aria2 does not read all URIs and options from file specified by --input-file option at startup, but it reads one by one when it needs later. This may reduce memory usage if input file contains a lot of URIs to download. If false is given, aria2 reads all URIs and options at startup. --deferred-input option will be disabled when --save-session is used together."),
        "delete": MessageLookupByLibrary.simpleMessage("delete"),
        "dht_file_path":
            MessageLookupByLibrary.simpleMessage("DHT (IPv4) File"),
        "dht_file_path6":
            MessageLookupByLibrary.simpleMessage("DHT (IPv6) File"),
        "dht_file_path6_tooltip": MessageLookupByLibrary.simpleMessage(
            "Change the IPv6 DHT routing table file to PATH."),
        "dht_file_path_tooltip": MessageLookupByLibrary.simpleMessage(
            "Change the IPv4 DHT routing table file to PATH."),
        "dht_listen_port":
            MessageLookupByLibrary.simpleMessage("DHT Listen Port"),
        "dht_listen_port_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set UDP listening port used by DHT(IPv4, IPv6) and UDP tracker. Multiple ports can be specified by using \",\" for example: 6881,6885. You can also use - to specify a range: 6881-6999. , and - can be used together."),
        "dht_message_timeout":
            MessageLookupByLibrary.simpleMessage("DHT Message Timeout"),
        "dht_message_timeout_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "dir": MessageLookupByLibrary.simpleMessage("Download Path"),
        "dir_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "disable_ipv6": MessageLookupByLibrary.simpleMessage("Disable IPv6"),
        "disable_ipv6_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "disk_cache": MessageLookupByLibrary.simpleMessage("Disk Cache"),
        "disk_cache_tooltip": MessageLookupByLibrary.simpleMessage(
            "Enable disk cache. If SIZE is 0, the disk cache is disabled. This feature caches the downloaded data in memory, which grows to at most SIZE bytes. The cache storage is created for aria2 instance and shared by all downloads. The one advantage of the disk cache is reduce the disk I/O because the data are written in larger unit and it is reordered by the offset of the file. If hash checking is involved and the data are cached in memory, we don\'t need to read them from the disk. SIZE can include K or M (1K "),
        "download": MessageLookupByLibrary.simpleMessage("download"),
        "download_result":
            MessageLookupByLibrary.simpleMessage("Download Result"),
        "download_result_tooltip": MessageLookupByLibrary.simpleMessage(
            "This option changes the way Download Results is formatted. If OPT is default, print GID, status, average download speed and path/URI. If multiple files are involved, path/URI of first requested file is printed and remaining ones are omitted. If OPT is full, print GID, status, average download speed, percentage of progress and path/URI. The percentage of progress and path/URI are printed for each requested file in each row. If OPT is hide, Download Results is hidden."),
        "downloading": MessageLookupByLibrary.simpleMessage("Downloading"),
        "downloading_count": m1,
        "dry_run": MessageLookupByLibrary.simpleMessage("Dry Run"),
        "dry_run_tooltip": MessageLookupByLibrary.simpleMessage(
            "If true is given, aria2 just checks whether the remote file is available and doesn\'t download data. This option has effect on HTTP/FTP download. BitTorrent downloads are canceled if true is specified."),
        "dscp": MessageLookupByLibrary.simpleMessage("DSCP"),
        "dscp_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set DSCP value in outgoing IP packets of BitTorrent traffic for QoS. This parameter sets only DSCP bits in TOS field of IP packets, not the whole field. If you take values from /usr/include/netinet/ip.h divide them by 4 (otherwise values would be incorrect, e.g. your CS1 class would turn into CS4). If you take commonly used values from RFC, network vendors\' documentation, Wikipedia or any other source, use them as they are."),
        "enableSettingChangeTipLabel":
            MessageLookupByLibrary.simpleMessage("Enable setting confirm"),
        "enable_color":
            MessageLookupByLibrary.simpleMessage("Enable Color in Terminal"),
        "enable_color_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "enable_dht": MessageLookupByLibrary.simpleMessage("Enable DHT (IPv4)"),
        "enable_dht6":
            MessageLookupByLibrary.simpleMessage("Enable DHT (IPv6)"),
        "enable_dht6_tooltip": MessageLookupByLibrary.simpleMessage(
            "Enable IPv6 DHT functionality. If a private flag is set in a torrent, aria2 doesn\'t use DHT for that download even if true is given. Use --dht-listen-port option to specify port number to listen on."),
        "enable_dht_tooltip": MessageLookupByLibrary.simpleMessage(
            "Enable IPv4 DHT functionality. It also enables UDP tracker support. If a private flag is set in a torrent, aria2 doesn\'t use DHT for that download even if true is given."),
        "enable_http_keep_alive": MessageLookupByLibrary.simpleMessage(
            "Enable Persistent Connection"),
        "enable_http_keep_alive_tooltip": MessageLookupByLibrary.simpleMessage(
            "Enable HTTP/1.1 persistent connection."),
        "enable_http_pipelining":
            MessageLookupByLibrary.simpleMessage("Enable HTTP Pipelining"),
        "enable_http_pipelining_tooltip":
            MessageLookupByLibrary.simpleMessage("Enable HTTP/1.1 pipelining."),
        "enable_mmap": MessageLookupByLibrary.simpleMessage("Enable MMap"),
        "enable_mmap_tooltip": MessageLookupByLibrary.simpleMessage(
            "Map files into memory. This option may not work if the file space is not pre-allocated. See --file-allocation."),
        "enable_peer_exchange":
            MessageLookupByLibrary.simpleMessage("Enable Peer Exchange"),
        "enable_peer_exchange_tooltip": MessageLookupByLibrary.simpleMessage(
            "Enable Peer Exchange extension. If a private flag is set in a torrent, this feature is disabled for that download even if true is given."),
        "enable_rpc": MessageLookupByLibrary.simpleMessage(
            "Enable JSON-RPC/XML-RPC Server"),
        "enable_rpc_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "error_count": m2,
        "event_poll":
            MessageLookupByLibrary.simpleMessage("Event Polling Method"),
        "event_poll_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify the method for polling events. The possible values are epoll, kqueue, port, poll and select. For each epoll, kqueue, port and poll, it is available if system supports it. epoll is available on recent Linux. kqueue is available on various *BSD systems including Mac OS X. port is available on Open Solaris. The default value may vary depending on the system you use."),
        "file_allocation":
            MessageLookupByLibrary.simpleMessage("File Allocation Method"),
        "file_allocation_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify file allocation method. none doesn\'t pre-allocate file space. prealloc pre-allocates file space before download begins. This may take some time depending on the size of the file. If you are using newer file systems such as ext4 (with extents support), btrfs, xfs or NTFS(MinGW build only), falloc is your best choice. It allocates large(few GiB) files almost instantly. Don\'t use falloc with legacy file systems such as ext3 and FAT32 because it takes almost same time as prealloc and it blocks aria2 entirely until allocation finishes. falloc may not be available if your system doesn\'t have posix_fallocate(3) function. trunc uses ftruncate(2) system call or platform-specific counterpart to truncate a file to a specified length. In multi file torrent downloads, the files adjacent forward to the specified files are also allocated if they share the same piece."),
        "follow_metalink":
            MessageLookupByLibrary.simpleMessage("Follow Metalink"),
        "follow_metalink_tooltip": MessageLookupByLibrary.simpleMessage(
            "If true or mem is specified, when a file whose suffix is .meta4 or .metalink or content type of application/metalink4+xml or application/metalink+xml is downloaded, aria2 parses it as a metalink file and downloads files mentioned in it. If mem is specified, a metalink file is not written to the disk, but is just kept in memory. If false is specified, the .metalink file is downloaded to the disk, but is not parsed as a metalink file and its contents are not downloaded."),
        "follow_torrent":
            MessageLookupByLibrary.simpleMessage("Follow Torrent"),
        "follow_torrent_tooltip": MessageLookupByLibrary.simpleMessage(
            "If true or mem is specified, when a file whose suffix is .torrent or content type is application/x-bittorrent is downloaded, aria2 parses it as a torrent file and downloads files mentioned in it. If mem is specified, a torrent file is not written to the disk, but is just kept in memory. If false is specified, the .torrent file is downloaded to the disk, but is not parsed as a torrent and its contents are not downloaded."),
        "force_save": MessageLookupByLibrary.simpleMessage("Force Save"),
        "force_save_tooltip": MessageLookupByLibrary.simpleMessage(
            "Save download with --save-session option even if the download is completed or removed. This option also saves control file in that situations. This may be useful to save BitTorrent seeding which is recognized as completed state."),
        "ftp_passwd":
            MessageLookupByLibrary.simpleMessage("FTP Default Password"),
        "ftp_passwd_tooltip": MessageLookupByLibrary.simpleMessage(
            "If user name is embedded but password is missing in URI, aria2 tries to resolve password using .netrc. If password is found in .netrc, then use it as password. If not, use the password specified in this option."),
        "ftp_pasv": MessageLookupByLibrary.simpleMessage("Passive Mode"),
        "ftp_pasv_tooltip": MessageLookupByLibrary.simpleMessage(
            "Use the passive mode in FTP. If false is given, the active mode will be used. This option is ignored for SFTP transfer."),
        "ftp_proxy": MessageLookupByLibrary.simpleMessage("FTP Proxy Server"),
        "ftp_proxy_passwd":
            MessageLookupByLibrary.simpleMessage("FTP Proxy Password"),
        "ftp_proxy_passwd_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "ftp_proxy_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "ftp_proxy_user":
            MessageLookupByLibrary.simpleMessage("FTP Proxy User Name"),
        "ftp_proxy_user_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "ftp_reuse_connection":
            MessageLookupByLibrary.simpleMessage("Reuse Connection"),
        "ftp_reuse_connection_tooltip":
            MessageLookupByLibrary.simpleMessage(""),
        "ftp_type": MessageLookupByLibrary.simpleMessage("Transfer Type"),
        "ftp_type_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "ftp_user":
            MessageLookupByLibrary.simpleMessage("FTP Default User Name"),
        "ftp_user_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "globalRefreshIntervalLabel": MessageLookupByLibrary.simpleMessage(
            "Updating Global Stat Interval"),
        "global_limit": MessageLookupByLibrary.simpleMessage("Global Limit"),
        "hash_check_only":
            MessageLookupByLibrary.simpleMessage("Hash Check Only"),
        "hash_check_only_tooltip": MessageLookupByLibrary.simpleMessage(
            "If true is given, after hash check using --check-integrity option, abort download whether or not download is complete."),
        "header": MessageLookupByLibrary.simpleMessage("Custom Header"),
        "header_tooltip": MessageLookupByLibrary.simpleMessage(
            "Append HEADER to HTTP request header. Put one item per line, each item containing \"header name: header value\"."),
        "http_accept_gzip": MessageLookupByLibrary.simpleMessage("Accept GZip"),
        "http_accept_gzip_tooltip": MessageLookupByLibrary.simpleMessage(
            "Send Accept: deflate, gzip request header and inflate response if remote server responds with Content-Encoding: gzip or Content-Encoding: deflate."),
        "http_auth_challenge":
            MessageLookupByLibrary.simpleMessage("Auth Challenge"),
        "http_auth_challenge_tooltip": MessageLookupByLibrary.simpleMessage(
            "Send HTTP authorization header only when it is requested by the server. If false is set, then authorization header is always sent to the server. There is an exception: if user name and password are embedded in URI, authorization header is always sent to the server regardless of this option."),
        "http_no_cache": MessageLookupByLibrary.simpleMessage("No Cache"),
        "http_no_cache_tooltip": MessageLookupByLibrary.simpleMessage(
            "Send Cache-Control: no-cache and Pragma: no-cache header to avoid cached content. If false is given, these headers are not sent and you can add Cache-Control header with a directive you like using --header option."),
        "http_passwd":
            MessageLookupByLibrary.simpleMessage("HTTP Default Password"),
        "http_passwd_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "http_proxy": MessageLookupByLibrary.simpleMessage("HTTP Proxy Server"),
        "http_proxy_passwd":
            MessageLookupByLibrary.simpleMessage("HTTP Proxy Password"),
        "http_proxy_passwd_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "http_proxy_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "http_proxy_user":
            MessageLookupByLibrary.simpleMessage("HTTP Proxy User Name"),
        "http_proxy_user_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "http_user":
            MessageLookupByLibrary.simpleMessage("HTTP Default User Name"),
        "http_user_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "https_proxy":
            MessageLookupByLibrary.simpleMessage("HTTPS Proxy Server"),
        "https_proxy_passwd":
            MessageLookupByLibrary.simpleMessage("HTTPS Proxy Password"),
        "https_proxy_passwd_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "https_proxy_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "https_proxy_user":
            MessageLookupByLibrary.simpleMessage("HTTPS Proxy User Name"),
        "https_proxy_user_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "human_readable": MessageLookupByLibrary.simpleMessage(
            "Console Human Readable Output"),
        "human_readable_tooltip": MessageLookupByLibrary.simpleMessage(
            "Print sizes and speed in human readable format (e.g., 1.2Ki, 3.4Mi) in the console readout."),
        "keep_unfinished_download_result": MessageLookupByLibrary.simpleMessage(
            "Keep Unfinished Download Result"),
        "keep_unfinished_download_result_tooltip":
            MessageLookupByLibrary.simpleMessage(
                "Keep unfinished download results even if doing so exceeds --max-download-result. This is useful if all unfinished downloads must be saved in session file (see --save-session option). Please keep in mind that there is no upper bound to the number of unfinished download result to keep. If that is undesirable, turn this option off."),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("light"),
        "listen_port": MessageLookupByLibrary.simpleMessage("Listen Port"),
        "listen_port_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set TCP port number for BitTorrent downloads. Multiple ports can be specified by using \",\" for example: 6881,6885. You can also use - to specify a range: 6881-6999. , and - can be used together: 6881-6889,6999."),
        "log": MessageLookupByLibrary.simpleMessage("Log File"),
        "log_level": MessageLookupByLibrary.simpleMessage("Log Level"),
        "log_level_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "log_tooltip": MessageLookupByLibrary.simpleMessage(
            "The file name of the log file. If - is specified, log is written to stdout. If empty string(\"\") is specified, or this option is omitted, no log is written to disk at all."),
        "lowest_speed_limit":
            MessageLookupByLibrary.simpleMessage("Lowest Speed Limit"),
        "lowest_speed_limit_tooltip": MessageLookupByLibrary.simpleMessage(
            "Close connection if download speed is lower than or equal to this value(bytes per sec). 0 means aria2 does not have a lowest speed limit. You can append K or M (1K "),
        "max_concurrent_downloads":
            MessageLookupByLibrary.simpleMessage("Max Concurrent Downloads"),
        "max_concurrent_downloads_tooltip":
            MessageLookupByLibrary.simpleMessage(""),
        "max_connection_per_server":
            MessageLookupByLibrary.simpleMessage("Max Connection Per Server"),
        "max_connection_per_server_tooltip":
            MessageLookupByLibrary.simpleMessage(""),
        "max_download_limit":
            MessageLookupByLibrary.simpleMessage("Max Download Limit"),
        "max_download_limit_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set max download speed per each download in bytes/sec. 0 means unrestricted. You can append K or M (1K "),
        "max_download_result":
            MessageLookupByLibrary.simpleMessage("Max Download Result"),
        "max_download_result_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set maximum number of download result kept in memory. The download results are completed/error/removed downloads. The download results are stored in FIFO queue and it can store at most NUM download results. When queue is full and new download result is created, oldest download result is removed from the front of the queue and new one is pushed to the back. Setting big number in this option may result high memory consumption after thousands of downloads. Specifying 0 means no download result is kept. Note that unfinished downloads are kept in memory regardless of this option value. See --keep-unfinished-download-result option."),
        "max_file_not_found": MessageLookupByLibrary.simpleMessage(
            "Max File Not Found Try Times"),
        "max_file_not_found_tooltip": MessageLookupByLibrary.simpleMessage(
            "If aria2 receives \"file not found\" status from the remote HTTP/FTP servers NUM times without getting a single byte, then force the download to fail. Specify 0 to disable this option. This options is effective only when using HTTP/FTP servers. The number of retry attempt is counted toward --max-tries, so it should be configured too."),
        "max_mmap_limit":
            MessageLookupByLibrary.simpleMessage("Max MMap Limit"),
        "max_mmap_limit_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set the maximum file size to enable mmap (see --enable-mmap option). The file size is determined by the sum of all files contained in one download. For example, if a download contains 5 files, then file size is the total size of those files. If file size is strictly greater than the size specified in this option, mmap will be disabled."),
        "max_overall_download_limit":
            MessageLookupByLibrary.simpleMessage("Global Max Download Limit"),
        "max_overall_download_limit_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set max overall download speed in bytes/sec. 0 means unrestricted. You can append K or M (1K "),
        "max_overall_upload_limit":
            MessageLookupByLibrary.simpleMessage("Global Max Upload Limit"),
        "max_overall_upload_limit_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set max overall upload speed in bytes/sec. 0 means unrestricted. You can append K or M (1K "),
        "max_resume_failure_tries": MessageLookupByLibrary.simpleMessage(
            "Max Resume Failure Try Times"),
        "max_resume_failure_tries_tooltip":
            MessageLookupByLibrary.simpleMessage(
                "When used with --always-resume"),
        "max_tries": MessageLookupByLibrary.simpleMessage("Max Try Times"),
        "max_tries_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set number of tries. 0 means unlimited."),
        "max_upload_limit":
            MessageLookupByLibrary.simpleMessage("Max Upload Limit"),
        "max_upload_limit_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set max upload speed per each torrent in bytes/sec. 0 means unrestricted. You can append K or M (1K "),
        "metalink_base_uri": MessageLookupByLibrary.simpleMessage("Base URI"),
        "metalink_base_uri_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify base URI to resolve relative URI in metalink:url and metalink:metaurl element in a metalink file stored in local disk. If URI points to a directory, URI must end with /."),
        "metalink_enable_unique_protocol":
            MessageLookupByLibrary.simpleMessage("Enable Unique Protocol"),
        "metalink_enable_unique_protocol_tooltip":
            MessageLookupByLibrary.simpleMessage(
                "If true is given and several protocols are available for a mirror in a metalink file, aria2 uses one of them. Use --metalink-preferred-protocol option to specify the preference of protocol."),
        "metalink_language": MessageLookupByLibrary.simpleMessage("Language"),
        "metalink_language_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "metalink_location":
            MessageLookupByLibrary.simpleMessage("Preferred Server Location"),
        "metalink_location_tooltip": MessageLookupByLibrary.simpleMessage(
            "The location of the preferred server. A comma-delimited list of locations is acceptable, for example, jp,us."),
        "metalink_os": MessageLookupByLibrary.simpleMessage("Operation System"),
        "metalink_os_tooltip": MessageLookupByLibrary.simpleMessage(
            "The operating system of the file to download."),
        "metalink_preferred_protocol":
            MessageLookupByLibrary.simpleMessage("Preferred Protocol"),
        "metalink_preferred_protocol_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify preferred protocol. The possible values are http, https, ftp and none. Specify none to disable this feature."),
        "metalink_version": MessageLookupByLibrary.simpleMessage("Version"),
        "metalink_version_tooltip": MessageLookupByLibrary.simpleMessage(
            "The version of the file to download."),
        "min_split_size":
            MessageLookupByLibrary.simpleMessage("Min Split Size"),
        "min_split_size_tooltip": MessageLookupByLibrary.simpleMessage(
            "aria2 does not split less than 2*SIZE byte range. For example, let\'s consider downloading 20MiB file. If SIZE is 10M, aria2 can split file into 2 range [0-10MiB) and [10MiB-20MiB) and download it using 2 sources(if --split >"),
        "min_tls_version":
            MessageLookupByLibrary.simpleMessage("Min TLS Version"),
        "min_tls_version_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify minimum SSL/TLS version to enable."),
        "minute": MessageLookupByLibrary.simpleMessage("min"),
        "netrc_path": MessageLookupByLibrary.simpleMessage(".netrc Path"),
        "netrc_path_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "no": MessageLookupByLibrary.simpleMessage("no"),
        "no_conf":
            MessageLookupByLibrary.simpleMessage("Disable Configuration File"),
        "no_conf_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "no_file_allocation_limit":
            MessageLookupByLibrary.simpleMessage("No File Allocation Limit"),
        "no_file_allocation_limit_tooltip": MessageLookupByLibrary.simpleMessage(
            "No file allocation is made for files whose size is smaller than SIZE. You can append K or M (1K "),
        "no_netrc": MessageLookupByLibrary.simpleMessage("Disable netrc"),
        "no_netrc_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "no_proxy": MessageLookupByLibrary.simpleMessage("No Proxy List"),
        "no_proxy_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify a comma separated list of host names, domains and network addresses with or without a subnet mask where no proxy should be used."),
        "offline": MessageLookupByLibrary.simpleMessage("offline"),
        "online": MessageLookupByLibrary.simpleMessage("online"),
        "optimize_concurrent_downloads": MessageLookupByLibrary.simpleMessage(
            "Optimize Concurrent Downloads"),
        "optimize_concurrent_downloads_tooltip":
            MessageLookupByLibrary.simpleMessage(
                "Optimizes the number of concurrent downloads according to the bandwidth available. aria2 uses the download speed observed in the previous downloads to adapt the number of downloads launched in parallel according to the rule N "),
        "out": MessageLookupByLibrary.simpleMessage("File Name"),
        "out_tooltip": MessageLookupByLibrary.simpleMessage(
            "The file name of the downloaded file. It is always relative to the directory given in --dir option. When the --force-sequential option is used, this option is ignored."),
        "parameterized_uri":
            MessageLookupByLibrary.simpleMessage("Enable Parameterized URI"),
        "parameterized_uri_tooltip": MessageLookupByLibrary.simpleMessage(
            "Enable parameterized URI support. You can specify set of parts: http://{sv1,sv2,sv3}/foo.iso. Also you can specify numeric sequences with step counter: http://host/image[000-100:2].img. A step counter can be omitted. If all URIs do not point to the same file, such as the second example above, -Z option is required."),
        "pause_metadata": MessageLookupByLibrary.simpleMessage(
            "Pause After Metadata Downloaded"),
        "pause_metadata_tooltip": MessageLookupByLibrary.simpleMessage(
            "Pause downloads created as a result of metadata download. There are 3 types of metadata downloads in aria2: (1) downloading .torrent file. (2) downloading torrent metadata using magnet link. (3) downloading metalink file. These metadata downloads will generate downloads using their metadata. This option pauses these subsequent downloads. This option is effective only when --enable-rpc"),
        "paused": MessageLookupByLibrary.simpleMessage("Paused"),
        "paused_count": m3,
        "peer_agent": MessageLookupByLibrary.simpleMessage("Peer Agent"),
        "peer_agent_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify the string used during the bitorrent extended handshake for the peer’s client version."),
        "peer_id_prefix":
            MessageLookupByLibrary.simpleMessage("Peer ID Prefix"),
        "peer_id_prefix_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify the prefix of peer ID. The peer ID in BitTorrent is 20 byte length. If more than 20 bytes are specified, only first 20 bytes are used. If less than 20 bytes are specified, random byte data are added to make its length 20 bytes."),
        "piece_length": MessageLookupByLibrary.simpleMessage("Piece Length"),
        "piece_length_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set a piece length for HTTP/FTP downloads. This is the boundary when aria2 splits a file. All splits occur at multiple of this length. This option will be ignored in BitTorrent downloads. It will be also ignored if Metalink file contains piece hashes."),
        "proxy_method": MessageLookupByLibrary.simpleMessage("Proxy Method"),
        "proxy_method_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set the method to use in proxy request. METHOD is either GET or TUNNEL. HTTPS downloads always use TUNNEL regardless of this option."),
        "quiet": MessageLookupByLibrary.simpleMessage("Disable Console Output"),
        "quiet_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "realtime_chunk_checksum": MessageLookupByLibrary.simpleMessage(
            "Realtime Data Chunk Validation"),
        "realtime_chunk_checksum_tooltip": MessageLookupByLibrary.simpleMessage(
            "Validate chunk of data by calculating checksum while downloading a file if chunk checksums are provided."),
        "referer": MessageLookupByLibrary.simpleMessage("Referer"),
        "referer_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set an http referrer (Referer). This affects all http/https downloads. If * is given, the download URI is also used as the referrer. This may be useful when used together with the --parameterized-uri option."),
        "remote_time":
            MessageLookupByLibrary.simpleMessage("Remote File Timestamp"),
        "remote_time_tooltip": MessageLookupByLibrary.simpleMessage(
            "Retrieve timestamp of the remote file from the remote HTTP/FTP server and if it is available, apply it to the local file."),
        "remove_control_file":
            MessageLookupByLibrary.simpleMessage("Remove Control File"),
        "remove_control_file_tooltip": MessageLookupByLibrary.simpleMessage(
            "Remove control file before download. Using with --allow-overwrite"),
        "removed": MessageLookupByLibrary.simpleMessage("Removed"),
        "removed_count": m4,
        "retry_wait": MessageLookupByLibrary.simpleMessage("Retry Wait"),
        "retry_wait_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set the seconds to wait between retries. When SEC > 0, aria2 will retry downloads when the HTTP server returns a 503 response."),
        "reuse_uri": MessageLookupByLibrary.simpleMessage("Reuse Uri"),
        "reuse_uri_tooltip": MessageLookupByLibrary.simpleMessage(
            "Reuse already used URIs if no unused URIs are left."),
        "rlimit_nofile": MessageLookupByLibrary.simpleMessage(
            "Soft Limit of Open File Descriptors"),
        "rlimit_nofile_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set the soft limit of open file descriptors. This open will only have effect when: a. The system supports it (posix). b. The limit does not exceed the hard limit. c. The specified limit is larger than the current soft limit. This is equivalent to setting nofile via ulimit, except that it will never decrease the limit. This option is only available on systems supporting the rlimit API."),
        "rpc_allow_origin_all":
            MessageLookupByLibrary.simpleMessage("Allow All Origin Request"),
        "rpc_allow_origin_all_tooltip": MessageLookupByLibrary.simpleMessage(
            "Add Access-Control-Allow-Origin header field with value * to the RPC response."),
        "rpc_listen_all": MessageLookupByLibrary.simpleMessage(
            "Listen on All Network Interfaces"),
        "rpc_listen_all_tooltip": MessageLookupByLibrary.simpleMessage(
            "Listen incoming JSON-RPC/XML-RPC requests on all network interfaces. If false is given, listen only on local loopback interface."),
        "rpc_listen_port": MessageLookupByLibrary.simpleMessage("Listen Port"),
        "rpc_listen_port_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "rpc_max_request_size":
            MessageLookupByLibrary.simpleMessage("Max Request Size"),
        "rpc_max_request_size_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set max size of JSON-RPC/XML-RPC request. If aria2 detects the request is more than SIZE bytes, it drops connection."),
        "rpc_save_upload_metadata":
            MessageLookupByLibrary.simpleMessage("Save Upload Metadata"),
        "rpc_save_upload_metadata_tooltip": MessageLookupByLibrary.simpleMessage(
            "Save the uploaded torrent or metalink meta data in the directory specified by --dir option. The file name consists of SHA-1 hash hex string of meta data plus extension. For torrent, the extension is \'.torrent\'. For metalink, it is \'.meta4\'. If false is given to this option, the downloads added by aria2.addTorrent() or aria2.addMetalink() will not be saved by --save-session option."),
        "rpc_secure": MessageLookupByLibrary.simpleMessage("Enable SSL/TLS"),
        "rpc_secure_tooltip": MessageLookupByLibrary.simpleMessage(
            "RPC transport will be encrypted by SSL/TLS. The RPC clients must use https scheme to access the server. For WebSocket client, use wss scheme. Use --rpc-certificate and --rpc-private-key options to specify the server certificate and private key."),
        "save_cookies": MessageLookupByLibrary.simpleMessage("Cookies Path"),
        "save_cookies_tooltip": MessageLookupByLibrary.simpleMessage(
            "Save Cookies to FILE in Mozilla/Firefox(1.x/2.x)/ Netscape format. If FILE already exists, it is overwritten. Session Cookies are also saved and their expiry values are treated as 0."),
        "save_not_found":
            MessageLookupByLibrary.simpleMessage("Save Not Found File"),
        "save_not_found_tooltip": MessageLookupByLibrary.simpleMessage(
            "Save download with --save-session option even if the file was not found on the server. This option also saves control file in that situations."),
        "save_session":
            MessageLookupByLibrary.simpleMessage("Session Save File"),
        "save_session_interval":
            MessageLookupByLibrary.simpleMessage("Save Session Interval"),
        "save_session_interval_tooltip": MessageLookupByLibrary.simpleMessage(
            "Save error/unfinished downloads to a file specified by --save-session option every SEC seconds. If 0 is given, file will be saved only when aria2 exits."),
        "save_session_tooltip": MessageLookupByLibrary.simpleMessage(
            "Save error/unfinished downloads to FILE on exit. You can pass this output file to aria2c with --input-file option on restart. If you like the output to be gzipped append a .gz extension to the file name. Please note that downloads added by aria2.addTorrent() and aria2.addMetalink() RPC method and whose meta data could not be saved as a file are not saved. Downloads removed using aria2.remove() and aria2.forceRemove() will not be saved."),
        "second": MessageLookupByLibrary.simpleMessage("s"),
        "seed_ratio": MessageLookupByLibrary.simpleMessage("Min Share Ratio"),
        "seed_ratio_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify share ratio. Seed completed torrents until share ratio reaches RATIO. You are strongly encouraged to specify equals or more than 1.0 here. Specify 0.0 if you intend to do seeding regardless of share ratio. If --seed-time option is specified along with this option, seeding ends when at least one of the conditions is satisfied."),
        "seed_time": MessageLookupByLibrary.simpleMessage("Min Seed Time"),
        "seed_time_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify seeding time in (fractional) minutes. Specifying --seed-time"),
        "serverPageTitle": MessageLookupByLibrary.simpleMessage("Servers"),
        "server_stat_of":
            MessageLookupByLibrary.simpleMessage("Server Stat Output"),
        "server_stat_of_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify the file name to which performance profile of the servers is saved. You can load saved data using --server-stat-if option."),
        "server_stat_timeout":
            MessageLookupByLibrary.simpleMessage("Server Stat Timeout"),
        "server_stat_timeout_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specifies timeout in seconds to invalidate performance profile of the servers since the last contact to them."),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "show_console_readout":
            MessageLookupByLibrary.simpleMessage("Show Console Output"),
        "show_console_readout_tooltip":
            MessageLookupByLibrary.simpleMessage(""),
        "socket_recv_buffer_size":
            MessageLookupByLibrary.simpleMessage("Socket Receive Buffer Size"),
        "socket_recv_buffer_size_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set the maximum socket receive buffer in bytes. Specifing 0 will disable this option. This value will be set to socket file descriptor using SO_RCVBUF socket option with setsockopt() call."),
        "split": MessageLookupByLibrary.simpleMessage("Split Count"),
        "split_tooltip": MessageLookupByLibrary.simpleMessage(
            "Download a file using N connections. If more than N URIs are given, first N URIs are used and remaining URIs are used for backup. If less than N URIs are given, those URIs are used more than once so that N connections total are made simultaneously. The number of connections to the same host is restricted by the --max-connection-per-server option."),
        "ssh_host_key_md":
            MessageLookupByLibrary.simpleMessage("SSH Public Key Checksum"),
        "ssh_host_key_md_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set checksum for SSH host public key. The option value format is TYPE"),
        "stop": MessageLookupByLibrary.simpleMessage("Auto Shutdown Time"),
        "stop_tooltip": MessageLookupByLibrary.simpleMessage(
            "Stop application after SEC seconds has passed. If 0 is given, this feature is disabled."),
        "stopped": MessageLookupByLibrary.simpleMessage("Stopped"),
        "stopped_count": m5,
        "stream_piece_selector":
            MessageLookupByLibrary.simpleMessage("Piece Selection Algorithm"),
        "stream_piece_selector_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify piece selection algorithm used in HTTP/FTP download. Piece means fixed length segment which is downloaded in parallel in segmented download. If default is given, aria2 selects piece so that it reduces the number of establishing connection. This is reasonable default behavior because establishing connection is an expensive operation. If inorder is given, aria2 selects piece which has minimum index. Index"),
        "summary_interval": MessageLookupByLibrary.simpleMessage(
            "Download Summary Output Interval"),
        "summary_interval_tooltip": MessageLookupByLibrary.simpleMessage(
            "Set interval in seconds to output download progress summary. Setting 0 suppresses the output."),
        "taskRefreshIntervalLabel": MessageLookupByLibrary.simpleMessage(
            "Updating Task Information Interval"),
        "test": MessageLookupByLibrary.simpleMessage("test"),
        "theme": MessageLookupByLibrary.simpleMessage("Theme"),
        "timeout": MessageLookupByLibrary.simpleMessage("Timeout"),
        "timeout_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "truncate_console_readout":
            MessageLookupByLibrary.simpleMessage("Truncate Console Output"),
        "truncate_console_readout_tooltip":
            MessageLookupByLibrary.simpleMessage(
                "Truncate console readout to fit in a single line."),
        "upload": MessageLookupByLibrary.simpleMessage("upload"),
        "uri_selector":
            MessageLookupByLibrary.simpleMessage("URI Selection Algorithm"),
        "uri_selector_tooltip": MessageLookupByLibrary.simpleMessage(
            "Specify URI selection algorithm. The possible values are inorder, feedback and adaptive. If inorder is given, URI is tried in the order appeared in the URI list. If feedback is given, aria2 uses download speed observed in the previous downloads and choose fastest server in the URI list. This also effectively skips dead mirrors. The observed download speed is a part of performance profile of servers mentioned in --server-stat-of and --server-stat-if  If adaptive is given, selects one of the best mirrors for the first and reserved connections. For supplementary ones, it returns mirrors which has not been tested yet, and if each of them has already been tested, returns mirrors which has to be tested again. Otherwise, it doesn\'t select anymore mirrors. Like feedback, it uses a performance profile of servers."),
        "use_head": MessageLookupByLibrary.simpleMessage("Use HEAD Method"),
        "use_head_tooltip": MessageLookupByLibrary.simpleMessage(
            "Use HEAD method for the first request to the HTTP server."),
        "user_agent": MessageLookupByLibrary.simpleMessage("Custom User Agent"),
        "user_agent_tooltip": MessageLookupByLibrary.simpleMessage(""),
        "waiting": MessageLookupByLibrary.simpleMessage("Waiting"),
        "waiting_count": m6,
        "yes": MessageLookupByLibrary.simpleMessage("yes")
      };
}
