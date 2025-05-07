// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VariantVOAdapter extends TypeAdapter<VariantVO> {
  @override
  final int typeId = 7;

  @override
  VariantVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VariantVO(
      id: fields[0] as int?,
      productId: fields[1] as int?,
      sku: fields[2] as String?,
      price: fields[3] as int?,
      dealerLevel1Price: fields[4] as String?,
      dealerLevel2Price: fields[5] as String?,
      dealerLevel3Price: fields[6] as String?,
      status: fields[7] as int?,
      updatedAt: fields[8] as String?,
      colorVO: fields[9] as ColorVO?,
      sizeVO: fields[10] as SizeVO?,
      images: (fields[11] as List).cast<ImageVO>(),
      extendedPriceVO: fields[12] as ExtendedPriceVO?,
      inventoryVO: fields[13] as InventoryVO?,
      promotionPoint: fields[14] as int?,
      redeemPoint: fields[15] as int?,
      colorName: fields[16] as String?,
      image: fields[17] as String?,
      qtyCount: fields[18] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, VariantVO obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.sku)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.dealerLevel1Price)
      ..writeByte(5)
      ..write(obj.dealerLevel2Price)
      ..writeByte(6)
      ..write(obj.dealerLevel3Price)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.colorVO)
      ..writeByte(10)
      ..write(obj.sizeVO)
      ..writeByte(11)
      ..write(obj.images)
      ..writeByte(12)
      ..write(obj.extendedPriceVO)
      ..writeByte(13)
      ..write(obj.inventoryVO)
      ..writeByte(14)
      ..write(obj.promotionPoint)
      ..writeByte(15)
      ..write(obj.redeemPoint)
      ..writeByte(16)
      ..write(obj.colorName)
      ..writeByte(17)
      ..write(obj.image)
      ..writeByte(18)
      ..write(obj.qtyCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VariantVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantVO _$VariantVOFromJson(Map<String, dynamic> json) => VariantVO(
      id: (json['id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      sku: json['SKU'] as String?,
      price: (json['price'] as num?)?.toInt(),
      dealerLevel1Price: json['dealer_level_1_price'] as String?,
      dealerLevel2Price: json['dealer_level_2_price'] as String?,
      dealerLevel3Price: json['dealer_level_3_price'] as String?,
      status: (json['status'] as num?)?.toInt(),
      updatedAt: json['updated_at'] as String?,
      colorVO: json['color'] == null
          ? null
          : ColorVO.fromJson(json['color'] as Map<String, dynamic>),
      sizeVO: json['size'] == null
          ? null
          : SizeVO.fromJson(json['size'] as Map<String, dynamic>),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => ImageVO.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      extendedPriceVO: json['extended_price'] == null
          ? null
          : ExtendedPriceVO.fromJson(
              json['extended_price'] as Map<String, dynamic>),
      inventoryVO: json['inventory'] == null
          ? null
          : InventoryVO.fromJson(json['inventory'] as Map<String, dynamic>),
      promotionPoint: (json['promotion_point'] as num?)?.toInt(),
      redeemPoint: (json['redeem_point'] as num?)?.toInt(),
      colorName: json['color_name'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$VariantVOToJson(VariantVO instance) => <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'SKU': instance.sku,
      'price': instance.price,
      'dealer_level_1_price': instance.dealerLevel1Price,
      'dealer_level_2_price': instance.dealerLevel2Price,
      'dealer_level_3_price': instance.dealerLevel3Price,
      'status': instance.status,
      'updated_at': instance.updatedAt,
      'color': instance.colorVO,
      'size': instance.sizeVO,
      'images': instance.images,
      'extended_price': instance.extendedPriceVO,
      'inventory': instance.inventoryVO,
      'promotion_point': instance.promotionPoint,
      'redeem_point': instance.redeemPoint,
      'color_name': instance.colorName,
      'image': instance.image,
    };
