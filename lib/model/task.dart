import 'package:aria2_client/aria2/model/json/converter.dart';
import 'package:aria2_client/service/peer_id_parser.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

enum TaskStatus {
  @JsonValue('active')
  active,
  @JsonValue('waiting')
  waiting,
  @JsonValue('paused')
  paused,
  @JsonValue('error')
  error,
  @JsonValue('complete')
  complete,
  @JsonValue('removed')
  removed,
}

@JsonSerializable(explicitToJson: true)
class Task {
  /// 下载的 GID
  final String gid;

  @JsonKey(includeFromJson: false)
  String? taskName;

  /// 下载状态
  ///  active   当前正在下载/做种的下载
  ///  waiting  在队列中的下载；下载尚未开始
  ///  paused   暂停的下载
  ///  error    因错误而停止的下载
  ///  complete 停止并完成的下载
  ///  removed  用户移除的下载

  TaskStatus status;

  /// 下载的总长度（以字节为单位）
  @StringToIntegerConverter()
  int? totalLength;

  /// 下载的已完成长度（以字节为单位）
  @StringToIntegerConverter()
  int? completedLength;

  @StringToIntegerConverter()
  int? lastCompletedLength;

  /// 上传的长度（以字节为单位）
  @StringToIntegerConverter()
  int? uploadLength;

  /// 下载进度的十六进制表示。最高位对应索引为 0 的片段。任何被设定的位表示已加载的片段，而未设置的位表示尚未加载和/或丢失的片段。末尾的任何溢出位被设定为零。当下载尚未开始时，此键不会包含在响应中。
  String? bitfield;

  /// 下载速度（以字节/秒为单位）
  @StringToIntegerConverter()
  int? downloadSpeed;

  /// 上传速度（以字节/秒为单位）
  @StringToIntegerConverter()
  int? uploadSpeed;

  /// InfoHash。仅适用于 BitTorrent。
  String? infoHash;

  /// aria2 连接的做种者数量。仅适用于 BitTorrent。
  @StringToIntegerConverter()
  int? numSeeders;

  /// 是否是做种者,仅适用于 BitTorrent。
  @StringToBoolConverter()
  bool? seeder;

  /// 片段长度（以字节为单位）
  @StringToIntegerConverter()
  int? pieceLength;

  /// 片段数量
  @StringToIntegerConverter()
  int? numPieces;

  /// aria2 连接到的对等方/服务器数量
  @StringToIntegerConverter()
  int? connections;

  ///对于此项的最后一个错误代码，如果有的话。值为字符串。错误代码在 退出状态 部分中有定义。此值仅适用于已停止/已完成的下载。
  @StringToIntegerConverter()
  int? errorCode;

  /// 错误消息
  String? errorMessage;

  /// 生成为此下载结果的 GID 列表。
  /// 例如，当 aria2 下载一个 Metalink 文件时，会生成 Metalink 中描述的下载（参见 --follow-metalink 选项）。此值对于跟踪自动生成的下载非常有用。如果没有这样的下载，则此键不会包含在响应中
  List<String>? followedBy;

  /// “followedBy”的反向链接。包含在“followedBy”中的下载在其 following 值中具有该对象的 GID。
  String? following;

  /// 父下载的 GID。某些下载是另一个下载的一部分。例如，如果 Metalink 中的文件具有 BitTorrent 资源，则“.torrent”文件的下载是该父项的一部分。如果此下载没有父项，则此键不会包含在响应中。
  String? belongsTo;

  /// 下载的目录
  String? dir;

  /// 下载的文件列表
  List<TaskFile>? files;

  Bittorrent? bittorrent;

  /// 在文件进行哈希检查时验证的字节数量。此键仅在此下载正在进行哈希检查时存在。
  String? verifiedLength;

  /// 如果此下载正在等待在队列中进行哈希检查，则为“true”。此键仅在此下载在队列中时存在
  String? verifyIntegrityPending;

  int? lastDownloadSpeed;

  int? lastUploadSpeed;

