import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/color_vo.dart';
import 'package:smile_shop/data/vos/extended_price_vo.dart';
import 'package:smile_shop/data/vos/inventory_vo.dart';
import 'package:smile_shop/data/vos/size_vo.dart';

part 'variant_vo.g.dart';

@JsonSerializable()
class VariantVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'product_id')
  final String? productId;

  @JsonKey(name: 'SKU')
  final String? sku;

  @JsonKey(name: 'price')
  final String? price;

  @JsonKey(name: 'dealer_level_1_price')
  final String? dealerLevel1Price;

  @JsonKey(name: 'dealer_level_2_price')
  final String? dealerLevel2Price;

  @JsonKey(name: 'dealer_level_3_price')
  final String? dealerLevel3Price;

  @JsonKey(name: 'status')
  final int? status;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'color')
  final ColorVO? colorVO;

  @JsonKey(name: 'size')
  final SizeVO? sizeVO;

  @JsonKey(name: 'images')
  final List<String> images;

  @JsonKey(name: 'extended_price')
  final ExtendedPriceVO? extendedPriceVO;

  @JsonKey(name: 'inventory')
  final InventoryVO? inventoryVO;

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
  });

  factory VariantVO.fromJson(Map<String, dynamic> json) =>
      _$VariantVOFromJson(json);

  Map<String, dynamic> toJson() => _$VariantVOToJson(this);
}
