// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SetPasswordResponse _$SetPasswordResponseFromJson(Map<String, dynamic> json) =>
    SetPasswordResponse(
      statusCode: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : UserVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SetPasswordResponseToJson(
        SetPasswordResponse instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
