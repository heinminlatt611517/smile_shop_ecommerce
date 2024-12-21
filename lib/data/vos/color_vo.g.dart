// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ColorVOAdapter extends TypeAdapter<ColorVO> {
  @override
  final int typeId = 8;

  @override
  ColorVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ColorVO(
      variantProductId: fields[0] as int?,
      value: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ColorVO obj) {
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
      other is ColorVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColorVO _$ColorVOFromJson(Map<String, dynamic> json) => ColorVO(
      variantProductId: (json['varient_product_id'] as num?)?.toInt(),
      value: json['value'] as String?,
    );

Map<String, dynamic> _$ColorVOToJson(ColorVO instance) => <String, dynamic>{
      'varient_product_id': instance.variantProductId,
      'value': instance.value,
    };
