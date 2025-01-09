import 'package:json_annotation/json_annotation.dart';

part 'campaign_join_request.g.dart';

@JsonSerializable()
class CampaignJoinRequest {
  @JsonKey(name: "campaign_id")
  int? campaignId;

  @JsonKey(name: "user_id")
  int? userId;

  CampaignJoinRequest(this.campaignId,this.userId);

  factory CampaignJoinRequest.fromJson(Map<String, dynamic> json) =>
      _$CampaignJoinRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignJoinRequestToJson(this);
}
