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
  final ErrorDataVO? errorData;

  @JsonKey(name: "data")
  final ErrorDataVO? data;

  @JsonKey(name: "error")
  final String? error;

  ErrorVO({this.statusCode, this.message, this.errorData,this.data, this.error});

  factory ErrorVO.fromJson(Map<String, dynamic> json) =>
      _$ErrorVOFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorVOToJson(this);

  String? getErrorMessages() {
    if (data != null && data!.message != null && data!.message!.isNotEmpty) {
      return data!.message;
    }

    if (errorData == null) return message ?? error;

    List<String> errors = [];

    if (errorData?.password != null) {
      errors.add(errorData!.password!);
    }
    if (errorData?.isDefaultAddress != null) {
      errors.add(errorData!.isDefaultAddress!);
    }
    if (errorData?.type != null) {
      errors.add(errorData!.type!);
    }
    if (errorData?.message != null) {
      errors.add(errorData!.message!);
    }
    if (errorData?.phone != null) {
      errors.add(errorData!.phone!);
    }

    return errors.isNotEmpty ? errors.join('\n') : message ?? error;
  }

}
