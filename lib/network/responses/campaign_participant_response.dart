import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/campaign_participant_vo.dart';

part 'campaign_participant_response.g.dart';

@JsonSerializable()
class CampaignParticipantResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<CampaignParticipantVo>? data;

  CampaignParticipantResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CampaignParticipantResponse.fromJson(Map<String, dynamic> json) =>
      _$CampaignParticipantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignParticipantResponseToJson(this);
}

