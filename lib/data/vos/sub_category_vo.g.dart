// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubcategoryVO _$SubcategoryVOFromJson(Map<String, dynamic> json) =>
    SubcategoryVO(
      id: (json['id'] as num?)?.toInt(),
      categoryId: json['category_id'] as String?,
      name: json['name'] as String?,
      category: json['category'] == null
          ? null
          : CategoryVO.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubcategoryVOToJson(SubcategoryVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'name': instance.name,
      'category': instance.category,
    };
