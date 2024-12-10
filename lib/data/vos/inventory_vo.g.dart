// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryVO _$InventoryVOFromJson(Map<String, dynamic> json) => InventoryVO(
      id: (json['id'] as num?)?.toInt(),
      productVariantId: (json['product_variant_id'] as num?)?.toInt(),
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
      quantity: json['quantity'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      deletedAt: json['deleted_at'] as String?,
    );

Map<String, dynamic> _$InventoryVOToJson(InventoryVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_variant_id': instance.productVariantId,
      'warehouse_id': instance.warehouseId,
      'quantity': instance.quantity,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
