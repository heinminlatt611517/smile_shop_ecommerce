// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackageDetailsResponse _$PackageDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    PackageDetailsResponse(
      status: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : PackageVO.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PackageDetailsResponseToJson(
        PackageDetailsResponse instance) =>
    <String, dynamic>{
      'status_code': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
