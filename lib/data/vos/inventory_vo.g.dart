// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventoryVOAdapter extends TypeAdapter<InventoryVO> {
  @override
  final int typeId = 12;

  @override
  InventoryVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InventoryVO(
      id: fields[0] as int?,
      productVariantId: fields[1] as int?,
      warehouseId: fields[2] as int?,
      quantity: fields[3] as int?,
      createdAt: fields[4] as String?,
      updatedAt: fields[5] as String?,
      deletedAt: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, InventoryVO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productVariantId)
      ..writeByte(2)
      ..write(obj.warehouseId)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.deletedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventoryVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryVO _$InventoryVOFromJson(Map<String, dynamic> json) => InventoryVO(
      id: (json['id'] as num?)?.toInt(),
      productVariantId: (json['product_variant_id'] as num?)?.toInt(),
      warehouseId: (json['warehouse_id'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toInt(),
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
