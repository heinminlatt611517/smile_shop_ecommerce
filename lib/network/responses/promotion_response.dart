import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/promotion_vo.dart';

import '../../data/vos/promotion_data_vo.dart';

part 'promotion_response.g.dart';

@JsonSerializable()
class PromotionResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final PromotionDataVO? data;

  PromotionResponse(
      {this.status,
      this.message,
      this.data,
      });

  factory PromotionResponse.fromJson(Map<String, dynamic> json) =>
      _$PromotionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionResponseToJson(this);
}
