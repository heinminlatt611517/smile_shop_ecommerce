// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SizeVOAdapter extends TypeAdapter<SizeVO> {
  @override
  final int typeId = 9;

  @override
  SizeVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SizeVO(
      variantProductId: fields[0] as int?,
      value: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SizeVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.variantProductId)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SizeVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeVO _$SizeVOFromJson(Map<String, dynamic> json) => SizeVO(
      variantProductId: (json['varient_product_id'] as num?)?.toInt(),
      value: json['value'] as String?,
    );

Map<String, dynamic> _$SizeVOToJson(SizeVO instance) => <String, dynamic>{
      'varient_product_id': instance.variantProductId,
      'value': instance.value,
    };
