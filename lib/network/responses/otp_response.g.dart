// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpResponse _$OtpResponseFromJson(Map<String, dynamic> json) => OtpResponse(
      status: (json['status'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : OtpVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OtpResponseToJson(OtpResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };
