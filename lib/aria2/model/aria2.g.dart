// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aria2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aria2 _$Aria2FromJson(Map<String, dynamic> json) => Aria2(
      config: Aria2Config.fromJson(json['config'] as Map<String, dynamic>),
    )..serverConfig = json['serverConfig'] == null
        ? null
        : Aria2ServerConfig.fromJson(
            json['serverConfig'] as Map<String, dynamic>);

Map<String, dynamic> _$Aria2ToJson(Aria2 instance) => <String, dynamic>{
      'config': instance.config,
      'serverConfig': instance.serverConfig,
    };
