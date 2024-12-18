import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/error_data_vo.dart';

part 'error_vo.g.dart';

@JsonSerializable()
class ErrorVO {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "errors")
  final List<String>? error;

  @JsonKey(name: "data")
  final ErrorDataVO? errorDataVO;

  ErrorVO({this.statusCode, this.message, this.error,this.errorDataVO});

  factory ErrorVO.fromJson(Map<String, dynamic> json) =>
      _$ErrorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorVOToJson(this);

  String getErrorMessage() {
    if (error != null && error!.isNotEmpty) {
      return error!.join(', ');
    }
    if(errorDataVO != null){
      return errorDataVO?.message ?? "";
    }
    return message ?? '';
  }
}
