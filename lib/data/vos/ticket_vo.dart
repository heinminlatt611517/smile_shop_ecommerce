
import 'package:json_annotation/json_annotation.dart';
import 'message_vo.dart';

part 'ticket_vo.g.dart';

@JsonSerializable()
class TicketVo {
  @JsonKey(name: 'ticketId')
  String? ticketId;
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

  TicketVo({
    this.ticketId,
    this.title,
    this.description,
    this.status,
    this.createdBy,
    this.assignedTo,
    this.createdAt,
    this.updatedAt,
  });

  factory TicketVo.fromJson(Map<String, dynamic> json) => _$TicketVoFromJson(json); 

  Map<String, dynamic> toJson() => _$TicketVoToJson(this);
}
