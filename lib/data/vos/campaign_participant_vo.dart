import 'package:json_annotation/json_annotation.dart';

part 'campaign_participant_vo.g.dart';

@JsonSerializable()
class CampaignParticipantVo {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "user_photo")
  final String? userPhoto;

  @JsonKey(name: "profile_image")
  final String? profileImage;

  CampaignParticipantVo({
    this.id,
    this.name,
    this.phone,
    this.userPhoto,
    this.profileImage,
  });

  factory CampaignParticipantVo.fromJson(Map<String, dynamic> json) =>
      _$CampaignParticipantVoFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignParticipantVoToJson(this);
}
