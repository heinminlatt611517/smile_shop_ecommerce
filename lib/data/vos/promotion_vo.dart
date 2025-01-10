import 'package:json_annotation/json_annotation.dart';

part 'promotion_vo.g.dart';

@JsonSerializable()
class PromotionVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "user_id")
  final int? userId;

  @JsonKey(name: "amount")
  final double? amount;

  @JsonKey(name: "type")
  final String? type;


  PromotionVO({
     this.id,
     this.userId,
     this.amount,
     this.type,
  });


  factory PromotionVO.fromJson(Map<String, dynamic> json) =>
      _$PromotionVOFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionVOToJson(this);
}
