// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'campaign_participant_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampaignParticipantVo _$CampaignParticipantVoFromJson(
        Map<String, dynamic> json) =>
    CampaignParticipantVo(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      userPhoto: json['user_photo'] as String?,
      profileImage: json['profile_image'] as String?,
    );

Map<String, dynamic> _$CampaignParticipantVoToJson(
        CampaignParticipantVo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'user_photo': instance.userPhoto,
      'profile_image': instance.profileImage,
    };
