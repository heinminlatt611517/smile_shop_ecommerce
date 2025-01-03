import 'package:json_annotation/json_annotation.dart';

part 'check_wallet_password_request.g.dart';

@JsonSerializable()
class CheckWalletPasswordRequest {
  @JsonKey(name: "password")
  String? password;

  CheckWalletPasswordRequest(this.password);

  factory CheckWalletPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckWalletPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckWalletPasswordRequestToJson(this);
}
