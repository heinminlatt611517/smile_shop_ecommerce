// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(18)
  int? qtyCount;

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
    this.image,
    this.qtyCount,
  });

  factory VariantVO.fromJson(Map<String, dynamic> json) =>
      _$VariantVOFromJson(json);

  Map<String, dynamic> toJson() => _$VariantVOToJson(this);

  VariantVO copyWith({
    int? id,
    int? productId,
    String? sku,
    int? price,
    String? dealerLevel1Price,
    String? dealerLevel2Price,
    String? dealerLevel3Price,
    int? status,
    String? updatedAt,
    ColorVO? colorVO,
    SizeVO? sizeVO,
    List<ImageVO>? images,
    ExtendedPriceVO? extendedPriceVO,
    InventoryVO? inventoryVO,
    int? promotionPoint,
    int? redeemPoint,
    String? colorName,
    String? image,
    int? qtyCount,
  }) {
    return VariantVO(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      dealerLevel1Price: dealerLevel1Price ?? this.dealerLevel1Price,
      dealerLevel2Price: dealerLevel2Price ?? this.dealerLevel2Price,
      dealerLevel3Price: dealerLevel3Price ?? this.dealerLevel3Price,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
      colorVO: colorVO ?? this.colorVO,
      sizeVO: sizeVO ?? this.sizeVO,
      images: images ?? this.images,
      extendedPriceVO: extendedPriceVO ?? this.extendedPriceVO,
      inventoryVO: inventoryVO ?? this.inventoryVO,
      promotionPoint: promotionPoint ?? this.promotionPoint,
      redeemPoint: redeemPoint ?? this.redeemPoint,
      colorName: colorName ?? this.colorName,
      image: image ?? this.image,
      qtyCount: qtyCount ?? this.qtyCount,
    );
  }

  @override
  String toString() {
    return 'VariantVO(id: $id, productId: $productId, sku: $sku, price: $price, dealerLevel1Price: $dealerLevel1Price, dealerLevel2Price: $dealerLevel2Price, dealerLevel3Price: $dealerLevel3Price, status: $status, updatedAt: $updatedAt, colorVO: $colorVO, sizeVO: $sizeVO, images: $images, extendedPriceVO: $extendedPriceVO, inventoryVO: $inventoryVO, promotionPoint: $promotionPoint, redeemPoint: $redeemPoint, colorName: $colorName, image: $image, qtyCount: $qtyCount)';
  }
}
