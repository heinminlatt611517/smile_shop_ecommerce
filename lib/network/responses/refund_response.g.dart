// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refund_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefundResponse _$RefundResponseFromJson(Map<String, dynamic> json) =>
    RefundResponse(
      status: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => RefundVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RefundResponseToJson(RefundResponse instance) =>
    <String, dynamic>{
      'status_code': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
