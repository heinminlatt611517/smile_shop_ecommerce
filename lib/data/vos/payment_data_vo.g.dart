// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDataVO _$PaymentDataVOFromJson(Map<String, dynamic> json) =>
    PaymentDataVO(
      response: json['response'],
      responseType: json['response_type'] as String?,
      requestStatus: json['request_status'],
      title: json['title'] as String?,
      message: json['message'] as String?,
      paymentType: json['payment_type'] as String?,
      orderId: json['order_id'] as String?,
    );

Map<String, dynamic> _$PaymentDataVOToJson(PaymentDataVO instance) =>
    <String, dynamic>{
      'response': instance.response,
      'response_type': instance.responseType,
      'request_status': instance.requestStatus,
      'title': instance.title,
      'message': instance.message,
      'payment_type': instance.paymentType,
      'order_id': instance.orderId,
    };
