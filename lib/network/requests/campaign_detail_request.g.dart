// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_detail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignDetailRequest _$CampaignDetailRequestFromJson(
        Map<String, dynamic> json) =>
    CampaignDetailRequest(
      (json['campaign_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CampaignDetailRequestToJson(
        CampaignDetailRequest instance) =>
    <String, dynamic>{
      'campaign_id': instance.campaignId,
    };
