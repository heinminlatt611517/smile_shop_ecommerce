import 'package:json_annotation/json_annotation.dart';

part 'otp_vo.g.dart';

@JsonSerializable()
class OtpVO {
  @JsonKey(name: 'channel')
  final String? channel;

  @JsonKey(name: 'status')
  final bool? status;

  @JsonKey(name: 'request_id')
  final int? requestId;

  @JsonKey(name: 'to')
  final String? to;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'expire_at')
  final String? expireAt;

  @JsonKey(name: 'referral_code')
  final String? referralCode;

  OtpVO(
      {this.channel,
      this.status,
      this.requestId,
      this.to,
      this.createdAt,
      this.expireAt,
      this.referralCode});

  factory OtpVO.fromJson(Map<String, dynamic> json) => _$OtpVOFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVOToJson(this);
}
