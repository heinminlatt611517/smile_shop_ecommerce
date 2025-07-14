import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/campaign_history_vo.dart';

part 'campaign_history_response.g.dart';

@JsonSerializable()
class CampaignHistoryResponse {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final List<CampaignHistoryVo>? data;

  CampaignHistoryResponse({this.statusCode, this.message, this.data});

  factory CampaignHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CampaignHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CampaignHistoryResponseToJson(this);
}

@JsonSerializable()
class AddressVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "enduser_id")
  final int? enduserId;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "address")
  final String? address;

  @JsonKey(name: "category_id")
  final int? categoryId;

  @JsonKey(name: "township_id")
  final int? townshipId;

  AddressVO({
    this.id,
    this.enduserId,
    this.name,
    this.phone,
    this.address,
    this.categoryId,
    this.townshipId,
  });

  factory AddressVO.fromJson(Map<String, dynamic> json) =>
      _$AddressVOFromJson(json);

  Map<String, dynamic> toJson() => _$AddressVOToJson(this);
}
