import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/login_data_vo.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "status_code")
  final int? statusCode;

  @JsonKey(name: "message")
  final String? message;

  @JsonKey(name: "data")
  final LoginDataVO? data;

  LoginResponse(
      {this.statusCode,
      this.message,
      this.data,
      });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
