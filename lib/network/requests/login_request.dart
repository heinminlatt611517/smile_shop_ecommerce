import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "password")
  String? password;

  LoginRequest(this.phone,this.type, this.password);

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
