import 'package:json_annotation/json_annotation.dart';

part 'color_vo.g.dart';

@JsonSerializable()
class ColorVO {
  @JsonKey(name: 'varient_product_id')
  final String? variantProductId;

  @JsonKey(name: 'value')
  final String? value;

  ColorVO({this.variantProductId, this.value});

  factory ColorVO.fromJson(Map<String, dynamic> json) =>
      _$ColorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ColorVOToJson(this);
}