// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_reason_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundReasonResponse _$RefundReasonResponseFromJson(
        Map<String, dynamic> json) =>
    RefundReasonResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => RefundReasonVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RefundReasonResponseToJson(
        RefundReasonResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
