// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_and_category_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandAndCategoryVO _$BrandAndCategoryVOFromJson(Map<String, dynamic> json) =>
    BrandAndCategoryVO(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      brands: (json['errors'] as List<dynamic>?)
          ?.map((e) => BrandVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BrandAndCategoryVOToJson(BrandAndCategoryVO instance) =>
    <String, dynamic>{
      'categories': instance.categories,
      'errors': instance.brands,
    };
