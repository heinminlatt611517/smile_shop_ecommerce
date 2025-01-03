// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessPaymentResponse _$SuccessPaymentResponseFromJson(
        Map<String, dynamic> json) =>
    SuccessPaymentResponse(
      statusCode: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PaymentDataVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SuccessPaymentResponseToJson(
        SuccessPaymentResponse instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