  Task({
    required this.gid,
    required this.status,
    required this.totalLength,
    required this.completedLength,
    this.uploadLength,
    this.bitfield,
    this.downloadSpeed = 0,
    this.uploadSpeed = 0,
    this.infoHash,
    this.numSeeders,
    this.seeder,
    this.pieceLength,
    this.numPieces,
    this.connections,
    this.errorCode,
    this.errorMessage,
    this.followedBy,
    this.following,
    this.belongsTo,
    this.dir,
    this.files,
    this.bittorrent,
    this.verifiedLength,
    this.verifyIntegrityPending,
  })  : lastCompletedLength = 0,
        lastDownloadSpeed = 0,
        lastUploadSpeed = 0,
        taskName = analysisTaskName(bittorrent, files);

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String?, dynamic> toJson() => _$TaskToJson(this);

  bool isBitTorrent() {
    return bittorrent != null;
  }

  String formatBytes(int? bytes) {
    if (bytes == null) {
      return "0 b";
    }
    String res = "0 b";
    if (bytes >= 1024 && bytes < 1024 * 1024) {
      res = "${(bytes.toDouble() / 1024).toStringAsFixed(2)} kb";
    } else if (bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024) {
      res = "${(bytes.toDouble() / 1024 / 1024).toStringAsFixed(2)} mb";
    } else if (bytes >= 1024 * 1024 * 1024) {
      res = "${(bytes.toDouble() / 1024 / 1024 / 1024).toStringAsFixed(2)} gb";
    } else {
      res = "$bytes b";
    }
    return res;
  }

  String getRemainTime() {
    if (downloadSpeed == 0) {
      return "99:99:99";
    }
    String remainTime = "00:00:00";
    if (totalLength == 0) {
      return remainTime;
    }
    if (status == TaskStatus.active) {
      var seconds = totalLength! ~/ downloadSpeed! + 1;
      if (seconds > 0) {
        var remainSeconds = seconds.toInt();
        var hour = remainSeconds ~/ 3600;
        var minute = (remainSeconds - hour * 3600) ~/ 60;
        var second = remainSeconds - hour * 3600 - minute * 60;
        remainTime =
            "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}";
      }
    }
    return remainTime;
  }

  static String analysisTaskName(Bittorrent? bittorrent, List<TaskFile>? files) {
    String? taskName = bittorrent?.info?.name;

    if (taskName == null && files != null && files.isNotEmpty) {
      taskName = getFileName(files[0]);
    }
    taskName ??= 'Unknown';
    return taskName;
  }

  static String? getFileName(TaskFile file) {
    String? path = file.path;
    var needUrlDecode = false;

    if (path == null ||
        path.isEmpty && file.uris != null && file.uris!.isNotEmpty) {
      path = file.uris![0].uri;
      needUrlDecode = true;
    }

    if (path == null) {
      return "Unknown";
    }

    int? index = path.lastIndexOf('/');
    if (index <= 0 || index == path.length) {
      return path;
    }

    var fileNameAndQueryString = path.substring(index + 1);
    var queryStringStartPos = fileNameAndQueryString.indexOf('?');
    var fileName = fileNameAndQueryString;

    if (queryStringStartPos > 0) {
      fileName = fileNameAndQueryString.substring(0, queryStringStartPos);
    }

    if (needUrlDecode) {
      try {
        fileName = Uri.decodeFull(fileName);
      } catch (ex) {
        fileName = "Unknown";
      }
    }

    return fileName;
  }

  static String computedFilePercentage(TaskFile file){
    return file.completedLength == null || file.length == null
        ? "0 %"
        : "${(file.completedLength! / file.length! * 100).toStringAsFixed(2)} %";
  }

  void update(Task task) {
    lastCompletedLength = completedLength;
    lastUploadSpeed = uploadSpeed;
    lastDownloadSpeed = downloadSpeed;

    completedLength = task.completedLength;
    uploadLength = task.uploadLength;
    downloadSpeed = task.downloadSpeed;
    uploadSpeed = task.uploadSpeed;
    numPieces = task.numPieces;
    bitfield = task.bitfield;
  }

  bool isChanged() {
    return lastCompletedLength != completedLength ||
        lastUploadSpeed != uploadSpeed ||
        lastDownloadSpeed != downloadSpeed;
  }

  String computedPercentage() {
    return completedLength == null || totalLength == null
        ? "0 %"
        : "${(completedLength! / totalLength! * 100).toStringAsFixed(2)} %";
  }

