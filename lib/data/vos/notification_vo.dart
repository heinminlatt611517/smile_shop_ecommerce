// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'notification_vo.g.dart';

@JsonSerializable()
class NotificationVO {
  @JsonKey(name: 'id', fromJson: _fromJsonInt, toJson: _toJsonInt)
  int? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'title_en')
  String? titleEn;

  @JsonKey(name: 'title_ch')
  String? titleCh;

  @JsonKey(name: 'title_my-MM')
  String? titleMyMM;

  @JsonKey(name: 'short_content')
  String? shortContent;

  @JsonKey(name: 'short_content_en')
  String? shortContentEn;

  @JsonKey(name: 'short_content_ch')
  String? shortContentCh;

  @JsonKey(name: 'short_content_my-MM')
  String? shortContentMyMM;

  @JsonKey(name: 'content')
  String? content;

  @JsonKey(name: 'content_en')
  String? contentEn;

  @JsonKey(name: 'content_ch')
  String? contentCh;

  @JsonKey(name: 'content_my-MM')
  String? contentMyMM;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'sort', fromJson: _fromJsonInt, toJson: _toJsonInt)
  int? sort;

  @JsonKey(name: 'status', fromJson: _fromJsonInt, toJson: _toJsonInt)
  int? status;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  @JsonKey(name: '__type')
  String? notiType;

  NotificationVO({
    this.id,
    this.title,
    this.titleEn,
    this.titleCh,
    this.titleMyMM,
    this.shortContent,
    this.shortContentEn,
    this.shortContentCh,
    this.shortContentMyMM,
    this.content,
    this.contentEn,
    this.contentCh,
    this.contentMyMM,
    this.image,
    this.sort,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.notiType,
  });

  factory NotificationVO.fromJson(Map<String, dynamic> json) => _$NotificationVOFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationVOToJson(this);

  // Custom fromJson function to handle int conversion
  static int? _fromJsonInt(dynamic value) {
    return int.tryParse(value.toString()) ?? 0; // Default to 0 if parsing fails
  }

  // Custom toJson function to handle int conversion
  static int? _toJsonInt(int? value) {
    return value;
  }

  @override
  String toString() {
    return 'NotificationVO(id: $id, title: $title, titleEn: $titleEn, titleCh: $titleCh, titleMyMM: $titleMyMM, shortContent: $shortContent, shortContentEn: $shortContentEn, shortContentCh: $shortContentCh, shortContentMyMM: $shortContentMyMM, content: $content, contentEn: $contentEn, contentCh: $contentCh, contentMyMM: $contentMyMM, image: $image, sort: $sort, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
