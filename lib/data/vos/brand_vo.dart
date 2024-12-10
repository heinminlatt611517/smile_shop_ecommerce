import 'package:json_annotation/json_annotation.dart';

part 'brand_vo.g.dart';

@JsonSerializable()
class BrandVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'name_en')
  final String? nameEn;

  BrandVO({this.id, this.nameEn});

  factory BrandVO.fromJson(Map<String, dynamic> json) =>
      _$BrandVOFromJson(json);

  Map<String, dynamic> toJson() => _$BrandVOToJson(this);
}