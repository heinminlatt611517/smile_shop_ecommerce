import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'size_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeSizeVO, adapterName: kAdapterSizeVO)
class SizeVO {
  @JsonKey(name: 'varient_product_id')
  @HiveField(0)
  final int? variantProductId;

  @JsonKey(name: 'value')
  @HiveField(1)
  final String? value;

  SizeVO({this.variantProductId, this.value});

  factory SizeVO.fromJson(Map<String, dynamic> json) => _$SizeVOFromJson(json);

  Map<String, dynamic> toJson() => _$SizeVOToJson(this);
}