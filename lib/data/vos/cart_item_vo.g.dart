// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartVOAdapter extends TypeAdapter<CartItemVo> {
  @override
  final int typeId = 14;

  @override
  CartItemVo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartItemVo(
      productId: fields[0] as int?,
      productName: fields[1] as String?,
      image: fields[2] as String?,
      price: fields[3] as int?,
      promotionPoint: fields[4] as int?,
      color: fields[5] as String?,
      size: fields[6] as String?,
      variantId: fields[7] as String?,
      quantity: fields[8] as int?,
      isSelected: fields[9] as bool?,
      variantPrice: fields[10] as int?,
      subCategory: fields[11] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemVo obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.promotionPoint)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.size)
      ..writeByte(7)
      ..write(obj.variantId)
      ..writeByte(8)
      ..write(obj.quantity)
      ..writeByte(9)
      ..write(obj.isSelected)
      ..writeByte(10)
      ..write(obj.variantPrice)
      ..writeByte(11)
      ..write(obj.subCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
