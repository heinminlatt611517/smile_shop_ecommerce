// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pop_up_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopupRequest _$PopupRequestFromJson(Map<String, dynamic> json) => PopupRequest(
      (json['user_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PopupRequestToJson(PopupRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
    };
