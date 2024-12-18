// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'township_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TownshipResponse _$TownshipResponseFromJson(Map<String, dynamic> json) =>
    TownshipResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      townshipDataVO: json['data'] == null
          ? null
          : TownshipDataVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TownshipResponseToJson(TownshipResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.townshipDataVO,
    };
