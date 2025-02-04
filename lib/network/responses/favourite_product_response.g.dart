// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteProductResponse _$FavouriteProductResponseFromJson(
        Map<String, dynamic> json) =>
    FavouriteProductResponse(
      statusCode: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FavouriteProductResponseToJson(
        FavouriteProductResponse instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'message': instance.message,
      'data': instance.data,
    };
