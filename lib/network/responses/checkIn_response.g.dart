// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkIn_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInResponse _$CheckInResponseFromJson(Map<String, dynamic> json) =>
    CheckInResponse(
      status: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      checkInVO: json['data'] == null
          ? null
          : CheckInVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckInResponseToJson(CheckInResponse instance) =>
    <String, dynamic>{
      'status_code': instance.status,
      'message': instance.message,
      'data': instance.checkInVO,
    };
