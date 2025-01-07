
import 'package:json_annotation/json_annotation.dart';

import 'message_vo.dart';

part 'chat_vo.g.dart';

@JsonSerializable()
class ChatVo {
  @JsonKey(name: 'chatId')
  String? chatId;
  @JsonKey(name: 'userId')
  String? userId;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'status')
  String? status;
  @JsonKey(name: 'createdBy')
  String? createdBy;
  @JsonKey(name: 'assignedTo')
  String? assignedTo;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'messages')
  List<MessageVo>? messages;

  ChatVo({
    this.chatId,
    this.userId,
    this.title,
    this.description,
    this.status,
    this.createdBy,
    this.assignedTo,
    this.createdAt,
    this.updatedAt,
  });

  factory ChatVo.fromJson(Map<String, dynamic> json) => _$ChatVoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatVoToJson(this);
}
