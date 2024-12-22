// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductVO _$OrderProductVOFromJson(Map<String, dynamic> json) =>
    OrderProductVO(
      id: (json['id'] as num?)?.toInt(),
      enduserId: (json['enduser_id'] as num?)?.toInt(),
      enduserOrderId: json['enduser_order_id'] as String?,
      variantProductId: (json['varient_product_id'] as num?)?.toInt(),
      variantAttributeValueId:
          (json['variant_attribute_value_id'] as num?)?.toInt(),
      productId: (json['product_id'] as num?)?.toInt(),
      color: json['color'] as String?,
      size: json['size'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
      price: json['price'] as String?,
      subtotal: json['subtotal'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      product: json['product'] == null
          ? null
          : ProductVO.fromJson(json['product'] as Map<String, dynamic>),
      productVariant: json['product_variant'] == null
          ? null
          : VariantVO.fromJson(json['product_variant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderProductVOToJson(OrderProductVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'enduser_id': instance.enduserId,
      'enduser_order_id': instance.enduserOrderId,
      'varient_product_id': instance.variantProductId,
      'variant_attribute_value_id': instance.variantAttributeValueId,
      'product_id': instance.productId,
      'color': instance.color,
      'size': instance.size,
      'qty': instance.qty,
      'price': instance.price,
      'subtotal': instance.subtotal,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'product': instance.product,
      'product_variant': instance.productVariant,
    };
