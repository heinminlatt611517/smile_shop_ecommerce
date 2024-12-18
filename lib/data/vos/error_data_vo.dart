import 'package:json_annotation/json_annotation.dart';

part 'error_data_vo.g.dart';

@JsonSerializable()
class ErrorDataVO {
  @JsonKey(name: 'status')
  final bool? status;

  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'request_id')
  final String? requestId;


  ErrorDataVO({this.status, this.message,this.requestId});

  factory ErrorDataVO.fromJson(Map<String, dynamic> json) =>
      _$ErrorDataVOFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDataVOToJson(this);
}