// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseDataVO _$ProductResponseDataVOFromJson(
        Map<String, dynamic> json) =>
    ProductResponseDataVO(
      currentPage: (json['current_page'] as num?)?.toInt(),
      products: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductResponseDataVOToJson(
        ProductResponseDataVO instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'data': instance.products,
    };
