import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/sub_category_vo.dart';

import '../../persistence/hive_constants.dart';

part 'category_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeCategoryVO, adapterName: kAdapterCategoryVO)
class CategoryVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  final int? id;

  @JsonKey(name: 'name')
  @HiveField(1)
  final String? name;

  @JsonKey(name: 'subcategory')
  @HiveField(2)
  final List<SubcategoryVO>? subCategories;

  CategoryVO({this.id, this.name,this.subCategories});

  factory CategoryVO.fromJson(Map<String, dynamic> json) =>
      _$CategoryVOFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryVOToJson(this);
}