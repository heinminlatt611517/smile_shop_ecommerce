// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CategoryVOAdapter extends TypeAdapter<CategoryVO> {
  @override
  final int typeId = 5;

  @override
  CategoryVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CategoryVO(
      id: fields[0] as int?,
      name: fields[1] as String?,
      subCategories: (fields[2] as List?)?.cast<SubcategoryVO>(),
      image: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CategoryVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.subCategories)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CategoryVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryVO _$CategoryVOFromJson(Map<String, dynamic> json) => CategoryVO(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      subCategories: (json['subcategory'] as List<dynamic>?)
          ?.map((e) => SubcategoryVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$CategoryVOToJson(CategoryVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'subcategory': instance.subCategories,
      'image': instance.image,
    };
