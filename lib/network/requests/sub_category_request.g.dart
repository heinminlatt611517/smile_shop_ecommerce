// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubCategoryRequest _$SubCategoryRequestFromJson(Map<String, dynamic> json) =>
    SubCategoryRequest(
      categoryId: (json['category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubCategoryRequestToJson(SubCategoryRequest instance) =>
    <String, dynamic>{
      'category_id': instance.categoryId,
    };
