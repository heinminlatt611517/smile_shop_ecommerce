// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateResponse _$StateResponseFromJson(Map<String, dynamic> json) =>
    StateResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StateVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StateResponseToJson(StateResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
