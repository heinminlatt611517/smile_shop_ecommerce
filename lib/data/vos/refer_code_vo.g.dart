// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refer_code_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReferVOAdapter extends TypeAdapter<ReferCodeVO> {
  @override
  final int typeId = 13;

  @override
  ReferCodeVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReferCodeVO(
      id: fields[0] as int?,
      code: fields[1] as String?,
      userId: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ReferCodeVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReferVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReferCodeVO _$ReferCodeVOFromJson(Map<String, dynamic> json) => ReferCodeVO(
      id: (json['id'] as num?)?.toInt(),
      code: json['code'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ReferCodeVOToJson(ReferCodeVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'user_id': instance.userId,
    };
