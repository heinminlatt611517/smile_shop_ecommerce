import 'package:json_annotation/json_annotation.dart';

part 'error_data_vo.g.dart';

@JsonSerializable()
class ErrorDataVO {
  @JsonKey(name: 'password')
  final List<String>? password;

  @JsonKey(name: 'type')
  final List<String>? type;


  ErrorDataVO({this.password, this.type});

  factory ErrorDataVO.fromJson(Map<String, dynamic> json) =>
      _$ErrorDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDataVOToJson(this);
}