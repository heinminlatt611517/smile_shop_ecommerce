// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVo _$MessageVoFromJson(Map<String, dynamic> json) => MessageVo(
      senderId: json['senderId'] as String?,
      messageType: json['messageType'] as String?,
      message: json['message'] as String?,
      attachmentUrl: json['attachmentUrl'] as String?,
      sentAt: json['sentAt'] as String?,
      isRead: json['isRead'] as bool?,
      isAdmin: json['isAdmin'] as bool?,
    );

Map<String, dynamic> _$MessageVoToJson(MessageVo instance) => <String, dynamic>{
      'senderId': instance.senderId,
      'messageType': instance.messageType,
      'message': instance.message,
      'attachmentUrl': instance.attachmentUrl,
      'sentAt': instance.sentAt,
      'isRead': instance.isRead,
      'isAdmin': instance.isAdmin,
    };
