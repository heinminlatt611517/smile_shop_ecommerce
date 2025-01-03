// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'success_network_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuccessNetworkResponse _$SuccessNetworkResponseFromJson(
        Map<String, dynamic> json) =>
    SuccessNetworkResponse(
      status: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SuccessNetworkResponseToJson(
        SuccessNetworkResponse instance) =>
    <String, dynamic>{
      'status_code': instance.status,
      'message': instance.message,
    };
