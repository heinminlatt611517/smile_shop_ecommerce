// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_history_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryHistoryVO _$DeliveryHistoryVOFromJson(Map<String, dynamic> json) =>
    DeliveryHistoryVO(
      id: (json['id'] as num?)?.toInt(),
      orderId: json['order_id'] as String?,
      deliveryDate: json['delivery_date'] as String?,
      deliveryStatus: json['delivery_status'] as String?,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$DeliveryHistoryVOToJson(DeliveryHistoryVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'order_id': instance.orderId,
      'delivery_date': instance.deliveryDate,
      'delivery_status': instance.deliveryStatus,
      'comment': instance.comment,
    };
