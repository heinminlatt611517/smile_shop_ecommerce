// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coupon_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponVO _$CouponVOFromJson(Map<String, dynamic> json) => CouponVO(
      id: (json['id'] as num?)?.toInt(),
      discountType: json['discount_type'] as String?,
      discountValue: json['discount_value'] as String?,
      minExpense: json['min_expense'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      couponPivotVo: json['pivot'] == null
          ? null
          : CouponPivotVo.fromJson(json['pivot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CouponVOToJson(CouponVO instance) => <String, dynamic>{
      'id': instance.id,
      'discount_type': instance.discountType,
      'discount_value': instance.discountValue,
      'min_expense': instance.minExpense,
      'name': instance.name,
      'description': instance.description,
      'pivot': instance.couponPivotVo,
    };

CouponPivotVo _$CouponPivotVoFromJson(Map<String, dynamic> json) =>
    CouponPivotVo(
      enduserId: (json['enduser_id'] as num?)?.toInt(),
      couponId: (json['coupon_id'] as num?)?.toInt(),
      isUsed: (json['is_used'] as num?)?.toInt(),
      expiredAt: json['expired_at'] as String?,
    );

Map<String, dynamic> _$CouponPivotVoToJson(CouponPivotVo instance) =>
    <String, dynamic>{
      'enduser_id': instance.enduserId,
      'coupon_id': instance.couponId,
      'is_used': instance.isUsed,
      'expired_at': instance.expiredAt,
    };
