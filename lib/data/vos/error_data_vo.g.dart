// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorDataVO _$ErrorDataVOFromJson(Map<String, dynamic> json) => ErrorDataVO(
      password: json['password'] as String?,
      isDefaultAddress: json['is_default'] as String?,
      type: json['type'] as String?,
      message: json['message'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$ErrorDataVOToJson(ErrorDataVO instance) =>
    <String, dynamic>{
      'password': instance.password,
      'is_default': instance.isDefaultAddress,
      'type': instance.type,
      'message': instance.message,
      'phone': instance.phone,
    };
