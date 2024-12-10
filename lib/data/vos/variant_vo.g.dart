// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VariantVO _$VariantVOFromJson(Map<String, dynamic> json) => VariantVO(
      id: (json['id'] as num?)?.toInt(),
      productId: json['product_id'] as String?,
      sku: json['SKU'] as String?,
      price: json['price'] as String?,
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
              ?.map((e) => e as String)
              .toList() ??
          const [],
      extendedPriceVO: json['extended_price'] == null
          ? null
          : ExtendedPriceVO.fromJson(
              json['extended_price'] as Map<String, dynamic>),
      inventoryVO: json['inventory'] == null
          ? null
          : InventoryVO.fromJson(json['inventory'] as Map<String, dynamic>),
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
    };
