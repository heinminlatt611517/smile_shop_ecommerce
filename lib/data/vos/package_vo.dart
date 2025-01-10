import 'package:json_annotation/json_annotation.dart';
part 'package_vo.g.dart';

@JsonSerializable()
class PackageVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "package_price")
  final int? packagePrice;

  @JsonKey(name: "benefits")
  final String? benefits;

  PackageVO({
    this.id,
    this.name,
    this.packagePrice,
    this.benefits
  });

  factory PackageVO.fromJson(Map<String, dynamic> json) =>
      _$PackageVOFromJson(json);

  Map<String, dynamic> toJson() => _$PackageVOToJson(this);
}
