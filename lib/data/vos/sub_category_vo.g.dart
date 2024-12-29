// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_category_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubcategoryVOAdapter extends TypeAdapter<SubcategoryVO> {
  @override
  final int typeId = 4;

  @override
  SubcategoryVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubcategoryVO(
      id: fields[0] as int?,
      categoryId: fields[1] as int?,
      name: fields[2] as String?,
      image: fields[3] as String?,
      category: fields[4] as CategoryVO?,
    );
  }

  @override
  void write(BinaryWriter writer, SubcategoryVO obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.categoryId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubcategoryVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubcategoryVO _$SubcategoryVOFromJson(Map<String, dynamic> json) =>
    SubcategoryVO(
      id: (json['id'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      name: json['name'] as String?,
      image: json['image'] as String?,
      category: json['category'] == null
          ? null
          : CategoryVO.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SubcategoryVOToJson(SubcategoryVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category_id': instance.categoryId,
      'name': instance.name,
      'image': instance.image,
      'category': instance.category,
    };
