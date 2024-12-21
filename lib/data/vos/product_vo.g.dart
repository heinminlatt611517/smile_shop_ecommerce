// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductVO _$ProductVOFromJson(Map<String, dynamic> json) => ProductVO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      sku: json['sku'] as String?,
      price: (json['price'] as num?)?.toInt(),
      brandId: (json['brand_id'] as num?)?.toInt(),
      subcategoryId: (json['subcategory_id'] as num?)?.toInt(),
      image: json['image'] as String?,
      subcategory: json['subcategory'] == null
          ? null
          : SubcategoryVO.fromJson(json['subcategory'] as Map<String, dynamic>),
      brand: json['brand'] == null
          ? null
          : BrandVO.fromJson(json['brand'] as Map<String, dynamic>),
      variantVO: (json['variant'] as List<dynamic>?)
          ?.map((e) => VariantVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      rating: (json['rating'] as num?)?.toInt(),
      description: json['description'] as String?,
      highlight: json['highlight'] as String?,
    );

Map<String, dynamic> _$ProductVOToJson(ProductVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sku': instance.sku,
      'highlight': instance.highlight,
      'description': instance.description,
      'price': instance.price,
      'brand_id': instance.brandId,
      'rating': instance.rating,
      'subcategory_id': instance.subcategoryId,
      'image': instance.image,
      'images': instance.images,
      'subcategory': instance.subcategory,
      'brand': instance.brand,
      'variant': instance.variantVO,
    };
