import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../persistence/hive_constants.dart';
part 'image_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: kHiveTypeImageVO, adapterName: kAdapterImageVO)
class ImageVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  final int? id;

  @JsonKey(name: 'url')
  @HiveField(1)
  final String? url;

  ImageVO({this.id, this.url});

  factory ImageVO.fromJson(Map<String, dynamic> json) => _$ImageVOFromJson(json);

  Map<String, dynamic> toJson() => _$ImageVOToJson(this);
}