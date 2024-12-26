// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_variant_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderVariantVO _$OrderVariantVOFromJson(Map<String, dynamic> json) =>
    OrderVariantVO(
      variantProductId: (json['variant_product_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      variantAttributeValueId:
          (json['variant_attribute_value_id'] as num?)?.toInt(),
      qty: (json['qty'] as num?)?.toInt(),
      colorName: json['color_name'] as String?,
    );

Map<String, dynamic> _$OrderVariantVOToJson(OrderVariantVO instance) =>
    <String, dynamic>{
      'variant_product_id': instance.variantProductId,
      'product_id': instance.productId,
      'variant_attribute_value_id': instance.variantAttributeValueId,
      'qty': instance.qty,
      'color_name': instance.colorName,
    };
