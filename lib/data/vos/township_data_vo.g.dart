// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'township_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TownshipDataVO _$TownshipDataVOFromJson(Map<String, dynamic> json) =>
    TownshipDataVO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      townships: (json['townships'] as List<dynamic>?)
          ?.map((e) => TownshipVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TownshipDataVOToJson(TownshipDataVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'townships': instance.townships,
    };
