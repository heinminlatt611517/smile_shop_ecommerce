// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryVO _$CategoryVOFromJson(Map<String, dynamic> json) => CategoryVO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      subCategories: (json['subcategory'] as List<dynamic>?)
          ?.map((e) => SubcategoryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryVOToJson(CategoryVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subcategory': instance.subCategories,
    };
