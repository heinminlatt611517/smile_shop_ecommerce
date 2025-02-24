// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerVO _$BannerVOFromJson(Map<String, dynamic> json) => BannerVO(
      id: (json['id'] as num?)?.toInt(),
      sort: (json['sort'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      sourceUrl: json['url'] as String?,
      mediaType: json['media_type'] as String?,
    );

Map<String, dynamic> _$BannerVOToJson(BannerVO instance) => <String, dynamic>{
      'id': instance.id,
      'sort': instance.sort,
      'status': instance.status,
      'url': instance.sourceUrl,
      'media_type': instance.mediaType,
    };
