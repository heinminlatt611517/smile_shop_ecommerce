import 'package:json_annotation/json_annotation.dart';
part 'extended_price_vo.g.dart';

@JsonSerializable()
class ExtendedPriceVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'variant_product_id')
  final int? variantProductId;

  @JsonKey(name: 'redeem_point')
  final String? redeemPoint;

  @JsonKey(name: 'member_price')
  final String? memberPrice;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  ExtendedPriceVO({
    this.id,
    this.variantProductId,
    this.redeemPoint,
    this.memberPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory ExtendedPriceVO.fromJson(Map<String, dynamic> json) =>
      _$ExtendedPriceVOFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendedPriceVOToJson(this);
}