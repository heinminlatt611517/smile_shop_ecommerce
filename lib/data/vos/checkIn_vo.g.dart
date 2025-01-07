// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkIn_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckInVO _$CheckInVOFromJson(Map<String, dynamic> json) => CheckInVO(
      id: (json['id'] as num?)?.toInt(),
      userId: (json['user_id'] as num?)?.toInt(),
      userType: json['user_type'] as String?,
      currentCheckInDay: (json['current_check_in_day'] as num?)?.toInt(),
      totalCheckInPoint: (json['total_check_in_point'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CheckInVOToJson(CheckInVO instance) => <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'user_type': instance.userType,
      'current_check_in_day': instance.currentCheckInDay,
      'total_check_in_point': instance.totalCheckInPoint,
    };
