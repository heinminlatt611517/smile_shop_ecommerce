import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'extended_price_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeExtendedPriceVO, adapterName: kAdapterExtendedVO)
class ExtendedPriceVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  final int? id;

  @JsonKey(name: 'variant_product_id')
  @HiveField(1)
  final int? variantProductId;

  @JsonKey(name: 'redeem_point')
  @HiveField(2)
  final String? redeemPoint;

  @JsonKey(name: 'member_price')
  @HiveField(3)
  final String? memberPrice;

  @JsonKey(name: 'created_at')
  @HiveField(4)
  final String? createdAt;

  @JsonKey(name: 'updated_at')
  @HiveField(5)
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