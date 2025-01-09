import 'package:json_annotation/json_annotation.dart';

part 'dealer_login_request.g.dart';

@JsonSerializable()
class DealerLoginRequest {
  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "type")
  String? type;

  @JsonKey(name: "password")
  String? password;

  DealerLoginRequest(this.email,this.type, this.password);

  factory DealerLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$DealerLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DealerLoginRequestToJson(this);
}