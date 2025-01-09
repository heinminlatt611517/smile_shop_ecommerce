// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignDetailResponse _$CampaignDetailResponseFromJson(
        Map<String, dynamic> json) =>
    CampaignDetailResponse(
      status: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CampaignVo.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CampaignDetailResponseToJson(
        CampaignDetailResponse instance) =>
    <String, dynamic>{
      'status_code': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
