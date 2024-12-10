import 'package:json_annotation/json_annotation.dart';

part 'otp_request.g.dart';

@JsonSerializable()
class OtpRequest {
  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "code")
  String? code;

  OtpRequest(this.phone,this.code);

  factory OtpRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OtpRequestToJson(this);
}
