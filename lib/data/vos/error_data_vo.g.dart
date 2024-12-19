// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorDataVO _$ErrorDataVOFromJson(Map<String, dynamic> json) => ErrorDataVO(
      password: (json['password'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      type: (json['type'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ErrorDataVOToJson(ErrorDataVO instance) =>
    <String, dynamic>{
      'password': instance.password,
      'type': instance.type,
    };
