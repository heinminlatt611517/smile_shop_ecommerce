// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandVO _$BrandVOFromJson(Map<String, dynamic> json) => BrandVO(
      id: (json['id'] as num?)?.toInt(),
      nameEn: json['name_en'] as String?,
    );

Map<String, dynamic> _$BrandVOToJson(BrandVO instance) => <String, dynamic>{
      'id': instance.id,
      'name_en': instance.nameEn,
    };
