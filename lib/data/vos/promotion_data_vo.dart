import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/promotion_vo.dart';

part 'promotion_data_vo.g.dart';

@JsonSerializable()
class PromotionDataVO {
  @JsonKey(name: "current_point")
  final int? currentPoint;

  @JsonKey(name: "logs")
  final List<PromotionVO>? promotions;

  PromotionDataVO({
     this.currentPoint,
     this.promotions,
  });


  factory PromotionDataVO.fromJson(Map<String, dynamic> json) =>
      _$PromotionDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionDataVOToJson(this);
}
