import 'package:json_annotation/json_annotation.dart';

part 'campaign_detail_request.g.dart';

@JsonSerializable()
class CampaignDetailRequest {
  @JsonKey(name: "campaign_id")
  int? campaignId;

  CampaignDetailRequest(this.campaignId);

  factory CampaignDetailRequest.fromJson(Map<String, dynamic> json) =>
      _$CampaignDetailRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignDetailRequestToJson(this);
}
