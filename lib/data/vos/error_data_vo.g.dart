// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorDataVO _$ErrorDataVOFromJson(Map<String, dynamic> json) => ErrorDataVO(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      requestId: json['request_id'] as String?,
    );

Map<String, dynamic> _$ErrorDataVOToJson(ErrorDataVO instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'request_id': instance.requestId,
    };
