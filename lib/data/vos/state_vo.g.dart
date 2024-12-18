// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateVO _$StateVOFromJson(Map<String, dynamic> json) => StateVO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$StateVOToJson(StateVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
