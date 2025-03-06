// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_product_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SearchProductVOAdapter extends TypeAdapter<SearchProductVO> {
  @override
  final int typeId = 2;

  @override
  SearchProductVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SearchProductVO(
      name: fields[0] as String?,
      timeStamp: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SearchProductVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.timeStamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchProductVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
