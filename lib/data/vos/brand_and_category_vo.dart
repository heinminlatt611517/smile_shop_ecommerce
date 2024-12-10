import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/brand_vo.dart';
import 'package:smile_shop/data/vos/category_vo.dart';

part 'brand_and_category_vo.g.dart';

@JsonSerializable()
class BrandAndCategoryVO {

  @JsonKey(name: "categories")
  final List<CategoryVO>? categories;

  @JsonKey(name: "errors")
  final List<BrandVO>? brands;


  BrandAndCategoryVO(
      { this.categories,
       this.brands,
       });

  factory BrandAndCategoryVO.fromJson(Map<String, dynamic> json) =>
      _$BrandAndCategoryVOFromJson(json);

  Map<String, dynamic> toJson() => _$BrandAndCategoryVOToJson(this);
}
