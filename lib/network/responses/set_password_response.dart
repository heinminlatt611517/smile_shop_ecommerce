import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/user_vo.dart';

part 'set_password_response.g.dart';

@JsonSerializable()
class SetPasswordResponse {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final UserVO? data;

  SetPasswordResponse(
      {this.statusCode,
      this.message,
      this.data,
      });

  factory SetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$SetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SetPasswordResponseToJson(this);
}
