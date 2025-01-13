// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorVO _$ErrorVOFromJson(Map<String, dynamic> json) => ErrorVO(
      statusCode: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['errors'] == null
          ? null
          : ErrorDataVO.fromJson(json['errors'] as Map<String, dynamic>),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ErrorVOToJson(ErrorVO instance) => <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
      'errors': instance.data,
      'error': instance.error,
    };
