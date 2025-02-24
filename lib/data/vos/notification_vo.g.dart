// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationVO _$NotificationVOFromJson(Map<String, dynamic> json) =>
    NotificationVO(
      id: NotificationVO._fromJsonInt(json['id']),
      title: json['title'] as String?,
      titleEn: json['title_en'] as String?,
      titleCh: json['title_ch'] as String?,
      titleMyMM: json['title_my-MM'] as String?,
      shortContent: json['short_content'] as String?,
      shortContentEn: json['short_content_en'] as String?,
      shortContentCh: json['short_content_ch'] as String?,
      shortContentMyMM: json['short_content_my-MM'] as String?,
      content: json['content'] as String?,
      contentEn: json['content_en'] as String?,
      contentCh: json['content_ch'] as String?,
      contentMyMM: json['content_my-MM'] as String?,
      image: json['image'] as String?,
      sort: NotificationVO._fromJsonInt(json['sort']),
      status: NotificationVO._fromJsonInt(json['status']),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      notiType: json['__type'] as String?,
    );

Map<String, dynamic> _$NotificationVOToJson(NotificationVO instance) =>
    <String, dynamic>{
      'id': NotificationVO._toJsonInt(instance.id),
      'title': instance.title,
      'title_en': instance.titleEn,
      'title_ch': instance.titleCh,
      'title_my-MM': instance.titleMyMM,
      'short_content': instance.shortContent,
      'short_content_en': instance.shortContentEn,
      'short_content_ch': instance.shortContentCh,
      'short_content_my-MM': instance.shortContentMyMM,
      'content': instance.content,
      'content_en': instance.contentEn,
      'content_ch': instance.contentCh,
      'content_my-MM': instance.contentMyMM,
      'image': instance.image,
      'sort': NotificationVO._toJsonInt(instance.sort),
      'status': NotificationVO._toJsonInt(instance.status),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      '__type': instance.notiType,
    };
