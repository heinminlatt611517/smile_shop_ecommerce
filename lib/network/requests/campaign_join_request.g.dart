// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_join_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignJoinRequest _$CampaignJoinRequestFromJson(Map<String, dynamic> json) =>
    CampaignJoinRequest(
      (json['campaign_id'] as num?)?.toInt(),
      (json['user_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CampaignJoinRequestToJson(
        CampaignJoinRequest instance) =>
    <String, dynamic>{
      'campaign_id': instance.campaignId,
      'user_id': instance.userId,
    };
