// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brands_and_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandsAndCategoriesResponse _$BrandsAndCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    BrandsAndCategoriesResponse(
      statusCode: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : BrandAndCategoryVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BrandsAndCategoriesResponseToJson(
        BrandsAndCategoriesResponse instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
