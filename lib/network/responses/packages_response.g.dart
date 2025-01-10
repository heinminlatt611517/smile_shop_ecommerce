// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'packages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PackagesResponse _$PackagesResponseFromJson(Map<String, dynamic> json) =>
    PackagesResponse(
      status: (json['status_code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PackageVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PackagesResponseToJson(PackagesResponse instance) =>
    <String, dynamic>{
      'status_code': instance.status,
      'message': instance.message,
      'data': instance.data,
    };
