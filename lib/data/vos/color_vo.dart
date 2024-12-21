import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';

part 'color_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeColorVO, adapterName: kAdapterColorVO)
class ColorVO {
  @JsonKey(name: 'varient_product_id')
  @HiveField(0)
  final int? variantProductId;

  @JsonKey(name: 'value')
  @HiveField(1)
  final String? value;

  ColorVO({this.variantProductId, this.value});

  factory ColorVO.fromJson(Map<String, dynamic> json) =>
      _$ColorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ColorVOToJson(this);
}