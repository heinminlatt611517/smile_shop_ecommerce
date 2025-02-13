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

  @JsonKey(name: "url")
  final String? sourceUrl;

  @JsonKey(name: "media_type")
  final String? mediaType;

  bool isImage() => mediaType == "image";

  BannerVO({this.id, this.sort, this.status, this.sourceUrl, this.mediaType});

  factory BannerVO.fromJson(Map<String, dynamic> json) => _$BannerVOFromJson(json);

  Map<String, dynamic> toJson() => _$BannerVOToJson(this);
}
