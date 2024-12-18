import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/brand_vo.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';
import 'package:smile_shop/data/vos/variant_vo.dart';

part 'product_vo.g.dart';

@JsonSerializable()
class ProductVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'sku')
  final String? sku;

  @JsonKey(name: 'highlight')
  final String? highlight;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'price')
  final String? price;

  @JsonKey(name: 'brand_id')
  final String? brandId;

  @JsonKey(name: 'rating')
  final int? rating;

  @JsonKey(name: 'subcategory_id')
  final String? subcategoryId;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'images')
  final List<String>? images;

  @JsonKey(name: 'subcategory')
  final SubcategoryVO? subcategory;

  @JsonKey(name: 'brand')
  final BrandVO? brand;

  @JsonKey(name: 'variant')
  final List<VariantVO>? variantVO;

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
      this.highlight});

  factory ProductVO.fromJson(Map<String, dynamic> json) =>
      _$ProductVOFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVOToJson(this);
}
