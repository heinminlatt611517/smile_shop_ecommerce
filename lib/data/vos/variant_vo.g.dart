// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variant_vo.dart';

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
    };
