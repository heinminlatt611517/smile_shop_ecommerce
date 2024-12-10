import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';

part 'category_vo.g.dart';

@JsonSerializable()
class CategoryVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'subcategory')
  final List<SubcategoryVO>? subCategories;

  CategoryVO({this.id, this.name,this.subCategories});

  factory CategoryVO.fromJson(Map<String, dynamic> json) =>
      _$CategoryVOFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryVOToJson(this);
}