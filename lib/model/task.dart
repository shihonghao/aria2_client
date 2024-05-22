import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

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

  /// 下载状态
  ///  active   当前正在下载/做种的下载
  ///  waiting  在队列中的下载；下载尚未开始
  ///  paused   暂停的下载
  ///  error    因错误而停止的下载
  ///  complete 停止并完成的下载
  ///  removed  用户移除的下载

  TaskStatus status;

  /// 下载的总长度（以字节为单位）
  final int totalLength;

  /// 下载的已完成长度（以字节为单位）
  int completedLength;

  int lastCompletedLength;

  /// 上传的长度（以字节为单位）
  int uploadLength;

  /// 下载进度的十六进制表示。最高位对应索引为 0 的片段。任何被设定的位表示已加载的片段，而未设置的位表示尚未加载和/或丢失的片段。末尾的任何溢出位被设定为零。当下载尚未开始时，此键不会包含在响应中。
  String? bitfield;

  /// 下载速度（以字节/秒为单位）
  int downloadSpeed;

  /// 上传速度（以字节/秒为单位）
  int uploadSpeed;

  /// InfoHash。仅适用于 BitTorrent。
  String? infoHash;

  /// aria2 连接的做种者数量。仅适用于 BitTorrent。
  int? numSeeders;

  /// 是否是做种者,仅适用于 BitTorrent。
  bool? seeder;

  /// 片段长度（以字节为单位）
  int? pieceLength;

  /// 片段数量
  int? numPieces;

  /// aria2 连接到的对等方/服务器数量
  int? connections;

  ///对于此项的最后一个错误代码，如果有的话。值为字符串。错误代码在 退出状态 部分中有定义。此值仅适用于已停止/已完成的下载。
  int? errorCode;

  /// 错误消息
  String? errorMessage;

  /// 生成为此下载结果的 GID 列表。
  /// 例如，当 aria2 下载一个 Metalink 文件时，会生成 Metalink 中描述的下载（参见 --follow-metalink 选项）。此值对于跟踪自动生成的下载非常有用。如果没有这样的下载，则此键不会包含在响应中
  String? followedBy;

  /// “followedBy”的反向链接。包含在“followedBy”中的下载在其 following 值中具有该对象的 GID。
  String? following;

  /// 父下载的 GID。某些下载是另一个下载的一部分。例如，如果 Metalink 中的文件具有 BitTorrent 资源，则“.torrent”文件的下载是该父项的一部分。如果此下载没有父项，则此键不会包含在响应中。
  String? belongsTo;

  /// 下载的目录
  String? dir;

  /// 下载的文件列表
  String? files;

  /// 在文件进行哈希检查时验证的字节数量。此键仅在此下载正在进行哈希检查时存在。
  String? verifiedLength;

  /// 如果此下载正在等待在队列中进行哈希检查，则为“true”。此键仅在此下载在队列中时存在
  String? verifyIntegrityPending;

  String formatBytes(int bytes) {
    String res = "0b";
    if (bytes >= 1024) {
      res = "${(bytes.toDouble() / 1024).toStringAsFixed(2)}kb";
    } else if (bytes >= 1024 * 1024) {
      res = "${(bytes.toDouble() / 1024 / 1024).toStringAsFixed(2)}mb";
    } else if (bytes >= 1024 * 1024 * 1024) {
      res = "${(bytes.toDouble() / 1024 / 1024 / 1024).toStringAsFixed(2)}gb";
    } else {
      res = "${bytes}b";
    }
    return res;
  }

  String getRemainTime() {
    String remainTime = "00:00:00";
    if (status == TaskStatus.active) {
      var seconds = totalLength ~/ downloadSpeed + 1;
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

  Task({
    required this.gid,
    required this.status,
    required this.totalLength,
    required this.completedLength,
    required this.uploadLength,
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
    this.verifiedLength,
    this.verifyIntegrityPending,
  }): lastCompletedLength = 0;

  Task.fromJson(Map<String, dynamic> json)
      : gid = json['gid'],
        status = json['status'],
        totalLength = json['totalLength'],
        completedLength = json['completedLength'],
        uploadLength = json['uploadLength'],
        bitfield = json['bitfield'],
        downloadSpeed = json['downloadSpeed'],
        uploadSpeed = json['uploadSpeed'],
        infoHash = json['infoHash'],
        numSeeders = json['numSeeders'],
        seeder = json['seeder'],
        pieceLength = json['pieceLength'],
        numPieces = json['numPieces'],
        connections = json['connections'],
        errorCode = json['errorCode'],
        errorMessage = json['errorMessage'],
        followedBy = json['followedBy'],
        following = json['following'],
        belongsTo = json['belongsTo'],
        dir = json['dir'],
        files = json['files'],
        verifiedLength = json['verifiedLength'],
        verifyIntegrityPending = json['verifyIntegrityPending'],
        lastCompletedLength = 0;
}

class TaskNotifier extends ValueNotifier<Task> {
  TaskNotifier(super.value);

  update(Task task) {
    value.lastCompletedLength = value.completedLength;
    value.completedLength = task.completedLength;
    value.uploadLength = task.uploadLength;
    value.downloadSpeed = task.downloadSpeed;
    value.uploadSpeed = task.uploadSpeed;
    value.status = task.status;
    notifyListeners();
  }

}
