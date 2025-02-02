// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductVOAdapter extends TypeAdapter<ProductVO> {
  @override
  final int typeId = 3;

  @override
  ProductVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductVO(
      id: fields[0] as int?,
      name: fields[1] as String?,
      sku: fields[2] as String?,
      price: fields[5] as int?,
      brandId: fields[6] as int?,
      subcategoryId: fields[8] as int?,
      image: fields[9] as String?,
      subcategory: fields[11] as SubcategoryVO?,
      brand: fields[12] as BrandVO?,
      variantVO: (fields[13] as List?)?.cast<VariantVO>(),
      images: (fields[10] as List?)?.cast<String>(),
      rating: fields[7] as int?,
      description: fields[4] as String?,
      highlight: fields[3] as String?,
      qtyCount: fields[14] as int?,
      isChecked: fields[15] as bool?,
      totalPrice: fields[16] as int?,
      colorName: fields[17] as String?,
      isFavourite: fields[18] as bool?,
      size: fields[20] as String?,
      detailImages: (fields[23] as List?)?.cast<String>(),
      video: fields[22] as String?,
      specificationList: (fields[21] as List?)?.cast<SpecificationVO>(),
      isFavouriteProduct: fields[24] as bool?,
    )..isAddedToCartProduct = fields[19] as bool?;
  }

  @override
  void write(BinaryWriter writer, ProductVO obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sku)
      ..writeByte(3)
      ..write(obj.highlight)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.brandId)
      ..writeByte(7)
      ..write(obj.rating)
      ..writeByte(8)
      ..write(obj.subcategoryId)
      ..writeByte(9)
      ..write(obj.image)
      ..writeByte(10)
      ..write(obj.images)
      ..writeByte(11)
      ..write(obj.subcategory)
      ..writeByte(12)
      ..write(obj.brand)
      ..writeByte(13)
      ..write(obj.variantVO)
      ..writeByte(14)
      ..write(obj.qtyCount)
      ..writeByte(15)
      ..write(obj.isChecked)
      ..writeByte(16)
      ..write(obj.totalPrice)
      ..writeByte(17)
      ..write(obj.colorName)
      ..writeByte(18)
      ..write(obj.isFavourite)
      ..writeByte(19)
      ..write(obj.isAddedToCartProduct)
      ..writeByte(20)
      ..write(obj.size)
      ..writeByte(21)
      ..write(obj.specificationList)
      ..writeByte(22)
      ..write(obj.video)
      ..writeByte(23)
      ..write(obj.detailImages)
      ..writeByte(24)
      ..write(obj.isFavouriteProduct);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
      detailImages: (json['details_images'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      video: json['video'] as String?,
      specificationList: (json['specifications'] as List<dynamic>?)
          ?.map((e) => SpecificationVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      isFavouriteProduct: json['is_favourite'] as bool?,
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
      'specifications': instance.specificationList,
      'video': instance.video,
      'details_images': instance.detailImages,
      'is_favourite': instance.isFavouriteProduct,
    };
