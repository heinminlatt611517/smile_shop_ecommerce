// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_status_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentStatusVO _$PaymentStatusVOFromJson(Map<String, dynamic> json) =>
    PaymentStatusVO()
      ..paymentStatus = json['payment_status'] as String?
      ..transactionId = json['transaction_id'] as String?;

Map<String, dynamic> _$PaymentStatusVOToJson(PaymentStatusVO instance) =>
    <String, dynamic>{
      'payment_status': instance.paymentStatus,
      'transaction_id': instance.transactionId,
    };
