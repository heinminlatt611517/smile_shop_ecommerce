// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationListResponse _$NotificationListResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationListResponse(
      statusCode: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NotificationVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationListResponseToJson(
        NotificationListResponse instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