  String? getUri() {
    if (files != null &&
        files!.isNotEmpty &&
        files![0].uris != null &&
        files![0].uris!.isNotEmpty) {
      return files![0].uris![0].uri;
    }
    return null;
  }

  String? getDownloadPath() {
    if (files != null && files!.isNotEmpty) {
      return files![0].path!.substring(0, files![0].path!.lastIndexOf("/"));
    }
    return null;
  }

  String getShareRatio() {
    return (completedLength == null
        ? "0.0 %"
        : completedLength! > 0
            ? "${((uploadLength ?? 0) / completedLength!).toStringAsFixed(2)} %"
            : "0.0 %");
  }
}

@JsonSerializable()
class TaskFile {
  @StringToIntegerConverter()
  int? completedLength;
  @StringToIntegerConverter()
  int? index;
  @StringToIntegerConverter()
  int? length;
  @StringToBoolConverter()
  bool? selected;
  List<TaskUri>? uris;
  String? path;

  TaskFile({
    this.completedLength,
    this.index,
    this.length,
    this.selected,
    this.uris,
    this.path,
  });

  factory TaskFile.fromJson(Map<String, dynamic> json) =>
      _$TaskFileFromJson(json);

  Map<String?, dynamic> toJson() => _$TaskFileToJson(this);
}

@JsonSerializable()
class TaskUri {
  String? uri;
  String? status;

  TaskUri({this.uri, this.status});

  factory TaskUri.fromJson(Map<String, dynamic> json) =>
      _$TaskUriFromJson(json);

  Map<String?, dynamic> toJson() => _$TaskUriToJson(this);
}

@JsonSerializable()
class Bittorrent {
  List<List<String>>? announceList;
  String? comment;
  int? creationDate;
  String? mode;
  BittorrentInfo? info;

  Bittorrent({
    this.announceList,
    this.comment,
    this.creationDate,
    this.mode,
    this.info,
  });

  factory Bittorrent.fromJson(Map<String, dynamic> json) =>
      _$BittorrentFromJson(json);

  Map<String?, dynamic> toJson() => _$BittorrentToJson(this);
}

@JsonSerializable()
class BittorrentInfo {
  String? name;

  BittorrentInfo({
    this.name,
  });

  factory BittorrentInfo.fromJson(Map<String, dynamic> json) =>
      _$BittorrentInfoFromJson(json);

  Map<String?, dynamic> toJson() => _$BittorrentInfoToJson(this);
}

@JsonSerializable()
class Peer {
  String? peerId;
  String? ip;
  String? port;
  String? bitfield;
  @StringToBoolConverter()
  bool? amChoking;
  @StringToBoolConverter()
  bool? peerChoking;
  @StringToIntegerConverter()
  int? downloadSpeed;
  @StringToIntegerConverter()
  int? uploadSpeed;
  @StringToBoolConverter()
  bool? seeder;

  @JsonKey(includeFromJson: false)
  String? client;

  Peer({
    this.peerId,
    this.ip,
    this.port,
    this.bitfield,
    this.amChoking,
    this.peerChoking,
    this.downloadSpeed,
    this.uploadSpeed,
    this.seeder,
  }) : client = getClient(peerId);

  factory Peer.fromJson(Map<String, dynamic> json) => _$PeerFromJson(json);

  Map<String?, dynamic> toJson() => _$PeerToJson(this);

  static String getClient(String? peerId) {
    if (peerId == null) {
      return "";
    }
    final realPeerId = decodePercentEncodedString(peerId);
    Map<String, dynamic>? result =
        PeerIdParser.instance.parsePeerId(realPeerId);
    if (result == null) {
      return "";
    }
    return "${result["client"]} ${result["version"]}";
  }

  static String decodePercentEncodedString(String s) {
    var ret = '';

    for (var i = 0; i < s.length; i++) {
      var ch = s[i];

      if (ch == '%' && i < s.length - 2) {
        var code = s.substring(i + 1, i + 3);
        ret += String.fromCharCode(int.parse(code, radix: 16));
        i += 2;
      } else {
        ret += ch;
      }
    }

    return ret;
  }
}
