// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_password_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetPasswordRequest _$SetPasswordRequestFromJson(Map<String, dynamic> json) =>
    SetPasswordRequest(
      json['request_id'] as String?,
      json['password'] as String?,
      json['password_confirmation'] as String?,
      json['phone'] as String?,
    );

Map<String, dynamic> _$SetPasswordRequestToJson(SetPasswordRequest instance) =>
    <String, dynamic>{
      'request_id': instance.requestId,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'phone': instance.phone,
    };
