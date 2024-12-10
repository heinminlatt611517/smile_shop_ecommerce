import 'package:json_annotation/json_annotation.dart';
part 'banner_vo.g.dart';

@JsonSerializable()
class BannerVO {
  @JsonKey(name: "id")
  final int? id;

  @JsonKey(name: "sort")
  final int? sort;

  @JsonKey(name: "status")
  final int? status;

  @JsonKey(name: "image")
  final String? image;

  BannerVO({
    this.id,
    this.sort,
    this.status,
    this.image
  });

  factory BannerVO.fromJson(Map<String, dynamic> json) =>
      _$BannerVOFromJson(json);

  Map<String, dynamic> toJson() => _$BannerVOToJson(this);
}
