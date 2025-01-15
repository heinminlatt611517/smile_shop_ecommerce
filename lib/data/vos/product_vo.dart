import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/brand_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/data/vos/variant_vo.dart';

import '../../persistence/hive_constants.dart';

part 'product_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeProductVO, adapterName: kAdapterProductVO)
class ProductVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  final int? id;

  @JsonKey(name: 'name')
  @HiveField(1)
  final String? name;

  @JsonKey(name: 'sku')
  @HiveField(2)
  final String? sku;

  @JsonKey(name: 'highlight')
  @HiveField(3)
  final String? highlight;

  @JsonKey(name: 'description')
  @HiveField(4)
  final String? description;

  @JsonKey(name: 'price')
  @HiveField(5)
  final int? price;

  @JsonKey(name: 'brand_id')
  @HiveField(6)
  final int? brandId;

  @JsonKey(name: 'rating')
  @HiveField(7)
  final int? rating;

  @JsonKey(name: 'subcategory_id')
  @HiveField(8)
  final int? subcategoryId;

  @JsonKey(name: 'image')
  @HiveField(9)
  final String? image;

  @JsonKey(name: 'images')
  @HiveField(10)
  final List<String>? images;

  @JsonKey(name: 'subcategory')
  @HiveField(11)
  final SubcategoryVO? subcategory;

  @JsonKey(name: 'brand')
  @HiveField(12)
  final BrandVO? brand;

  @JsonKey(name: 'variant')
  @HiveField(13)
  final List<VariantVO>? variantVO;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(14)
  int? qtyCount;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(15)
  bool? isChecked;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(16)
  int? totalPrice;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(17)
  String? colorName;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(18)
  bool? isFavourite;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(19)
  bool? isAddedToCartProduct;

  @JsonKey(includeFromJson: false, includeToJson: false)
  @HiveField(20)
  String? size;

  ProductVO(
      {this.id,
      this.name,
      this.sku,
      this.price,
      this.brandId,
      this.subcategoryId,
      this.image,
      this.subcategory,
      this.brand,
      this.variantVO,
      this.images,
      this.rating,
      this.description,
      this.highlight,
      this.qtyCount,
      this.isChecked = false,
      this.totalPrice,
      this.colorName,
      this.isFavourite = false,
        this.size
     });

  factory ProductVO.fromJson(Map<String, dynamic> json) =>
      _$ProductVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVOToJson(this);

  // CopyWith method for immutability
  ProductVO copyWith({
    int? id,
    String? name,
    String? sku,
    int? price,
    int? brandId,
    int? subcategoryId,
    String? image,
    SubcategoryVO? subcategory,
    BrandVO? brand,
    List<VariantVO>? variantVO,
    List<String>? images,
    int? rating,
    String? description,
    String? highlight,
    int? qtyCount,
    bool? isChecked,
    int? totalPrice,
    String? colorName,
    bool? isFavourite,
    String? size,
  }) {
    return ProductVO(
      id: id ?? this.id,
      name: name ?? this.name,
      sku: sku ?? this.sku,
      price: price ?? this.price,
      brandId: brandId ?? this.brandId,
      subcategoryId: subcategoryId ?? this.subcategoryId,
      image: image ?? this.image,
      subcategory: subcategory ?? this.subcategory,
      brand: brand ?? this.brand,
      variantVO: variantVO ?? this.variantVO,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      description: description ?? this.description,
      highlight: highlight ?? this.highlight,
      qtyCount: qtyCount ?? this.qtyCount,
      isChecked: isChecked ?? this.isChecked,
      totalPrice: totalPrice ?? this.totalPrice,
      colorName: colorName ?? this.colorName,
      isFavourite: isFavourite ?? this.isFavourite,
      size: size ?? this.size,
    );
  }
}
