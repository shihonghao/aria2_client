import 'dart:io';

enum UrlType { http, https, ftp, sftp, magnet, metalink, unknown }

class UrlUtil {
  /// 判断下载链接的类型
  ///
  /// 返回值可以是 'http', 'https', 'ftp', 'sftp', 'magnet', 'metalink' 或 'unknown'
  static UrlType determineLinkType(String link) {
    if (_isHttp(link)) {
      return UrlType.http;
    } else if (_isHttps(link)) {
      return UrlType.https;
    } else if (_isFtp(link)) {
      return UrlType.ftp;
    } else if (_isSftp(link)) {
      return UrlType.sftp;
    } else if (_isMagnet(link)) {
      return UrlType.magnet;
    } else if (_isMetalink(link)) {
      return UrlType.metalink;
    } else {
      return UrlType.unknown;
    }
  }

  /// HTTP 链接正则表达式
  static final RegExp _httpRegex = RegExp(r'^http://');

  /// HTTPS 链接正则表达式
  static final RegExp _httpsRegex = RegExp(r'^https://');

  /// FTP 链接正则表达式
  static final RegExp _ftpRegex = RegExp(r'^ftp://');

  /// SFTP 链接正则表达式
  static final RegExp _sftpRegex = RegExp(r'^sftp://');

  /// 磁力链接正则表达式
  static final RegExp _magnetRegex = RegExp(r'^magnet:\?xt=');

  /// Metalink 链接正则表达式
  static final RegExp _metalinkRegex =
      RegExp(r'^(http|https)://.*\.metalink$|^.*\.torrent$');

  /// 检查是否为 HTTP 链接
  static bool _isHttp(String link) => _httpRegex.hasMatch(link);

  /// 检查是否为 HTTPS 链接
  static bool _isHttps(String link) => _httpsRegex.hasMatch(link);

  /// 检查是否为 FTP 链接
  static bool _isFtp(String link) => _ftpRegex.hasMatch(link);

  /// 检查是否为 SFTP 链接
  static bool _isSftp(String link) => _sftpRegex.hasMatch(link);

  /// 检查是否为磁力链接
  static bool _isMagnet(String link) => _magnetRegex.hasMatch(link);

  /// 检查是否为 Metalink 链接
  static bool _isMetalink(String link) {
    final match = _metalinkRegex.hasMatch(link);
    // if (match && link.endsWith('.torrent')) {
    //   // 如果是 .torrent 文件，尝试解析文件以确认是否为 Metalink
    //   try {
    //     final bytes = File(link).readAsBytesSync();
    //     final decoded = decode(bytes);
    //     return decoded is Map<String, dynamic> && decoded.containsKey('info');
    //   } catch (e) {
    //     return false;
    //   }
    // }
    return match;
  }
}
