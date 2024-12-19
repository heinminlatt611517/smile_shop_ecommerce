import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/category_vo.dart';

part 'sub_category_vo.g.dart';

@JsonSerializable()
class SubcategoryVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'category_id')
  final String? categoryId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'category')
  final CategoryVO? category;

  @JsonKey(name: 'image')
  final String? image;


  SubcategoryVO({
    this.id,
    this.categoryId,
    this.name,
    this.category,
    this.image
  });

  factory SubcategoryVO.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryVOFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryVOToJson(this);
}
