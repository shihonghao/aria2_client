import 'package:json_annotation/json_annotation.dart';

import 'json/converter.dart';

part 'aria2_global_status.g.dart';

@JsonSerializable()
class Aria2GlobalStatus {
  @JsonKey(name: 'downloadSpeed')
  @StringToIntegerConverter()
  final int downloadSpeed;

  @JsonKey(name: 'uploadSpeed')
  @StringToIntegerConverter()
  final int uploadSpeed;

  @JsonKey(name: 'numActive')
  @StringToIntegerConverter()
  final int numActive;

  @JsonKey(name: 'numWaiting')
  @StringToIntegerConverter()
  final int numWaiting;

  @JsonKey(name: 'numStopped')
  @StringToIntegerConverter()
  final int numStopped;

  @JsonKey(name: 'numStoppedTotal')
  @StringToIntegerConverter()
  final int numStoppedTotal;

  Aria2GlobalStatus({
    required this.downloadSpeed,
    required this.uploadSpeed,
    required this.numActive,
    required this.numWaiting,
    required this.numStopped,
    required this.numStoppedTotal,
  });

  factory Aria2GlobalStatus.fromJson(Map<String, dynamic> json) =>
      _$Aria2GlobalStatusFromJson(json);

  Map<String, dynamic> toJson() => _$Aria2GlobalStatusToJson(this);
}
