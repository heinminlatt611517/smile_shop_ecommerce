// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_participant_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignParticipantResponse _$CampaignParticipantResponseFromJson(
        Map<String, dynamic> json) =>
    CampaignParticipantResponse(
      status: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => CampaignParticipantVo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CampaignParticipantResponseToJson(
        CampaignParticipantResponse instance) =>
    <String, dynamic>{
      'status_code': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
