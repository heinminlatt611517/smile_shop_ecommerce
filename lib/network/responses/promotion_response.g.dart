// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionResponse _$PromotionResponseFromJson(Map<String, dynamic> json) =>
    PromotionResponse(
      status: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PromotionDataVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PromotionResponseToJson(PromotionResponse instance) =>
    <String, dynamic>{
      'status_code': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
