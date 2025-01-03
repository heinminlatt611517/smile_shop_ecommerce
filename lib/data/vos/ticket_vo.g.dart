// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketVo _$TicketVoFromJson(Map<String, dynamic> json) => TicketVo(
      ticketId: json['ticketId'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      status: json['status'] as String?,
      createdBy: json['createdBy'] as String?,
      assignedTo: json['assignedTo'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    )..messages = (json['messages'] as List<dynamic>?)
        ?.map((e) => MessageVo.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$TicketVoToJson(TicketVo instance) => <String, dynamic>{
      'ticketId': instance.ticketId,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'assignedTo': instance.assignedTo,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'messages': instance.messages,
    };
