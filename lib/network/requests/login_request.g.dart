// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      json['phone'] as String?,
      json['type'] as String?,
      json['password'] as String?,
      json['fcm_token'] as String?,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'type': instance.type,
      'password': instance.password,
      'fcm_token': instance.fcmToken,
    };
