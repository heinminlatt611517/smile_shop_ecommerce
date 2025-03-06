import 'package:json_annotation/json_annotation.dart';

part 'check_wallet_password_request.g.dart';

@JsonSerializable()
class CheckWalletPasswordRequest {
  @JsonKey(name: "password")
  String? password;

  @JsonKey(name: "type", fromJson: _fromJson, toJson: _toJson)
  CheckPasswordType checkPasswordType;

  CheckWalletPasswordRequest(this.password, this.checkPasswordType);

  factory CheckWalletPasswordRequest.fromJson(Map<String, dynamic> json) => _$CheckWalletPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckWalletPasswordRequestToJson(this);

  // Custom JSON serialization logic
  static CheckPasswordType _fromJson(String type) {
    switch (type) {
      case 'set_password_check':
        return CheckPasswordType.setPasswordCheck;
      case 'check_password':
      default:
        return CheckPasswordType.checkPassword;
    }
  }

  static String _toJson(CheckPasswordType data) {
    switch (data) {
      case CheckPasswordType.setPasswordCheck:
        return 'set_password_check';
      case CheckPasswordType.checkPassword:
        return 'check_password';
    }
  }
}

enum CheckPasswordType {
  setPasswordCheck,
  checkPassword
}
