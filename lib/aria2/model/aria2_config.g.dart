// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aria2_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aria2Config _$Aria2ConfigFromJson(Map<String, dynamic> json) => Aria2Config(
      name: json['name'] as String,
      protocol: json['protocol'] as String? ?? Aria2Constants.PROTOCOL_HTTP,
      domain: json['domain'] as String? ?? "127.0.0.1",
      port: (json['port'] as num?)?.toInt() ?? 6800,
      secret: json['secret'] as String?,
      path: json['path'] as String? ?? "/jsonrpc",
      isDefault: json['isDefault'] ?? false,
    )..uri = Uri.parse(json['uri'] as String);

Map<String, dynamic> _$Aria2ConfigToJson(Aria2Config instance) =>
    <String, dynamic>{
      'name': instance.name,
      'protocol': instance.protocol,
      'domain': instance.domain,
      'port': instance.port,
      'secret': instance.secret,
      'path': instance.path,
      'uri': instance.uri.toString(),
      'isDefault': instance.isDefault,
    };
