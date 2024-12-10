// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extended_price_vo.dart';

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
