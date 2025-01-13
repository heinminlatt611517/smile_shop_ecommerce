import 'package:json_annotation/json_annotation.dart';

part 'message_vo.g.dart';

@JsonSerializable()
class MessageVo {
  @JsonKey(name: 'senderId')
  String? senderId;
  @JsonKey(name: 'messageType')
  String? messageType;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'attachmentUrl')
  String? attachmentUrl;
  @JsonKey(name: 'sentAt')
  String? sentAt;
  @JsonKey(name: 'isRead')
  bool? isRead;
  @JsonKey(name: 'isAdmin')
  bool? isAdmin;

  MessageVo({
    this.senderId,
    this.messageType,
    this.message,
    this.attachmentUrl,
    this.sentAt,
    this.isRead,
    this.isAdmin
  });

  factory MessageVo.fromJson(Map<String, dynamic> json) => _$MessageVoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageVoToJson(this);
}
