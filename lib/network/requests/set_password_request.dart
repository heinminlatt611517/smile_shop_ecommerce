import 'package:json_annotation/json_annotation.dart';

part 'set_password_request.g.dart';

@JsonSerializable()
class SetPasswordRequest {
  @JsonKey(name: "request_id")
  String? requestId;

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "password_confirmation")
  String? passwordConfirmation;

  @JsonKey(name: "phone")
  String? phone;


  SetPasswordRequest(this.requestId,this.password, this.passwordConfirmation,this.phone);

  factory SetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$SetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SetPasswordRequestToJson(this);
}
