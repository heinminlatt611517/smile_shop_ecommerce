// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_team_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyTeamResponse _$MyTeamResponseFromJson(Map<String, dynamic> json) =>
    MyTeamResponse(
      status: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MyTeamVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MyTeamResponseToJson(MyTeamResponse instance) =>
    <String, dynamic>{
      'status_code': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
