// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aria2_config.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class Aria2ConfigAdapter extends TypeAdapter<Aria2Config> {
  @override
  final int typeId = 1;

  @override
  Aria2Config read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Aria2Config(
      key: fields[0] as String,
      name: fields[1] as String,
      protocol: fields[2] as String,
      domain: fields[3] as String?,
      port: fields[4] as int?,
      secret: fields[5] as String?,
      path: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Aria2Config obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.protocol)
      ..writeByte(3)
      ..write(obj.domain)
      ..writeByte(4)
      ..write(obj.port)
      ..writeByte(5)
      ..write(obj.secret)
      ..writeByte(6)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Aria2ConfigAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
