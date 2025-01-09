import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/campaign_vo.dart';

part 'campaign_response.g.dart';

@JsonSerializable()
class CampaignResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

 @JsonKey(name: "data")
 final List<CampaignVo>? data;

  CampaignResponse({
    this.status,
    this.message,
   this.data,
  });

  factory CampaignResponse.fromJson(Map<String, dynamic> json) =>
      _$CampaignResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignResponseToJson(this);
}

