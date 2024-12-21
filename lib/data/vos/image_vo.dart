import 'package:json_annotation/json_annotation.dart';
part 'image_vo.g.dart';

@JsonSerializable()
class ImageVO {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'url')
  final String? url;

  ImageVO({this.id, this.url});

  factory ImageVO.fromJson(Map<String, dynamic> json) => _$ImageVOFromJson(json);

  Map<String, dynamic> toJson() => _$ImageVOToJson(this);
}