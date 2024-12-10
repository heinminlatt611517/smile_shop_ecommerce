import 'package:json_annotation/json_annotation.dart';
part 'size_vo.g.dart';

@JsonSerializable()
class SizeVO {
  @JsonKey(name: 'varient_product_id')
  final String? variantProductId;

  @JsonKey(name: 'value')
  final String? value;

  SizeVO({this.variantProductId, this.value});

  factory SizeVO.fromJson(Map<String, dynamic> json) => _$SizeVOFromJson(json);

  Map<String, dynamic> toJson() => _$SizeVOToJson(this);
}