import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/color_vo.dart';
import 'package:smile_shop/data/vos/extended_price_vo.dart';
import 'package:smile_shop/data/vos/image_vo.dart';
import 'package:smile_shop/data/vos/inventory_vo.dart';
import 'package:smile_shop/data/vos/size_vo.dart';

import '../../persistence/hive_constants.dart';

part 'variant_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeVariantVO, adapterName: kAdapterVariantVO)
class VariantVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  final int? id;

  @JsonKey(name: 'product_id')
  @HiveField(1)
  final int? productId;

  @JsonKey(name: 'SKU')
  @HiveField(2)
  final String? sku;

  @JsonKey(name: 'price')
  @HiveField(3)
  final int? price;

  @JsonKey(name: 'dealer_level_1_price')
  @HiveField(4)
  final String? dealerLevel1Price;

  @JsonKey(name: 'dealer_level_2_price')
  @HiveField(5)
  final String? dealerLevel2Price;

  @JsonKey(name: 'dealer_level_3_price')
  @HiveField(6)
  final String? dealerLevel3Price;

  @JsonKey(name: 'status')
  @HiveField(7)
  final int? status;

  @JsonKey(name: 'updated_at')
  @HiveField(8)
  final String? updatedAt;

  @JsonKey(name: 'color')
  @HiveField(9)
  final ColorVO? colorVO;

  @JsonKey(name: 'size')
  @HiveField(10)
  final SizeVO? sizeVO;

  @JsonKey(name: 'images')
  @HiveField(11)
  final List<ImageVO> images;

  @JsonKey(name: 'extended_price')
  @HiveField(12)
  final ExtendedPriceVO? extendedPriceVO;

  @JsonKey(name: 'inventory')
  @HiveField(13)
  final InventoryVO? inventoryVO;

  @JsonKey(name: 'promotion_point')
  @HiveField(14)
  final int? promotionPoint;

  @JsonKey(name: 'redeem_point')
  @HiveField(15)
  final int? redeemPoint;

  @JsonKey(name: 'color_name')
  @HiveField(16)
  final String? colorName;

  @JsonKey(name: 'image')
  @HiveField(17)
  final String? image;

  VariantVO({
    this.id,
    this.productId,
    this.sku,
    this.price,
    this.dealerLevel1Price,
    this.dealerLevel2Price,
    this.dealerLevel3Price,
    this.status,
    this.updatedAt,
    this.colorVO,
    this.sizeVO,
    this.images = const [],
    this.extendedPriceVO,
    this.inventoryVO,
    this.promotionPoint,
    this.redeemPoint,
    this.colorName,
    this.image
  });

  factory VariantVO.fromJson(Map<String, dynamic> json) =>
      _$VariantVOFromJson(json);

  Map<String, dynamic> toJson() => _$VariantVOToJson(this);
}
