// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'specification_vo.g.dart';

@JsonSerializable()
class SpecificationVO {
  @JsonKey(name: 'key')
  String? key;
  @JsonKey(name: 'value')
  String? value;
  @JsonKey(name: 'language')
  String? language;
  SpecificationVO({
    this.key,
    this.value,
    this.language,
  });

  factory SpecificationVO.fromJson(Map<String, dynamic> json) => _$SpecificationVOFromJson(json);

  Map<String, dynamic> toJson() => _$SpecificationVOToJson(this);
}
