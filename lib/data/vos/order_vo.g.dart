// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderVO _$OrderVOFromJson(Map<String, dynamic> json) => OrderVO(
      id: (json['id'] as num?)?.toInt(),
      headId: (json['head_id'] as num?)?.toInt(),
      enduserId: (json['enduser_id'] as num?)?.toInt(),
      orderNo: json['order_no'] as String?,
      subtotal: json['subtotal'] as String?,
      paymentType: json['payment_type'] as String?,
      paymentStatus: json['payment_status'] as String?,
      userType: json['user_type'] as String?,
      enduserAddressId: (json['enduser_address_id'] as num?)?.toInt(),
      deliveryStatus: json['delivery_status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      image: json['image'] as String?,
      addressVO: json['address'] == null
          ? null
          : AddressVO.fromJson(json['address'] as Map<String, dynamic>),
      orderProducts: (json['order_products'] as List<dynamic>?)
          ?.map((e) => OrderProductVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryHistory: (json['delivery_histories'] as List<dynamic>?)
          ?.map((e) => DeliveryHistoryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      deliveryType: json['delivery_type'] as String?,
      deliveryFee: (json['delivery_fees'] as num?)?.toInt(),
      couponDiscountAmount: json['coupon_discount_amount'] as String?,
      usedPoints: (json['used_points'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OrderVOToJson(OrderVO instance) => <String, dynamic>{
      'id': instance.id,
      'head_id': instance.headId,
      'enduser_id': instance.enduserId,
      'order_no': instance.orderNo,
      'subtotal': instance.subtotal,
      'payment_type': instance.paymentType,
      'payment_status': instance.paymentStatus,
      'user_type': instance.userType,
      'enduser_address_id': instance.enduserAddressId,
      'delivery_status': instance.deliveryStatus,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'image': instance.image,
      'address': instance.addressVO,
      'order_products': instance.orderProducts,
      'delivery_histories': instance.deliveryHistory,
      'delivery_type': instance.deliveryType,
      'delivery_fees': instance.deliveryFee,
      'coupon_discount_amount': instance.couponDiscountAmount,
      'used_points': instance.usedPoints,
    };
