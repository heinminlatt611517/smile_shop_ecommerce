// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_reason_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundReasonVO _$RefundReasonVOFromJson(Map<String, dynamic> json) =>
    RefundReasonVO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$RefundReasonVOToJson(RefundReasonVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
