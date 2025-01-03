import 'package:json_annotation/json_annotation.dart';

part 'set_wallet_password_request.g.dart';

@JsonSerializable()
class SetWalletPasswordRequest {

  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "password_confirmation")
  String? passwordConfirmation;


  SetWalletPasswordRequest(this.password, this.passwordConfirmation);

  factory SetWalletPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$SetWalletPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SetWalletPasswordRequestToJson(this);
}
