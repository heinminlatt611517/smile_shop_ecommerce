// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/campaign_vo.dart';
import 'package:smile_shop/network/responses/campaign_history_response.dart';

part 'campaign_history_vo.g.dart';

@JsonSerializable()
class CampaignHistoryVo {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'campaign_id')
  int? campaignId;

  @JsonKey(name: 'user_id')
  int? userId;

  @JsonKey(name: 'is_winner')
  bool? isWinner;

  @JsonKey(name: 'prize_rank')
  int? prizeRank;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: 'campaign')
  CampaignVo? campaign;

  @JsonKey(name: "address")
  final AddressVO? address;
  CampaignHistoryVo(
      {this.id,
      this.campaignId,
      this.userId,
      this.isWinner,
      this.prizeRank,
      this.createdAt,
      this.updatedAt,
      this.campaign,
      this.address});

  factory CampaignHistoryVo.fromJson(Map<String, dynamic> json) =>
      _$CampaignHistoryVoFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignHistoryVoToJson(this);
}
