// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BrandVOAdapter extends TypeAdapter<BrandVO> {
  @override
  final int typeId = 6;

  @override
  BrandVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrandVO(
      id: fields[0] as int?,
      nameEn: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BrandVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameEn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrandVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandVO _$BrandVOFromJson(Map<String, dynamic> json) => BrandVO(
      id: (json['id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
    );

Map<String, dynamic> _$BrandVOToJson(BrandVO instance) => <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
    };
