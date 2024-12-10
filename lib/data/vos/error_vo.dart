import 'package:json_annotation/json_annotation.dart';

part 'error_vo.g.dart';

@JsonSerializable()
class ErrorVO {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "errors")
  final List<String>? error;


  ErrorVO(
      { this.statusCode,
       this.message,
       this.error});

  factory ErrorVO.fromJson(Map<String, dynamic> json) =>
      _$ErrorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorVOToJson(this);
}
