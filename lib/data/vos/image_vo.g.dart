// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageVOAdapter extends TypeAdapter<ImageVO> {
  @override
  final int typeId = 10;

  @override
  ImageVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageVO(
      id: fields[0] as int?,
      url: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ImageVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageVO _$ImageVOFromJson(Map<String, dynamic> json) => ImageVO(
      id: (json['id'] as num?)?.toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ImageVOToJson(ImageVO instance) => <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };
