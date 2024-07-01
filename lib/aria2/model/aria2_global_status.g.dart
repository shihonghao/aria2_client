// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aria2_global_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Aria2GlobalStatus _$Aria2GlobalStatusFromJson(Map<String, dynamic> json) =>
    Aria2GlobalStatus(
      downloadSpeed: const StringToIntegerConverter()
          .fromJson(json['downloadSpeed'] as String),
      uploadSpeed: const StringToIntegerConverter()
          .fromJson(json['uploadSpeed'] as String),
      numActive: const StringToIntegerConverter()
          .fromJson(json['numActive'] as String),
      numWaiting: const StringToIntegerConverter()
          .fromJson(json['numWaiting'] as String),
      numStopped: const StringToIntegerConverter()
          .fromJson(json['numStopped'] as String),
      numStoppedTotal: const StringToIntegerConverter()
          .fromJson(json['numStoppedTotal'] as String),
    );

Map<String, dynamic> _$Aria2GlobalStatusToJson(Aria2GlobalStatus instance) =>
    <String, dynamic>{
      'downloadSpeed':
          const StringToIntegerConverter().toJson(instance.downloadSpeed),
      'uploadSpeed':
          const StringToIntegerConverter().toJson(instance.uploadSpeed),
      'numActive': const StringToIntegerConverter().toJson(instance.numActive),
      'numWaiting':
          const StringToIntegerConverter().toJson(instance.numWaiting),
      'numStopped':
          const StringToIntegerConverter().toJson(instance.numStopped),
      'numStoppedTotal':
          const StringToIntegerConverter().toJson(instance.numStoppedTotal),
    };
