import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/category_vo.dart';

part 'sub_category_vo.g.dart';

@JsonSerializable()
class SubcategoryVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "category_id")
  final String? categoryId;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "image")
  final String? image;

  @JsonKey(name: "category")
  final CategoryVO? category;

  SubcategoryVO({
    this.id,
    this.categoryId,
    this.name,
    this.image,
    this.category,
  });

  factory SubcategoryVO.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryVOFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryVOToJson(this);
}
