// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVO _$OtpVOFromJson(Map<String, dynamic> json) => OtpVO(
      channel: json['channel'] as String?,
      status: json['status'] as bool?,
      requestId: (json['request_id'] as num?)?.toInt(),
      to: json['to'] as String?,
      createdAt: json['created_at'] as String?,
      expireAt: json['expire_at'] as String?,
      referralCode: json['referral_code'] as String?,
    );

Map<String, dynamic> _$OtpVOToJson(OtpVO instance) => <String, dynamic>{
      'channel': instance.channel,
      'status': instance.status,
      'request_id': instance.requestId,
      'to': instance.to,
      'created_at': instance.createdAt,
      'expire_at': instance.expireAt,
      'referral_code': instance.referralCode,
    };
