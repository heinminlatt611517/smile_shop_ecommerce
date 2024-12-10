import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/brand_and_category_vo.dart';

part 'brands_and_categories_response.g.dart';

@JsonSerializable()
class BrandsAndCategoriesResponse {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final BrandAndCategoryVO? data;

  BrandsAndCategoriesResponse(
      {this.statusCode,
      this.message,
      this.data,
      });

  factory BrandsAndCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$BrandsAndCategoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BrandsAndCategoriesResponseToJson(this);
}
