// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressCategoriesResponse _$AddressCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    AddressCategoriesResponse(
      status: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CategoryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AddressCategoriesResponseToJson(
        AddressCategoriesResponse instance) =>
    <String, dynamic>{
      'status_code': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
