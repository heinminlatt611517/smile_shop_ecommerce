import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';

part 'brand_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeBrandVO, adapterName: kAdapterBrandVO)
class BrandVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  final int? id;

  @JsonKey(name: 'name_en')
  @HiveField(1)
  final String? nameEn;

  BrandVO({this.id, this.nameEn});

  factory BrandVO.fromJson(Map<String, dynamic> json) =>
      _$BrandVOFromJson(json);

  Map<String, dynamic> toJson() => _$BrandVOToJson(this);
}