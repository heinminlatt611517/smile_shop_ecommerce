// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extended_price_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExtendedPriceVOAdapter extends TypeAdapter<ExtendedPriceVO> {
  @override
  final int typeId = 11;

  @override
  ExtendedPriceVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExtendedPriceVO(
      id: fields[0] as int?,
      variantProductId: fields[1] as int?,
      redeemPoint: fields[2] as String?,
      memberPrice: fields[3] as String?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExtendedPriceVO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.variantProductId)
      ..writeByte(2)
      ..write(obj.redeemPoint)
      ..writeByte(3)
      ..write(obj.memberPrice)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExtendedPriceVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendedPriceVO _$ExtendedPriceVOFromJson(Map<String, dynamic> json) =>
    ExtendedPriceVO(
      id: (json['id'] as num?)?.toInt(),
      variantProductId: (json['variant_product_id'] as num?)?.toInt(),
      redeemPoint: json['redeem_point'] as String?,
      memberPrice: json['member_price'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ExtendedPriceVOToJson(ExtendedPriceVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'variant_product_id': instance.variantProductId,
      'redeem_point': instance.redeemPoint,
      'member_price': instance.memberPrice,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
