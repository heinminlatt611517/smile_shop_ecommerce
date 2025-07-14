import 'package:json_annotation/json_annotation.dart';
import 'package:smile_shop/data/vos/otp_vo.dart';

part 'otp_response.g.dart';

@JsonSerializable()
class OtpResponse {
  @JsonKey(name: "status_code")
  final int? status;

  @JsonKey(name: "data")
  final OtpVO? data;

  OtpResponse(
      {this.status,
      this.data,
      });

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OtpResponseToJson(this);
}
