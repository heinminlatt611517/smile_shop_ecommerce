// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dealer_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DealerLoginRequest _$DealerLoginRequestFromJson(Map<String, dynamic> json) =>
    DealerLoginRequest(
      json['email'] as String?,
      json['type'] as String?,
      json['password'] as String?,
      json['fcm_token'] as String?,
    );

Map<String, dynamic> _$DealerLoginRequestToJson(DealerLoginRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'type': instance.type,
      'password': instance.password,
      'fcm_token': instance.fcmToken,
    };
