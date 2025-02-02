// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_product_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouriteProductRequest _$FavouriteProductRequestFromJson(
        Map<String, dynamic> json) =>
    FavouriteProductRequest(
      productId: (json['product_id'] as num?)?.toInt(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$FavouriteProductRequestToJson(
        FavouriteProductRequest instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'status': instance.status,
    };
