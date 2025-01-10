// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundVO _$RefundVOFromJson(Map<String, dynamic> json) => RefundVO(
      image: json['image'] as String?,
      name: json['name'] as String?,
      total: (json['total'] as num?)?.toInt(),
      status: json['status'] as String?,
      qty: (json['qty'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RefundVOToJson(RefundVO instance) => <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
      'total': instance.total,
      'status': instance.status,
      'qty': instance.qty,
    };
