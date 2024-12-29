import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/category_vo.dart';

import '../../persistence/hive_constants.dart';

part 'sub_category_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeSubCategoryVO, adapterName: kAdapterSubcategoryVO)
class SubcategoryVO {
  @JsonKey(name: "id")
  @HiveField(0)
  final int? id;

  @JsonKey(name: "category_id")
  @HiveField(1)
  final int? categoryId;

  @JsonKey(name: "name")
  @HiveField(2)
  final String? name;

  @JsonKey(name: "image")
  @HiveField(3)
  final String? image;

  @JsonKey(name: "category")
  @HiveField(4)
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
