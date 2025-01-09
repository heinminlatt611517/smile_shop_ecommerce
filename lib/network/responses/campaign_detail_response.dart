import 'package:json_annotation/json_annotation.dart';

import '../../data/vos/campaign_vo.dart';

part 'campaign_detail_response.g.dart';

@JsonSerializable()
class CampaignDetailResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final CampaignVo? data;

  CampaignDetailResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CampaignDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CampaignDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignDetailResponseToJson(this);
}

