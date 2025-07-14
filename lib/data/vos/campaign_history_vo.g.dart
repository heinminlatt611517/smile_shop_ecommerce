// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_history_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignHistoryVo _$CampaignHistoryVoFromJson(Map<String, dynamic> json) =>
    CampaignHistoryVo(
      id: (json['id'] as num?)?.toInt(),
      campaignId: (json['campaign_id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      isWinner: json['is_winner'] as bool?,
      prizeRank: (json['prize_rank'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      campaign: json['campaign'] == null
          ? null
          : CampaignVo.fromJson(json['campaign'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : AddressVO.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CampaignHistoryVoToJson(CampaignHistoryVo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'campaign_id': instance.campaignId,
      'user_id': instance.userId,
      'is_winner': instance.isWinner,
      'prize_rank': instance.prizeRank,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'campaign': instance.campaign,
      'address': instance.address,
    };
