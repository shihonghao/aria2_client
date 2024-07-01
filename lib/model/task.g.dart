// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      gid: json['gid'] as String,
      status: $enumDecode(_$TaskStatusEnumMap, json['status']),
      totalLength: _$JsonConverterFromJson<String, int>(
          json['totalLength'], const StringToIntegerConverter().fromJson),
      completedLength: _$JsonConverterFromJson<String, int>(
          json['completedLength'], const StringToIntegerConverter().fromJson),
      uploadLength: _$JsonConverterFromJson<String, int>(
          json['uploadLength'], const StringToIntegerConverter().fromJson),
      bitfield: json['bitfield'] as String?,
      downloadSpeed: _$JsonConverterFromJson<String, int>(json['downloadSpeed'],
              const StringToIntegerConverter().fromJson) ??
          0,
      uploadSpeed: _$JsonConverterFromJson<String, int>(
              json['uploadSpeed'], const StringToIntegerConverter().fromJson) ??
          0,
      infoHash: json['infoHash'] as String?,
      numSeeders: _$JsonConverterFromJson<String, int>(
          json['numSeeders'], const StringToIntegerConverter().fromJson),
      seeder: _$JsonConverterFromJson<String, bool>(
          json['seeder'], const StringToBoolConverter().fromJson),
      pieceLength: _$JsonConverterFromJson<String, int>(
          json['pieceLength'], const StringToIntegerConverter().fromJson),
      numPieces: _$JsonConverterFromJson<String, int>(
          json['numPieces'], const StringToIntegerConverter().fromJson),
      connections: _$JsonConverterFromJson<String, int>(
          json['connections'], const StringToIntegerConverter().fromJson),
      errorCode: _$JsonConverterFromJson<String, int>(
          json['errorCode'], const StringToIntegerConverter().fromJson),
      errorMessage: json['errorMessage'] as String?,
      followedBy: json['followedBy'] as String?,
      following: json['following'] as String?,
      belongsTo: json['belongsTo'] as String?,
      dir: json['dir'] as String?,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => TaskFile.fromJson(e as Map<String, dynamic>))
          .toList(),
      verifiedLength: json['verifiedLength'] as String?,
      verifyIntegrityPending: json['verifyIntegrityPending'] as String?,
    )
      ..taskName = json['taskName'] as String?
      ..lastCompletedLength = _$JsonConverterFromJson<String, int>(
          json['lastCompletedLength'],
          const StringToIntegerConverter().fromJson)
      ..bittorrent = json['bittorrent'] == null
          ? null
          : Bittorrent.fromJson(json['bittorrent'] as Map<String, dynamic>);

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'gid': instance.gid,
      'taskName': instance.taskName,
      'status': _$TaskStatusEnumMap[instance.status]!,
      'totalLength': _$JsonConverterToJson<String, int>(
          instance.totalLength, const StringToIntegerConverter().toJson),
      'completedLength': _$JsonConverterToJson<String, int>(
          instance.completedLength, const StringToIntegerConverter().toJson),
      'lastCompletedLength': _$JsonConverterToJson<String, int>(
          instance.lastCompletedLength,
          const StringToIntegerConverter().toJson),
      'uploadLength': _$JsonConverterToJson<String, int>(
          instance.uploadLength, const StringToIntegerConverter().toJson),
      'bitfield': instance.bitfield,
      'downloadSpeed': _$JsonConverterToJson<String, int>(
          instance.downloadSpeed, const StringToIntegerConverter().toJson),
      'uploadSpeed': _$JsonConverterToJson<String, int>(
          instance.uploadSpeed, const StringToIntegerConverter().toJson),
      'infoHash': instance.infoHash,
      'numSeeders': _$JsonConverterToJson<String, int>(
          instance.numSeeders, const StringToIntegerConverter().toJson),
      'seeder': _$JsonConverterToJson<String, bool>(
          instance.seeder, const StringToBoolConverter().toJson),
      'pieceLength': _$JsonConverterToJson<String, int>(
          instance.pieceLength, const StringToIntegerConverter().toJson),
      'numPieces': _$JsonConverterToJson<String, int>(
          instance.numPieces, const StringToIntegerConverter().toJson),
      'connections': _$JsonConverterToJson<String, int>(
          instance.connections, const StringToIntegerConverter().toJson),
      'errorCode': _$JsonConverterToJson<String, int>(
          instance.errorCode, const StringToIntegerConverter().toJson),
      'errorMessage': instance.errorMessage,
      'followedBy': instance.followedBy,
      'following': instance.following,
      'belongsTo': instance.belongsTo,
      'dir': instance.dir,
      'files': instance.files?.map((e) => e.toJson()).toList(),
      'bittorrent': instance.bittorrent?.toJson(),
      'verifiedLength': instance.verifiedLength,
      'verifyIntegrityPending': instance.verifyIntegrityPending,
    };

const _$TaskStatusEnumMap = {
  TaskStatus.active: 'active',
  TaskStatus.waiting: 'waiting',
  TaskStatus.paused: 'paused',
  TaskStatus.error: 'error',
  TaskStatus.complete: 'complete',
  TaskStatus.removed: 'removed',
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

TaskFile _$TaskFileFromJson(Map<String, dynamic> json) => TaskFile(
      completedLength: _$JsonConverterFromJson<String, int>(
          json['completedLength'], const StringToIntegerConverter().fromJson),
      index: _$JsonConverterFromJson<String, int>(
          json['index'], const StringToIntegerConverter().fromJson),
      length: _$JsonConverterFromJson<String, int>(
          json['length'], const StringToIntegerConverter().fromJson),
      selected: _$JsonConverterFromJson<String, bool>(
          json['selected'], const StringToBoolConverter().fromJson),
      uris: (json['uris'] as List<dynamic>?)
          ?.map((e) => TaskUri.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String?,
    );

Map<String, dynamic> _$TaskFileToJson(TaskFile instance) => <String, dynamic>{
      'completedLength': _$JsonConverterToJson<String, int>(
          instance.completedLength, const StringToIntegerConverter().toJson),
      'index': _$JsonConverterToJson<String, int>(
          instance.index, const StringToIntegerConverter().toJson),
      'length': _$JsonConverterToJson<String, int>(
          instance.length, const StringToIntegerConverter().toJson),
      'selected': _$JsonConverterToJson<String, bool>(
          instance.selected, const StringToBoolConverter().toJson),
      'uris': instance.uris,
      'path': instance.path,
    };

TaskUri _$TaskUriFromJson(Map<String, dynamic> json) => TaskUri(
      uri: json['uri'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$TaskUriToJson(TaskUri instance) => <String, dynamic>{
      'uri': instance.uri,
      'status': instance.status,
    };

Bittorrent _$BittorrentFromJson(Map<String, dynamic> json) => Bittorrent(
      announceList: (json['announceList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      comment: json['comment'] as String?,
      creationDate: json['creationDate'] as String?,
      mode: json['mode'] as String?,
      info: json['info'] == null
          ? null
          : BittorrentInfo.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BittorrentToJson(Bittorrent instance) =>
    <String, dynamic>{
      'announceList': instance.announceList,
      'comment': instance.comment,
      'creationDate': instance.creationDate,
      'mode': instance.mode,
      'info': instance.info,
    };

BittorrentInfo _$BittorrentInfoFromJson(Map<String, dynamic> json) =>
    BittorrentInfo(
      name: json['name'] as String?,
    );

Map<String, dynamic> _$BittorrentInfoToJson(BittorrentInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
