// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'township_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TownshipVO _$TownshipVOFromJson(Map<String, dynamic> json) => TownshipVO(
      id: (json['id'] as num?)?.toInt(),
      stateId: (json['state_id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$TownshipVOToJson(TownshipVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'state_id': instance.stateId,
      'name': instance.name,
    };
